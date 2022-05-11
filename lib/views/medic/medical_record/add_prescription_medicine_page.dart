import 'package:anthealth_mobile/blocs/medic/medical_record_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/medicine_logic.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:anthealth_mobile/views/common_widgets/warning_popup.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPrescriptionMedicinePage extends StatefulWidget {
  const AddPrescriptionMedicinePage(
      {Key? key,
      required this.superContext,
      this.medicine,
      required this.result})
      : super(key: key);

  final BuildContext superContext;
  final DigitalMedicine? medicine;
  final Function(DigitalMedicine) result;

  @override
  State<AddPrescriptionMedicinePage> createState() =>
      _AddPrescriptionMedicinePageState();
}

class _AddPrescriptionMedicinePageState
    extends State<AddPrescriptionMedicinePage> {
  DigitalMedicine data =
      DigitalMedicine("", "", 0, 0, 0, [0, 0, 0, 0], [], 0, "", "", "");
  int customDosageCount = 0;

  @override
  void initState() {
    super.initState();
    if (widget.medicine != null) data = widget.medicine!;
    for (int i = 0; i < 20; i++)
      data.customDosage.add(DigitalCustomMedicineDosage("", 0, false));
  }

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: (widget.medicine == null)
            ? S.of(context).Add_medicine
            : S.of(context).Update_medicine,
        back: () => Navigator.pop(context),
        content: buildContent(context));
  }

  Widget buildContent(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SizedBox(height: 16),
      Row(children: [
        Text(S.of(context).Choose_medicine + ":  ",
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: AnthealthColors.primary0)),
        Expanded(
            child: CommonTextField.select(
                value: (data.name == "") ? null : data.name,
                data: BlocProvider.of<MedicalRecordCubit>(widget.superContext)
                    .getMedicineList(),
                onChanged: (value) => setState(() {
                      data = BlocProvider.of<MedicalRecordCubit>(
                              widget.superContext)
                          .getMedicine(BlocProvider.of<MedicalRecordCubit>(
                                  widget.superContext)
                              .getMedicineList()
                              .indexOf(value!));
                    })))
      ]),
      SizedBox(height: 16),
      if (data.name != "") buildMedicineEditing(context),
      SizedBox(height: 16),
      if (data.name != "") buildButton(context),
    ]);
  }

  /// Main Components
  Widget buildMedicineEditing(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AnthealthColors.primary5,
            borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          buildLabel(context),
          SizedBox(height: 32),
          buildQuantity(context),
          SizedBox(height: 32),
          buildDosage(context),
          SizedBox(height: 16),
          buildCustomDosage(context),
          SizedBox(height: 32),
          buildRepeat(context),
          SizedBox(height: 32),
          buildNote(context),
          SizedBox(height: 24),
          Text("(*) " + S.of(context).Required_content,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: AnthealthColors.warning0))
        ]));
  }

  Column buildButton(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (widget.medicine == null)
        CommonButton.round(context, () => addMedicine(context),
            S.of(context).button_add_medicine, AnthealthColors.primary1),
      if (widget.medicine != null)
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
              child: CommonButton.round(
                  context,
                  () => deleteMedicine(context),
                  S.of(context).button_delete_medicine,
                  AnthealthColors.warning2)),
          SizedBox(width: 16),
          Expanded(
              child: CommonButton.round(context, () => updateMedicine(context),
                  S.of(context).button_update, AnthealthColors.primary1))
        ])
    ]);
  }

  Widget buildLabel(BuildContext context) {
    return Row(children: [
      Container(
          height: 70.0,
          width: 70.0,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AnthealthColors.primary3, width: 1)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(data.imagePath,
                  height: 70.0, width: 70.0, fit: BoxFit.cover))),
      SizedBox(width: 16),
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.name, style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 6),
            Text(
                S.of(context).Unit +
                    ": " +
                    MedicineLogic.getUnit(context, data.unit),
                style: Theme.of(context).textTheme.bodyText2),
            SizedBox(height: 4),
            Text(
                S.of(context).Usage +
                    ": " +
                    MedicineLogic.getUsage(context, data.usage),
                style: Theme.of(context).textTheme.bodyText2)
          ])
    ]);
  }

  /// Editing Components
  Widget buildQuantity(BuildContext context) {
    return Row(children: [
      Text(S.of(context).Quantity + " (*)",
          style: Theme.of(context).textTheme.subtitle1),
      Expanded(child: Container()),
      SizedBox(
          width: 70,
          child: CommonTextField.box(
              isNumber: true,
              context: context,
              initialValue: (data.quantity == 0)
                  ? null
                  : MedicineLogic.handleQuantity(data.quantity),
              onChanged: (String value) => setState(() {
                    data.quantity = double.parse(value);
                  }))),
      Text("  " + MedicineLogic.getUnit(context, data.unit),
          style: Theme.of(context).textTheme.bodyText1)
    ]);
  }

  Widget buildDosage(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      buildDosageComponent(context, 0, S.of(context).morning),
      SizedBox(height: 16),
      buildDosageComponent(context, 1, S.of(context).noon),
      SizedBox(height: 16),
      buildDosageComponent(context, 2, S.of(context).afternoon),
      SizedBox(height: 16),
      buildDosageComponent(context, 3, S.of(context).night),
    ]);
  }

  Widget buildCustomDosage(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      ...data.customDosage
          .map((dosage) => dosage.isUse
              ? buildCustomDosageComponent(
                  context, dosage, data.customDosage.indexOf(dosage))
              : Container())
          .toList(),
      Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: GestureDetector(
              onTap: () => setState(() {
                    data.customDosage[customDosageCount].isUse = true;
                    customDosageCount++;
                  }),
              child: CommonText.tapTextImage(
                  context,
                  "assets/app_icon/small_icons/add_pri1.png",
                  S.of(context).Add_customized_dose,
                  AnthealthColors.primary1)))
    ]);
  }

  Widget buildRepeat(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [
        SizedBox(
            width: 90,
            child: Text(S.of(context).Repeat + " (*)",
                style: Theme.of(context).textTheme.subtitle1)),
        Expanded(
            child: CommonTextField.selectBox(
                value: (data.repeat == 0)
                    ? null
                    : MedicineLogic.getRepeatType(context, data.repeat),
                data: MedicineLogic.listRepeat(context),
                onChanged: (value) => editRepeat(context, value)))
      ]),
      if (data.repeat == -1 || data.repeat > 1) SizedBox(height: 16),
      if (data.repeat == -1 || (data.repeat > 1 && data.repeat < 10000000))
        buildFewDayRepeatComponent(context),
      if (data.repeat >= 10000000) buildCustomWeekRepeatComponent(context)
    ]);
  }

  Widget buildNote(BuildContext context) {
    return Row(children: [
      SizedBox(
          width: 90,
          child: Text(S.of(context).Note + ":  ",
              style: Theme.of(context).textTheme.subtitle1)),
      Expanded(
          child: CommonTextField.box(
              context: context,
              initialValue: data.note,
              onChanged: (String value) => setState(() {
                    data.note = value;
                  })))
    ]);
  }

  /// Sub Components
  Widget buildDosageComponent(BuildContext context, int index, String title) {
    return Row(children: [
      if (index == 0)
        Text(S.of(context).Dosage + " (*)",
            style: Theme.of(context).textTheme.subtitle1),
      Expanded(child: Container()),
      Text(title, style: Theme.of(context).textTheme.subtitle1),
      SizedBox(width: 16),
      SizedBox(
          width: 70,
          child: CommonTextField.box(
              isNumber: true,
              context: context,
              initialValue: (data.dosage[index] == 0)
                  ? null
                  : MedicineLogic.handleQuantity(data.dosage[index]),
              onChanged: (String value) => setState(() {
                    data.dosage[index] = double.parse(value);
                  }))),
      Text("  " + MedicineLogic.getUnit(context, data.unit),
          style: Theme.of(context).textTheme.bodyText1)
    ]);
  }

  Widget buildCustomDosageComponent(
      BuildContext context, DigitalCustomMedicineDosage dosage, int index) {
    return Container(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(children: [
          GestureDetector(
              onTap: () => setState(() {
                    data.customDosage[index].isUse = false;
                  }),
              child: Image.asset("assets/app_icon/common/delete_war1.png",
                  height: 18.0, width: 18.0, fit: BoxFit.cover)),
          SizedBox(width: 16),
          Expanded(
              child: CommonTextField.box(
                  context: context,
                  initialValue: dosage.time,
                  hintText: S.of(context).Time,
                  onChanged: (String value) => setState(() {
                        data.customDosage[index].time = value;
                      }))),
          SizedBox(width: 16),
          SizedBox(
              width: 70,
              child: CommonTextField.box(
                  isNumber: true,
                  initialValue: (dosage.quantity == 0)
                      ? null
                      : MedicineLogic.handleQuantity(dosage.quantity),
                  context: context,
                  onChanged: (String value) => setState(() {
                        data.customDosage[index].quantity = double.parse(value);
                      }))),
          Text("  " + MedicineLogic.getUnit(context, data.unit),
              style: Theme.of(context).textTheme.bodyText1)
        ]));
  }

  Widget buildFewDayRepeatComponent(BuildContext context) {
    return Row(children: [
      SizedBox(width: 90),
      Text(S.of(context).Repeat_after + "  ",
          style: Theme.of(context).textTheme.bodyText1),
      Expanded(
          child: CommonTextField.box(
              isNumber: true,
              context: context,
              initialValue: "2",
              onChanged: (String value) => editFewDayRepeat(context, value))),
      Text("  " + S.of(context).day,
          style: Theme.of(context).textTheme.bodyText1)
    ]);
  }

  Widget buildCustomWeekRepeatComponent(BuildContext context) {
    return Row(children: [
      SizedBox(width: 90),
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(S.of(context).Choose_one_or_more_days + ":",
            style: Theme.of(context).textTheme.bodyText1),
        SizedBox(height: 16),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: MedicineLogic.formatToWeekChoice(data.repeat)
                .map((e) => buildCustomWeekRepeatChildComponent(e, context))
                .toList())
      ]))
    ]);
  }

  GestureDetector buildCustomWeekRepeatChildComponent(
      List<int> e, BuildContext context) {
    return GestureDetector(
        onTap: () => editCustomWeekComponent(context, e),
        child: Container(
            width: (MediaQuery.of(context).size.width - 192) / 7,
            height: (MediaQuery.of(context).size.width - 192) / 7,
            decoration: BoxDecoration(
                color: (e[1] == 0) ? Colors.white : AnthealthColors.primary1,
                borderRadius:
                    BorderRadius.circular(MediaQuery.of(context).size.width),
                border: Border.all(
                    color: (e[1] == 0)
                        ? AnthealthColors.primary4
                        : AnthealthColors.black1,
                    width: 1)),
            alignment: Alignment.center,
            child: Text(MedicineLogic.formatDateToWeekChoice(context, e[0]),
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: (e[1] == 0) ? null : Colors.white))));
  }

  /// Editing Functions
  void editRepeat(BuildContext context, String? value) {
    int type = MedicineLogic.listRepeat(context).indexOf(value!);
    setState(() {
      if (type == 0) data.repeat = 1;
      if (type == 1) data.repeat = 2;
      if (type == 2) data.repeat = 11000000;
      if (type == 3) data.repeat = -2;
    });
  }

  void editFewDayRepeat(BuildContext context, String? value) {
    int result = (value == "" || value == "1") ? -1 : int.parse(value!);
    setState(() {
      data.repeat = result;
    });
  }

  void editCustomWeekComponent(BuildContext context, List<int> e) {
    if (MedicineLogic.updateWeekCustomRepeat(data.repeat, e[0]) != 10000000)
      setState(() {
        data.repeat = MedicineLogic.updateWeekCustomRepeat(data.repeat, e[0]);
      });
  }

  /// Actions functions
  void deleteMedicine(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => WarningPopup(
            title: S.of(context).Warning_delete_medicine,
            cancel: () => Navigator.pop(context),
            delete: () {
              widget.result(DigitalMedicine(
                  "", "", 0, 0, 0, [0, 0, 0, 0], [], 0, "", "", ""));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(S.of(context).Delete_medicine +
                      ' ' +
                      S.of(context).successfully +
                      '!')));
              Navigator.pop(context);
              Navigator.pop(context);
            }));
  }

  void updateMedicine(BuildContext context) {
    DigitalMedicine resultMedicine = data;
    if (resultMedicine.repeat == -1) resultMedicine.repeat = 1;
    if (resultMedicine.repeat == -2) resultMedicine.repeat = -1;
    List<DigitalCustomMedicineDosage> resultCustomDosage = [];
    for (DigitalCustomMedicineDosage x in resultMedicine.customDosage)
      if (x.isUse) resultCustomDosage.add(x);
    resultMedicine.customDosage = resultCustomDosage;
    if (checkFill(resultMedicine)) {
      widget.result(resultMedicine);
      Navigator.of(context).pop();
    } else
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).required_fill + '!')));
  }

  void addMedicine(BuildContext context) {
    DigitalMedicine resultMedicine = data;
    if (resultMedicine.repeat == -1) resultMedicine.repeat = 1;
    if (resultMedicine.repeat == -2) resultMedicine.repeat = -1;
    List<DigitalCustomMedicineDosage> resultCustomDosage = [];
    for (DigitalCustomMedicineDosage x in resultMedicine.customDosage)
      if (x.isUse) resultCustomDosage.add(x);
    resultMedicine.customDosage = resultCustomDosage;
    if (checkFill(resultMedicine)) {
      widget.result(resultMedicine);
      Navigator.of(context).pop();
    } else
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).required_fill + '!')));
  }

  bool checkFill(DigitalMedicine medicine) {
    if (medicine.quantity == 0) return false;
    if (MedicineLogic.isNullDosage(medicine.dosage) &&
        medicine.customDosage.length == 0) return false;
    if (medicine.repeat == 0) return false;
    return true;
  }
}
