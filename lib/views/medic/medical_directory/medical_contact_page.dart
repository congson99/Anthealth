import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/medic/medical_directory_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/medic/medical_directory/medical_contact_map_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MedicalContactPage extends StatelessWidget {
  const MedicalContactPage({Key? key, required this.contact}) : super(key: key);

  final MedicalDirectoryData contact;

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: S.of(context).Hospital_info,
        back: () => back(context),
        edit: () {},
        content: buildContent(context));
  }

  // Content
  Widget buildContent(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      buildInfoComponent(context, S.of(context).Name, contact.getName()),
      CustomDivider.common(),
      SizedBox(height: 16),
      buildPhoneComponent(
          context, S.of(context).Phone_number, contact.getPhoneNumber()),
      CustomDivider.common(),
      SizedBox(height: 16),
      buildInfoComponent(
          context, S.of(context).Working_time, contact.getWorkTime()),
      CustomDivider.common(),
      SizedBox(height: 16),
      buildInfoComponent(context, S.of(context).Address, contact.getLocation()),
      SizedBox(height: 8),
      if (contact.getGPS().lat != 0 && contact.getGPS().long != 0)
        SectionComponent(
            iconPath: "assets/app_icon/common/location_pri0.png",
            title: S.of(context).Show_on_map,
            colorID: 0,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => MedicalContactMapPage(contact: contact)))),
      if (contact.getNote() != "") buildNote(context, contact.getNote())
    ]);
  }

  Widget buildInfoComponent(
      BuildContext context, String title, String content) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: AnthealthColors.black2)),
      SizedBox(height: 8),
      Text(content, style: Theme.of(context).textTheme.subtitle1),
      SizedBox(height: 16)
    ]);
  }

  Widget buildPhoneComponent(
      BuildContext context, String title, String content) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: AnthealthColors.black2)),
      SizedBox(height: 8),
      InkWell(
          onTap: () => launchUrlString("tel://" + content),
          child: Text(content,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: AnthealthColors.primary1))),
      SizedBox(height: 16)
    ]);
  }

  Widget buildNote(BuildContext context, String content) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 32),
      CustomDivider.common(),
      SizedBox(height: 16),
      Text(S.of(context).Note,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: AnthealthColors.black2)),
      SizedBox(height: 8),
      Text(content, style: Theme.of(context).textTheme.subtitle1),
      SizedBox(height: 16)
    ]);
  }

  // Actions
  void back(BuildContext context) {
    Navigator.of(context).pop();
  }
}
