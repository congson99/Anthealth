import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_avatar_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/info_popup.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/common_widgets/warning_popup.dart';
import 'package:anthealth_mobile/views/family/family_member/family_member_health.dart';
import 'package:anthealth_mobile/views/medic/medical_record/medical_record_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FamilyMemberPage extends StatelessWidget {
  const FamilyMemberPage(
      {Key? key,
      required this.dashboardContext,
      required this.member,
      required this.isAdmin})
      : super(key: key);

  final BuildContext dashboardContext;
  final FamilyMemberData member;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return TemplateAvatarFormPage(
        name: member.name,
        secondTitle: member.admin
            ? S.of(context).Family_admin
            : S.of(context).Family_member,
        avatarPath: member.avatarPath,
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
  Widget buildInfo(BuildContext context) {
    return Column(children: [
      Row(children: [
        Text(S.of(context).Phone_number + ": ",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: AnthealthColors.black2)),
        InkWell(
            onTap: () => launchUrlString("tel://" + member.phoneNumber),
            child: Text(member.phoneNumber,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AnthealthColors.primary1)))
      ]),
      SizedBox(height: 8),
      Row(children: [
        Text(S.of(context).Email + ": ",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: AnthealthColors.black2)),
        InkWell(
            onTap: () => launchUrlString("mailto://" + member.email),
            child: Text(member.email,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AnthealthColors.primary1)))
      ])
    ]);
  }

  Widget buildData(BuildContext context) {
    bool isHealthPermission = false;
    bool isMedicPermission = member.permission[8];
    for (int i = 0; i < 9; i++)
      if (member.permission[i]) isHealthPermission = true;
    return Column(children: [
      SectionComponent(
          title: S.of(context).Health_record,
          colorID: 1,
          onTap: () {
            if (isHealthPermission)
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => FamilyMemberHealth(
                      dashboardContext: dashboardContext, data: member)));
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
    ]);
  }

  Widget buildAdmin(BuildContext context) {
    return Column(children: [
      SizedBox(height: 24),
      CustomDivider.common(),
      SizedBox(height: 16),
      SectionComponent(
          onTap: () => grantPopup(context),
          title: S.of(context).Grant_admin_rights,
          colorID: 0,
          isDirection: false,
          iconPath: "assets/app_icon/common/admin_pri0.png"),
      SizedBox(height: 16),
      SectionComponent(
          onTap: () => removePopup(context),
          title: S.of(context).Remove_family_member,
          colorID: 2,
          isDirection: false,
          iconPath: "assets/app_icon/common/out_war0.png")
    ]);
  }

  // Actions
  void call(String phoneNumber) {
    launchUrlString("tel://" + phoneNumber);
  }

  void showPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => InfoPopup(
              title: S.of(context).not_permission_view_data,
              ok: () => Navigator.pop(context),
            ));
  }

  void grantPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => InfoPopup(
            title: S.of(context).Grant_admin,
            ok: () {},
            cancel: () => Navigator.pop(context)));
  }

  void removePopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => WarningPopup(
            title: S.of(context).Warning_remove_member,
            cancel: () => Navigator.pop(context),
            delete: () {}));
  }
}
