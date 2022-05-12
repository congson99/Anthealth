import 'dart:ffi';

import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_avatar_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/info_popup.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/family/family_member_health.dart';
import 'package:anthealth_mobile/views/medic/medical_record/medical_record_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FamilyMemberPage extends StatelessWidget {
  const FamilyMemberPage(
      {Key? key,
      required this.member,
      required this.isAdmin,
      required this.gantAdmin,
      required this.remove})
      : super(key: key);

  final FamilyMemberData member;
  final bool isAdmin;
  final VoidCallback gantAdmin;
  final VoidCallback remove;

  @override
  Widget build(BuildContext context) {
    return TemplateAvatarFormPage(
        name: member.name,
        secondTitle: S.of(context).Family_member,
        avatarPath: member.avatarPath,
        call: () => call(member.phoneNumber),
        messenger: () => messenger(),
        share: () => share(),
        content: buildContent(context));
  }

  // Content
  Widget buildContent(BuildContext context) {
    return Column(children: [
      SizedBox(height: 8),
      buildInfo(context),
      SizedBox(height: 24),
      CustomDivider.common(),
      SizedBox(height: 16),
      buildData(context),
      if (isAdmin) buildAdmin(context)
    ]);
  }

  // Content Component
  Column buildInfo(BuildContext context) {
    return Column(children: [
      Row(children: [
        Text(S.of(context).Phone_number + ": ",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: AnthealthColors.black2)),
        InkWell(
            onTap: () => launch("tel://" + member.phoneNumber),
            child: Text(member.phoneNumber,
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
            onTap: () => launch("mailto://" + member.email),
            child: Text(member.email,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AnthealthColors.primary1)))
      ])
    ]);
  }

  Column buildData(BuildContext context) {
    bool isHealthPermission = false;
    bool isMedicPermission = member.permission[9] > -1;
    bool isDiagnosePermission = member.permission[10] > -1;
    for (int i = 0; i < 9; i++)
      if (member.permission[i] > -1) isHealthPermission = true;
    return Column(children: [
      SectionComponent(
          title: S.of(context).Health_record,
          colorID: 1,
          onTap: () {
            if (isHealthPermission)
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => FamilyMemberHealth(data: member)));
            else
              showPopup(context);
          }),
      SizedBox(height: 16),
      SectionComponent(
          title: S.of(context).Medic_record,
          colorID: 1,
          onTap: () {
            if (isMedicPermission)
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => MedicalRecordPage(data: member)));
            else
              showPopup(context);
          }),
      SizedBox(height: 16),
      SectionComponent(
          title: S.of(context).Diagnose,
          colorID: 1,
          onTap: () {
            if (isDiagnosePermission)
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => FamilyMemberHealth(data: member)));
            else
              showPopup(context);
          })
    ]);
  }

  Column buildAdmin(BuildContext context) {
    return Column(children: [
      SizedBox(height: 24),
      CustomDivider.common(),
      SizedBox(height: 16),
      SectionComponent(
          onTap: gantAdmin,
          title: S.of(context).Grant_admin_rights,
          colorID: 0,
          isDirection: false,
          iconPath: "assets/app_icon/common/admin_pri0.png"),
      SizedBox(height: 16),
      SectionComponent(
          onTap: remove,
          title: S.of(context).Remove_family_member,
          colorID: 2,
          isDirection: false,
          iconPath: "assets/app_icon/common/out_war0.png")
    ]);
  }

  // Actions
  void call(String phoneNumber) {
    launch("tel://" + phoneNumber);
  }

  void messenger() {}

  void share() {}

  void showPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => InfoPopup(
              title: S.of(context).not_permission_view_data,
              ok: () => Navigator.pop(context),
            ));
  }
}
