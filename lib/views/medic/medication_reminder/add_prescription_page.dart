import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/medicine_logic.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/models/medic/medication_reminder_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/medic/medical_record/add_prescription_medicine_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class CreatePrescriptionPage extends StatefulWidget {
  const CreatePrescriptionPage(
      {Key? key, required this.superContext, required this.result})
      : super(key: key);

  final BuildContext superContext;
  final Function(Prescription) result;

  @override
  State<CreatePrescriptionPage> createState() => _CreatePrescriptionPageState();
}

class _CreatePrescriptionPageState extends State<CreatePrescriptionPage> {
  Prescription prescription = Prescription("", "", "", []);

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: S.of(context).Create_prescription,
        back: () => Navigator.of(context).pop(),
        content: buildContent(context));
  }

  Widget buildContent(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [
        Text(S.of(context).Name + "  ",
            style: Theme.of(context).textTheme.subtitle1),
        Expanded(
            child: SizedBox(
                width: 70,
                child: CommonTextField.box(
                    maxLines: 1,
                    initialValue: prescription.name,
                    context: context,
                    onChanged: (value) =>
                        setState(() => prescription.name = value))))
      ]),
      SizedBox(height: 32),
      CustomDivider.common(),
      SizedBox(height: 16),
      Row(children: [
        Expanded(
            child: Text(S.of(context).Medicine,
                style: Theme.of(context).textTheme.subtitle1)),
        Text("+",
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: AnthealthColors.primary1)),
        GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => AddPrescriptionMedicinePage(
                  superContext: widget.superContext,
                  result: (medicine) =>
                      setState(() => prescription.medication.add(medicine))))),
          child: Text(S.of(context).Add_medicine,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: AnthealthColors.primary1,
                  decoration: TextDecoration.underline)),
        )
      ]),
      SizedBox(height: 16),
      ...prescription.medication
          .map((medication) => buildPrescriptionComponent(context, medication)),
      SizedBox(height: 32),
      CommonButton.round(context, () => createPrescription(),
          S.of(context).Create_prescription, AnthealthColors.secondary1)
    ]);
  }

  Widget buildPrescriptionComponent(
      BuildContext context, DigitalMedicine medicine) {
    return Container(
        decoration: BoxDecoration(
            color: AnthealthColors.primary5,
            borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(children: [
            Expanded(
                child: Text(medicine.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: AnthealthColors.primary0))),
            Text(
                MedicineLogic.handleQuantity(medicine.quantity) +
                    " " +
                    MedicineLogic.getUnit(context, medicine.unit),
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: AnthealthColors.primary0)),
          ]),
          SizedBox(height: 8),
          Text(MedicineLogic.handleMedicineString(context, medicine),
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: AnthealthColors.primary0))
        ]));
  }

  void createPrescription() {
    if (prescription.name == "") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(S.of(context).required_fill)));
      return;
    }
    if (prescription.medication.length == 0) Navigator.pop(context);
    widget.result(prescription);
  }
}
