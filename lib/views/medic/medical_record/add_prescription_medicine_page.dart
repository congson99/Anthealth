import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/medic/add_medicine_cubit.dart';
import 'package:anthealth_mobile/blocs/medic/add_medicine_state.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_detail_cubit.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_detail_state.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/medicine_logic.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:anthealth_mobile/views/common_widgets/warning_popup.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPrescriptionMedicinePage extends StatelessWidget {
  const AddPrescriptionMedicinePage(
      {Key? key,
      required this.superContext,
      required this.superState,
      this.medicine,
      this.index})
      : super(key: key);

  final BuildContext superContext;
  final MedicalRecordDetailState superState;
  final DigitalMedicine? medicine;
  final int? index;

  @override
  Widget build(BuildContext context) => BlocProvider<AddMedicineCubit>(
      create: (context) => AddMedicineCubit(medicine),
      child:
          BlocBuilder<AddMedicineCubit, CubitState>(builder: (context, state) {
        if (state is AddMedicineState)
          return TemplateFormPage(
              title: (medicine == null)
                  ? S.of(context).Add_medicine
                  : S.of(context).Update_medicine,
              back: () => Navigator.pop(context),
              content: buildContent(context, state));
        else
          return LoadingPage();
      }));

  // Content
  Widget buildContent(BuildContext context, AddMedicineState state) {
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
                value:
                    (state.data.getName() == "") ? null : state.data.getName(),
                data: state.medicineNameList,
                onChanged: (value) => BlocProvider.of<AddMedicineCubit>(context)
                    .loadMedicine(state.medicineNameList.indexOf(value!))))
      ]),
      SizedBox(height: 16),
      if (state.data.getName() != "") buildMedicineEditing(context, state),
      SizedBox(height: 16),
      if (state.data.getName() != "") buildButton(context, state),
    ]);
  }

  // Content Component
  Widget buildLabel(BuildContext context, AddMedicineState state) {
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
              child: Image.network(state.data.getImagePath(),
                  height: 70.0, width: 70.0, fit: BoxFit.cover))),
      SizedBox(width: 16),
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(state.data.getName(),
                style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 6),
            Text(
                S.of(context).Unit +
                    ": " +
                    MedicineLogic.getUnit(context, state.data.getUnit()),
                style: Theme.of(context).textTheme.bodyText2),
            SizedBox(height: 4),
            Text(
                S.of(context).Usage +
                    ": " +
                    MedicineLogic.getUsage(context, state.data.getUsage()),
                style: Theme.of(context).textTheme.bodyText2)
          ])
    ]);
  }

  Widget buildMedicineEditing(BuildContext context, AddMedicineState state) {
    return Container(
        decoration: BoxDecoration(
            color: AnthealthColors.primary5,
            borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          buildLabel(context, state),
          SizedBox(height: 32),
          buildQuantity(context, state),
          SizedBox(height: 32),
          buildDosage(context, state),
          SizedBox(height: 16),
          buildCustomDosage(context, state),
          SizedBox(height: 32),
          buildRepeat(context, state),
          SizedBox(height: 32),
          buildNote(context, state),
          SizedBox(height: 24),
          Text("(*) " + S.of(context).Required_content,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: AnthealthColors.warning0))
        ]));
  }

  Column buildButton(BuildContext context, AddMedicineState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (medicine == null)
        CommonButton.round(context, () => addMedicine(context, state),
            S.of(context).button_add_medicine, AnthealthColors.primary1),
      if (medicine != null)
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
              child: CommonButton.round(context, () => deleteMedicine(context),
                  S.of(context).button_delete_medicine, AnthealthColors.warning2)),
          SizedBox(width: 16),
          Expanded(
              child: CommonButton.round(
                  context,
                  () => updateMedicine(context, state),
                  S.of(context).button_update,
                  AnthealthColors.primary1))
        ])
    ]);
  }

  // Editing Component
  Widget buildQuantity(BuildContext context, AddMedicineState state) {
    return Row(children: [
      Text(S.of(context).Quantity + " (*)",
          style: Theme.of(context).textTheme.subtitle1),
      Expanded(child: Container()),
      SizedBox(
          width: 70,
          child: CommonTextField.box(
              isNumber: true,
              context: context,
              initialValue: (state.data.getQuantity() == 0)
                  ? null
                  : MedicineLogic.handleQuantity(state.data.getQuantity()),
              onChanged: (String value) =>
                  editQuantity(context, state, value))),
      Text("  " + MedicineLogic.getUnit(context, state.data.getUnit()),
          style: Theme.of(context).textTheme.bodyText1)
    ]);
  }

  Widget buildDosage(BuildContext context, AddMedicineState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      buildDosageComponent(context, state, 0, S.of(context).morning),
      SizedBox(height: 16),
      buildDosageComponent(context, state, 1, S.of(context).noon),
      SizedBox(height: 16),
      buildDosageComponent(context, state, 2, S.of(context).afternoon),
      SizedBox(height: 16),
      buildDosageComponent(context, state, 3, S.of(context).night),
    ]);
  }

  Widget buildCustomDosage(BuildContext context, AddMedicineState state) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: state.customDosage
                .map((dosage) => dosage.isShow
                    ? buildCustomDosageComponent(context, state, dosage)
                    : Container())
                .toList() +
            [
              Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<AddMedicineCubit>(context)
                            .updateData(state, 2, 0);
                      },
                      child: CommonText.tapTextImage(
                          context,
                          "assets/app_icon/small_icons/add_pri1.png",
                          S.of(context).Add_customized_dose,
                          AnthealthColors.primary1)))
            ]);
  }

  Widget buildRepeat(BuildContext context, AddMedicineState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [
        SizedBox(
            width: 90,
            child: Text(S.of(context).Repeat + " (*)",
                style: Theme.of(context).textTheme.subtitle1)),
        Expanded(
            child: CommonTextField.selectBox(
                value: (state.data.getRepeat() == 0)
                    ? null
                    : MedicineLogic.getRepeatType(
                        context, state.data.getRepeat()),
                data: MedicineLogic.listRepeat(context),
                onChanged: (value) => editRepeat(context, state, value)))
      ]),
      if (state.data.getRepeat() == -1 || state.data.getRepeat() > 1)
        SizedBox(height: 16),
      if (state.data.getRepeat() == -1 ||
          (state.data.getRepeat() > 1 && state.data.getRepeat() < 10000000))
        buildFewDayRepeatComponent(context, state),
      if (state.data.getRepeat() >= 10000000)
        buildCustomWeekRepeatComponent(context, state)
    ]);
  }

  Widget buildNote(BuildContext context, AddMedicineState state) {
    return Row(children: [
      SizedBox(
          width: 90,
          child: Text(S.of(context).Note + ":  ",
              style: Theme.of(context).textTheme.subtitle1)),
      Expanded(
          child: CommonTextField.box(
              context: context,
              initialValue: state.data.getNote(),
              onChanged: (String value) => editNote(context, state, value)))
    ]);
  }

  // Component
  Widget buildDosageComponent(
      BuildContext context, AddMedicineState state, int index, String title) {
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
              initialValue: (state.data.getDosage()[index] == 0)
                  ? null
                  : MedicineLogic.handleQuantity(state.data.getDosage()[index]),
              onChanged: (String value) {
                if (index == 0) editDosageMorning(context, state, value);
                if (index == 1) editDosageNoon(context, state, value);
                if (index == 2) editDosageAfternoon(context, state, value);
                if (index == 3) editDosageNight(context, state, value);
              })),
      Text("  " + MedicineLogic.getUnit(context, state.data.getUnit()),
          style: Theme.of(context).textTheme.bodyText1)
    ]);
  }

  Widget buildCustomDosageComponent(
      BuildContext context, AddMedicineState state, TempCustomDosage dosage) {
    return Container(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(children: [
          GestureDetector(
              onTap: () {
                BlocProvider.of<AddMedicineCubit>(context)
                    .updateData(state, 3, state.customDosage.indexOf(dosage));
              },
              child: Image.asset("assets/app_icon/common/delete_war1.png",
                  height: 18.0, width: 18.0, fit: BoxFit.cover)),
          SizedBox(width: 16),
          Expanded(
              child: CommonTextField.box(
                  context: context,
                  initialValue: dosage.time,
                  hintText: S.of(context).Time,
                  onChanged: (String value) =>
                      editCustomDosageTime(context, state, dosage, value))),
          SizedBox(width: 16),
          SizedBox(
              width: 70,
              child: CommonTextField.box(
                  isNumber: true,
                  initialValue: (dosage.quantity == 0)
                      ? null
                      : MedicineLogic.handleQuantity(dosage.quantity),
                  context: context,
                  onChanged: (String value) =>
                      editCustomDosageQuantity(context, state, dosage, value))),
          Text("  " + MedicineLogic.getUnit(context, state.data.getUnit()),
              style: Theme.of(context).textTheme.bodyText1)
        ]));
  }

  Widget buildFewDayRepeatComponent(
      BuildContext context, AddMedicineState state) {
    return Row(children: [
      SizedBox(width: 90),
      Text(S.of(context).Repeat_after + "  ",
          style: Theme.of(context).textTheme.bodyText1),
      Expanded(
          child: CommonTextField.box(
              isNumber: true,
              context: context,
              initialValue: "2",
              onChanged: (String value) =>
                  editFewDayRepeat(context, state, value))),
      Text("  " + S.of(context).day,
          style: Theme.of(context).textTheme.bodyText1)
    ]);
  }

  Widget buildCustomWeekRepeatComponent(
      BuildContext context, AddMedicineState state) {
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
            children: MedicineLogic.formatToWeekChoice(state.data.getRepeat())
                .map((e) =>
                    buildCustomWeekRepeatChildComponent(state, e, context))
                .toList())
      ]))
    ]);
  }

  GestureDetector buildCustomWeekRepeatChildComponent(
      AddMedicineState state, List<int> e, BuildContext context) {
    return GestureDetector(
        onTap: () => editCustomWeekComponent(context, state, e),
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

  // Helper Editing Function
  void editQuantity(
      BuildContext context, AddMedicineState state, String value) {
    double result = (value == "") ? 0 : double.parse(value);
    BlocProvider.of<AddMedicineCubit>(context).updateData(state, 0, result);
  }

  void editDosageMorning(
      BuildContext context, AddMedicineState state, String value) {
    List<double> result = [
      (value == "") ? 0 : double.parse(value),
      state.data.getDosage()[1],
      state.data.getDosage()[2],
      state.data.getDosage()[3]
    ];
    BlocProvider.of<AddMedicineCubit>(context).updateData(state, 1, result);
  }

  void editDosageNoon(
      BuildContext context, AddMedicineState state, String value) {
    List<double> result = [
      state.data.getDosage()[0],
      (value == "") ? 0 : double.parse(value),
      state.data.getDosage()[2],
      state.data.getDosage()[3]
    ];
    BlocProvider.of<AddMedicineCubit>(context).updateData(state, 1, result);
  }

  void editDosageAfternoon(
      BuildContext context, AddMedicineState state, String value) {
    List<double> result = [
      state.data.getDosage()[0],
      state.data.getDosage()[1],
      (value == "") ? 0 : double.parse(value),
      state.data.getDosage()[3]
    ];
    BlocProvider.of<AddMedicineCubit>(context).updateData(state, 1, result);
  }

  void editDosageNight(
      BuildContext context, AddMedicineState state, String value) {
    List<double> result = [
      state.data.getDosage()[0],
      state.data.getDosage()[1],
      state.data.getDosage()[2],
      (value == "") ? 0 : double.parse(value),
    ];
    BlocProvider.of<AddMedicineCubit>(context).updateData(state, 1, result);
  }

  void editCustomDosageTime(BuildContext context, AddMedicineState state,
      TempCustomDosage dosage, String value) {
    BlocProvider.of<AddMedicineCubit>(context).updateData(
        state, 4, [state.customDosage.indexOf(dosage).toString(), value]);
  }

  void editCustomDosageQuantity(BuildContext context, AddMedicineState state,
      TempCustomDosage dosage, String value) {
    double result = (value == "") ? 0 : double.parse(value);
    BlocProvider.of<AddMedicineCubit>(context).updateData(
        state, 5, [state.customDosage.indexOf(dosage).toString(), result]);
  }

  void editRepeat(BuildContext context, AddMedicineState state, String? value) {
    int type = MedicineLogic.listRepeat(context).indexOf(value!);
    if (type == 0)
      BlocProvider.of<AddMedicineCubit>(context).updateData(state, 6, 1);
    if (type == 1)
      BlocProvider.of<AddMedicineCubit>(context).updateData(state, 6, 2);
    if (type == 2)
      BlocProvider.of<AddMedicineCubit>(context).updateData(state, 6, 11000000);
    if (type == 3)
      BlocProvider.of<AddMedicineCubit>(context).updateData(state, 6, -2);
  }

  void editFewDayRepeat(
      BuildContext context, AddMedicineState state, String? value) {
    int result = (value == "" || value == "1") ? -1 : int.parse(value!);
    BlocProvider.of<AddMedicineCubit>(context).updateData(state, 6, result);
  }

  void editCustomWeekComponent(
      BuildContext context, AddMedicineState state, List<int> e) {
    if (MedicineLogic.updateWeekCustomRepeat(state.data.getRepeat(), e[0]) !=
        10000000)
      BlocProvider.of<AddMedicineCubit>(context).updateData(state, 6,
          MedicineLogic.updateWeekCustomRepeat(state.data.getRepeat(), e[0]));
  }

  void editNote(BuildContext context, AddMedicineState state, String? value) {
    BlocProvider.of<AddMedicineCubit>(context).updateData(state, 7, value);
  }

  // Actions function
  void deleteMedicine(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => WarningPopup(
            title: S.of(context).Warning_delete_medicine,
            cancel: () => Navigator.pop(context),
            delete: () {
              BlocProvider.of<MedicalRecordDetailCubit>(superContext)
                  .updateMedicine(superState, 1, index!);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(S.of(context).Delete_medicine +
                      ' ' +
                      S.of(context).successfully +
                      '!')));
              Navigator.pop(context);
              Navigator.pop(context);
            }));
  }

  void updateMedicine(BuildContext context, AddMedicineState state) {
    if (checkFill(
        BlocProvider.of<AddMedicineCubit>(context).addMedicine(state))) {
      BlocProvider.of<MedicalRecordDetailCubit>(superContext).updateMedicine(
          superState,
          2,
          index!,
          BlocProvider.of<AddMedicineCubit>(context).addMedicine(state));
      Navigator.of(context).pop();
    } else
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).required_fill + '!')));
  }

  void addMedicine(BuildContext context, AddMedicineState state) {
    if (checkFill(
        BlocProvider.of<AddMedicineCubit>(context).addMedicine(state))) {
      BlocProvider.of<MedicalRecordDetailCubit>(superContext).updateMedicine(
          superState,
          0,
          0,
          BlocProvider.of<AddMedicineCubit>(context).addMedicine(state));
      Navigator.of(context).pop();
    } else
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).required_fill + '!')));
  }

  bool checkFill(DigitalMedicine medicine) {
    if (medicine.getQuantity() == 0) return false;
    if (MedicineLogic.isNullDosage(medicine.getDosage()) &&
        medicine.getCustomDosage().length == 0) return false;
    if (medicine.getRepeat() == 0) return false;
    return true;
  }
}
