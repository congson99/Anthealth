import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/user/doctor_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_avatar_form_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DoctorProfilePage extends StatelessWidget {
  const DoctorProfilePage({Key? key, required this.doctor}) : super(key: key);

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return TemplateAvatarFormPage(
        name: S.of(context).Dr + " " + doctor.name,
        secondTitle: doctor.highlight,
        avatarPath: doctor.avatarPath,
        favorite: doctor.favorite,
        content: buildContent(context));
  }

  Widget buildContent(BuildContext context) {
    return Column(children: [
      SizedBox(height: 12),
      buildActionArea(),
      SizedBox(height: 24),
      buildInfo(context)
    ]);
  }

  Widget buildActionArea() {
    return Row(children: [
      Expanded(
          child: GestureDetector(
              onTap: () => launchUrlString("tel://" + doctor.phoneNumber),
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
                  child: Image.asset("assets/app_icon/common/message_pri1.png",
                      height: 24, fit: BoxFit.fitHeight)))),
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
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [
        Text(S.of(context).Phone_number + ": ",
            style: Theme.of(context).textTheme.subtitle2),
        InkWell(
            onTap: () => launchUrlString("tel://" + doctor.phoneNumber),
            child: Text(doctor.phoneNumber,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AnthealthColors.primary1)))
      ]),
      SizedBox(height: 8),
      Row(children: [
        Text(S.of(context).Email + ": ",
            style: Theme.of(context).textTheme.subtitle2),
        InkWell(
            onTap: () => launchUrlString("mailto://" + doctor.email),
            child: Text(doctor.email,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AnthealthColors.primary1)))
      ]),
      SizedBox(height: 8),
      Text(S.of(context).Doctor_description + ": ",
          style: Theme.of(context).textTheme.subtitle2),
      SizedBox(height: 2),
      Text(doctor.description, style: Theme.of(context).textTheme.bodyText1)
    ]);
  }
}
