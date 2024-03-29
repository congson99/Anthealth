import 'package:anthealth_mobile/blocs/app_cubit.dart';
import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/blocs/language/language_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/post/post_models.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/views/common_pages/error_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_dashboard_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/info_popup.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/common_widgets/warning_popup.dart';
import 'package:anthealth_mobile/views/post/post_page.dart';
import 'package:anthealth_mobile/views/settings/family_settings_page.dart';
import 'package:anthealth_mobile/views/settings/general/setting_language_page.dart';
import 'package:anthealth_mobile/views/settings/settings_profile_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewSettingsPage extends StatelessWidget {
  const NewSettingsPage({Key? key, required this.user, required this.lang})
      : super(key: key);

  final User user;
  final String lang;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, CubitState>(builder: (context, state) {
      if (state is SettingsState)
        return TemplateDashboardPage(
            title: S.of(context).Welcome,
            name: user.name,
            isHeader: false,
            content: buildContent(context));
      else
        return CustomErrorPage();
    });
  }

  Widget buildContent(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      buildUserInfo(context),
      buildGeneral(context),
      buildLogout(context),
    ]);
  }

  Widget buildUserInfo(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 32),
        ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: Image.network(
              (user.avatarPath == "")
                  ? "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"
                  : user.avatarPath,
              height: 80.0,
              width: 80.0,
              fit: BoxFit.cover),
        ),
        SizedBox(height: 12),
        Text(user.name,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: AnthealthColors.black1)),
        SizedBox(height: 32),
      ],
    );
  }

  Widget buildGeneral(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SectionComponent(
          title: S.of(context).Profile_info,
          colorID: 3,
          iconPath: "assets/app_icon/common/user_bla0.png",
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => SettingsProfilePage(
                    user: user,
                    appContext: context,
                  )))),
      SizedBox(height: 16),
      SectionComponent(
          title: S.of(context).Family,
          iconPath: "assets/app_icon/small_icons/family.png",
          colorID: 2,
          onTap: () {
            BlocProvider.of<DashboardCubit>(context)
                .getMemberData()
                .then((value) {
              if (value.isNotEmpty)
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) =>
                        FamilySettingsPage(memberData: value, user: user)));
              else
                noFamilyPopup(context);
            });
          }),
      SizedBox(height: 16),
      CustomDivider.common(),
      SizedBox(height: 16),
      SectionComponent(
          title: S.of(context).Language,
          iconPath: "assets/app_icon/common/language_sec0.png",
          colorID: 1,
          onTap: () {
            getLanguage().then((value) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => SettingLanguagePage(
                      languageID: value,
                      update: (result) {
                        BlocProvider.of<LanguageCubit>(context)
                            .updateLanguage(result, context);
                      })));
            });
          }),
      SizedBox(height: 16),
      SectionComponent(
          title: S.of(context).About_us,
          iconPath: "assets/app_icon/common/info_pri0.png",
          colorID: 0,
          onTap: () => Post.fromJson("assets/hardData/about_us.json").then(
              (value) => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => PostPage(post: value))))),
      SizedBox(height: 16),
      CustomDivider.common(),
      SizedBox(height: 16)
    ]);
  }

  Widget buildLogout(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SectionComponent(
          title: S.of(context).Logout,
          iconPath: "assets/app_icon/common/out_war0.png",
          isDirection: false,
          colorID: 2,
          onTap: () {
            BlocProvider.of<AppCubit>(context).logout();
          }),
      SizedBox(height: 16),
      // GestureDetector(
      //     onTap: () => removeAccount(context),
      //     child: Text(S.of(context).Remove_account,
      //         textAlign: TextAlign.center,
      //         style: Theme.of(context)
      //             .textTheme
      //             .subtitle2!
      //             .copyWith(color: Colors.black54))),
      Text("${S.of(context).version} 2.1.5",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: AnthealthColors.black2))
    ]);
  }

  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? language = prefs.getString("language");
    return language ?? "vi";
  }

  void removeAccount(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => WarningPopup(
            title: S.of(context).Remove_account,
            cancel: () => Navigator.pop(context),
            delete: () {
              BlocProvider.of<AppCubit>(context).removeAccount();
              Navigator.pop(context);
            }));
  }

  void noFamilyPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => InfoPopup(
            title: S.of(context).no_family, ok: () => Navigator.pop(context)));
  }
}
