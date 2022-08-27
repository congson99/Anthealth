import 'package:anthealth_mobile/blocs/app_cubit.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/language/language_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/common_widgets/warning_popup.dart';
import 'package:anthealth_mobile/views/settings/dev_tool/dev_tool_page.dart';
import 'package:anthealth_mobile/views/settings/general/setting_language_page.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key, required this.appContext, required this.user})
      : super(key: key);

  final BuildContext appContext;
  final User user;

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: S.of(context).Settings,
        back: () => Navigator.pop(context),
        content: buildContent(context, appContext));
  }

  Widget buildContent(BuildContext context, BuildContext appContext) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      buildDoctorMode(context, appContext),
      buildGeneral(context, appContext),
      buildLogout(context, appContext)
    ]);
  }

  Widget buildDoctorMode(BuildContext context, BuildContext appContext) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CommonText.section(S.of(context).Doctor_mode, context),
      SizedBox(height: 16),
      if (user.isDoctor)
        SectionComponent(
            title: S.of(context).Switch_to_doctor_mode,
            iconPath: "assets/app_icon/common/doctor_war0.png",
            colorID: 2,
            onTap: () {
              Navigator.pop(context);
              BlocProvider.of<DashboardCubit>(appContext).doctor();
            }),
      if (!user.isDoctor)
        SectionComponent(
            title: S.of(context).Register_doctor,
            iconPath: "assets/app_icon/common/doctor_war0.png",
            colorID: 2,
            onTap: () => launchUrlString("https://hca.com/doctor/register")),
      SizedBox(height: 32),
      CustomDivider.common(),
      SizedBox(height: 16)
    ]);
  }

  Widget buildGeneral(BuildContext context, BuildContext appContext) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CommonText.section(S.of(context).General, context),
      SizedBox(height: 16),
      SectionComponent(
          title: S.of(context).Language,
          //directionContent: getLanguage(context, languageID),
          colorID: 3,
          onTap: () {
            getLanguage().then((value) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => SettingLanguagePage(
                      languageID: value,
                      update: (result) {
                        BlocProvider.of<LanguageCubit>(appContext)
                            .updateLanguage(result, context);
                      })));
            });
          }),
      SizedBox(height: 32),
      CustomDivider.common(),
      SizedBox(height: 16)
    ]);
  }

  Widget buildLogout(BuildContext context, BuildContext appContext) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SectionComponent(
          title: S.of(context).Logout,
          iconPath: "assets/app_icon/common/out_war0.png",
          isDirection: false,
          colorID: 2,
          onTap: () {
            BlocProvider.of<AppCubit>(appContext).logout();
            Navigator.pop(context);
          }),
      SizedBox(height: 16),
      // SectionComponent(
      //     title: "</> DEV TOOL",
      //     colorID: 3,
      //     onTap: () {
      //       Navigator.of(context)
      //           .push(MaterialPageRoute(builder: (_) => DevToolPage()));
      //     }),
      // SizedBox(height: 16),
      SectionComponent(
          title: S.of(context).Remove_account,
          isDirection: false,
          colorID: 3,
          onTap: () => removeAccount(context)),
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
              BlocProvider.of<AppCubit>(appContext).removeAccount();
              Navigator.pop(context);
            }));
  }
}
