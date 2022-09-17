import 'dart:math';

import 'package:anthealth_mobile/blocs/medic/medication_reminder_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/medicine_logic.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/models/medic/medication_reminder_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_snackbar.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/medic/medication_reminder/add_prescription_page.dart';
import 'package:anthealth_mobile/views/medic/medication_reminder/create_prescription_reminder_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllPrescriptionPage extends StatefulWidget {
  const AllPrescriptionPage(
      {Key? key, required this.dashboardContext, required this.superContext})
      : super(key: key);

  final BuildContext dashboardContext;
  final BuildContext superContext;

  @override
  State<AllPrescriptionPage> createState() => _AllPrescriptionPageState();
}

class _AllPrescriptionPageState extends State<AllPrescriptionPage> {
  List<Prescription> selfPrescription = [];
  List<Prescription> autoPrescription = [];

  @override
  void initState() {
    super.initState();
    selfPrescription =
        BlocProvider.of<MedicationReminderCubit>(widget.superContext)
            .getAllPrescriptions()[0];
    autoPrescription =
        BlocProvider.of<MedicationReminderCubit>(widget.superContext)
            .getAllPrescriptions()[1];
  }

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: S.of(context).All_prescription,
        back: () => Navigator.of(context).pop(),
        add: () => addMedicine(),
        content: Column(children: [
          if (selfPrescription.length != 0)
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              CommonText.section(
                  S.of(context).Self_create_prescription, context),
              SizedBox(height: 16),
              ...selfPrescription
                  .map((prescription) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SectionComponent(
                            onTap: () => showPrescriptionInfo(prescription),
                            title: prescription.name,
                            colorID: 1),
                      ))
                  .toList(),
              SizedBox(height: 16),
              CustomDivider.common(),
              SizedBox(height: 16)
            ]),
          if (autoPrescription.length != 0)
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              CommonText.section(
                  S.of(context).Prescription_from_medical_records, context),
              SizedBox(height: 16),
              ...autoPrescription.map((prescription) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SectionComponent(
                      onTap: () => showPrescriptionInfo(prescription),
                      title: prescription.name,
                      subTitle: prescription.description,
                      colorID: 0)))
            ]),
          if (selfPrescription.length == 0 && autoPrescription.length == 0)
            Text(S.of(context).no_prescription,
                style: Theme.of(context).textTheme.bodyText1)
        ]));
  }

  void showPrescriptionInfo(Prescription prescription) {
    showDialog(
        context: context,
        builder: (_) => Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            insetPadding: EdgeInsets.symmetric(horizontal: 16),
            child: Container(
                height: min(150 + prescription.medication.length * 110,
                    MediaQuery.of(context).size.height * 0.8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(children: [
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(S.of(context).Prescription + ": ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                          color: AnthealthColors.primary0)),
                              Expanded(
                                  child: Text(
                                      prescription.name +
                                          ((prescription.description != "")
                                              ? " " + prescription.description
                                              : ""),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                              color: AnthealthColors.primary0)))
                            ]),
                        SizedBox(height: 16),
                        ...prescription.medication.map((medicine) =>
                            buildPrescriptionComponent(context, medicine))
                      ]))),
                  SizedBox(height: 16),
                  CommonButton.round(context, () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => CreatePrescriptionReminderPage(
                            superContext: widget.superContext,
                            prescription: prescription)));
                  }, S.of(context).Create_reminder, AnthealthColors.primary0)
                ]))));
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

  void addMedicine() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CreatePrescriptionPage(
                superContext: widget.dashboardContext,
                result: (result) {
                  Navigator.pop(context);
                  BlocProvider.of<MedicationReminderCubit>(widget.superContext)
                      .addPrescription(result)
                      .then((value) {
                    if (value) {
                      setState(() {
                        selfPrescription =
                            BlocProvider.of<MedicationReminderCubit>(
                                    widget.superContext)
                                .getAllPrescriptions()[0];
                        autoPrescription =
                            BlocProvider.of<MedicationReminderCubit>(
                                    widget.superContext)
                                .getAllPrescriptions()[1];
                      });
                      ShowSnackBar.showSuccessSnackBar(
                          context,S.of(context).Create_prescription +
                              ' ' +
                              S.of(context).successfully +
                              '!');
                    }
                  });
                })));
  }
}
