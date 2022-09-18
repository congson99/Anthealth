import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/settings/edit_profile_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsProfilePage extends StatelessWidget {
  const SettingsProfilePage(
      {Key? key, required this.user, required this.appContext})
      : super(key: key);

  final User user;
  final BuildContext appContext;

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
      title: S.of(context).Profile_info,
      content: buildContent(context),
      back: () => Navigator.pop(context),
    );
  }

  Widget buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(children: [
        SizedBox(height: 16),
        buildUser(context),
        SizedBox(height: 32),
        buildInfo(context),
        SizedBox(height: 24),
        CommonButton.round(
            context,
            () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) =>
                    EditProfilePage(user: user, appContext: appContext))),
            S.of(context).Edit_Profile,
            AnthealthColors.primary1)
      ]),
    );
  }

  Column buildUser(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.network(
              (user.avatarPath == "")
                  ? "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"
                  : user.avatarPath,
              height: 80.0,
              width: 80.0,
              fit: BoxFit.cover),
        ),
        SizedBox(height: 16),
        Text(user.name,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: AnthealthColors.black1))
      ],
    );
  }

  Column buildInfo(BuildContext context) {
    return Column(children: [
      Row(children: [
        Text(S.of(context).Phone_number + ": ",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: AnthealthColors.black2)),
        InkWell(
            onTap: () => launchUrlString("tel://" + user.phoneNumber),
            child: Text(user.phoneNumber,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AnthealthColors.primary1)))
      ]),
      SizedBox(height: 16),
      Row(children: [
        Text(S.of(context).Email + ": ",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: AnthealthColors.black2)),
        InkWell(
            onTap: () => launchUrlString("mailto://" + user.email),
            child: Text(user.email,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AnthealthColors.primary1)))
      ]),
      SizedBox(height: 16),
      Row(children: [
        Text(S.of(context).Year_of_birth + ": ",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: AnthealthColors.black2)),
        Text((user.yOB == -1) ? "" : user.yOB.toString(),
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: AnthealthColors.primary1))
      ]),
      SizedBox(height: 16),
      Row(children: [
        Text(S.of(context).Sex + ": ",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: AnthealthColors.black2)),
        Text(
            (user.sex == -1)
                ? ""
                : ((user.sex == 0) ? S.of(context).Male : S.of(context).Female),
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: AnthealthColors.primary1))
      ]),
    ]);
  }
}
