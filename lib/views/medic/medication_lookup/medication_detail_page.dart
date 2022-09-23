import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MedicationDetailPage extends StatelessWidget {
  const MedicationDetailPage({Key? key, required this.medicineData})
      : super(key: key);

  final MedicineData medicineData;

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: S.of(context).Medicine_info,
        back: () => back(context),
        content: buildContent(context));
  }

  // Content
  Widget buildContent(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SizedBox(height: 16),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black12)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(medicineData.getImagePath(),
                    height: 240, width: 240, fit: BoxFit.cover),
              )),
          SizedBox(height: 16),
          Text(medicineData.getName(),
              style: Theme.of(context).textTheme.headline2),
          SizedBox(height: 8),
          InkWell(
            onTap: () => launchUrlString(medicineData.getURL()),
            child: Text(S.of(context).Learn_more,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Colors.red, decoration: TextDecoration.underline)),
          ),
        ],
      ),
      SizedBox(height: 24),
      Text(medicineData.getNote(),
          style: Theme.of(context).textTheme.bodyText1),
      SizedBox(height: 16),
    ]);
  }

  // Actions
  void back(BuildContext context) {
    Navigator.of(context).pop();
  }
}
