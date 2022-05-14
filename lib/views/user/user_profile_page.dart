import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_avatar_form_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return TemplateAvatarFormPage(
        name: user.name,
        firstTitle: S.of(context).Profile,
        avatarPath: user.avatarPath,
        content: buildContent(context));
  }

  Widget buildContent(BuildContext context) {
    return Column(children: [
      SizedBox(height: 8),
      buildInfo(context),
      SizedBox(height: 24),
      buildActionArea()
    ]);
  }

  Widget buildActionArea() {
    return Row(children: [
      Expanded(
          child: GestureDetector(
              onTap: () => launch("tel://" + user.phoneNumber),
              child: Container(
                  decoration: BoxDecoration(
                      color: AnthealthColors.warning5,
                      borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.all(16),
                  child: Image.asset("assets/app_icon/common/call_war1.png",
                      height: 24, fit: BoxFit.fitHeight)))),
      SizedBox(width: 16),
      Expanded(
          child: GestureDetector(
              onTap: () {},
              child: Container(
                  decoration: BoxDecoration(
                      color: AnthealthColors.primary5,
                      borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                      "assets/app_icon/common/message_pri1.png",
                      height: 24,
                      fit: BoxFit.fitHeight)))),
      SizedBox(width: 16),
      Expanded(
          child: GestureDetector(
              onTap: () {},
              child: Container(
                  decoration: BoxDecoration(
                      color: AnthealthColors.secondary5,
                      borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.all(16),
                  child: Image.asset("assets/app_icon/common/share_sec1.png",
                      height: 24, fit: BoxFit.fitHeight))))
    ]);
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
            onTap: () => launch("tel://" + user.phoneNumber),
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
            onTap: () => launch("mailto://" + user.email),
            child: Text(user.email,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AnthealthColors.primary1)))
      ])
    ]);
  }
}
