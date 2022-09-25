import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/medicine_logic.dart';
import 'package:anthealth_mobile/logics/midical_directory_logic.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_snackbar.dart';
import 'package:anthealth_mobile/views/common_widgets/warning_popup.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  List<MedicineData> source = [];
  List<MedicalDirectoryAlphabetMarkData> data = [];
  ScrollController controller = ScrollController();
  FocusNode focusNode = FocusNode();
  bool showSearchBar = true;
  DigitalMedicine medicine =
      DigitalMedicine("", "", 0, 0, 0, [], [], 0, "", "", "");

  @override
  void initState() {
    super.initState();
    if (widget.medicine != null) medicine = widget.medicine!;
    BlocProvider.of<DashboardCubit>(widget.superContext)
        .getMedications()
        .then((value) => setState(() {
              source = value;
              data = MedicalDirectoryLogic.formatMedicationToMaskList(source);
            }));
    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        setState(() => showSearchBar = true);
      }
      if (controller.position.userScrollDirection == ScrollDirection.reverse) {
        FocusScope.of(context).unfocus();
        setState(() => showSearchBar = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) => TemplateFormPage(
      title: (widget.medicine == null)
          ? S.of(context).Add_medicine
          : S.of(context).Update_medicine,
      back: () => Navigator.of(context).pop(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      marginTop: 15,
      content: (medicine.name == "")
          ? buildContent(context)
          : new AddPrescriptionMedicine(
              medicine: medicine,
              change: (widget.medicine == null)
                  ? () {
                      setState(() {
                        showSearchBar = true;
                        data = MedicalDirectoryLogic.formatMedicationToMaskList(
                            source);
                        medicine = DigitalMedicine(
                            "", "", 0, 0, 0, [], [], 0, "", "", "");
                      });
                    }
                  : null,
              result: (result) => widget.result(result)));

  // Content
  Widget buildContent(BuildContext context) => Container(
      height: MediaQuery.of(context).size.height - 109,
      child: Stack(children: [
        ListView.builder(
            controller: controller,
            itemBuilder: (context, i) {
              if (i == 0) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 104),
                      if (data.length == 0) SizedBox(height: 32),
                      if (data.length == 0) Text(S.of(context).No_data)
                    ]);
              }
              return buildContact(context, data[i - 1]);
            },
            itemCount: data.length + 1),
        AnimatedContainer(
            duration: Duration(milliseconds: 400),
            height: showSearchBar ? 112 : 0,
            color: Colors.white,
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Expanded(
                  child: CommonTextField.box(
                      hintText: S.of(context).Quick_lookup,
                      textColor: AnthealthColors.primary1,
                      textInputAction: TextInputAction.search,
                      onEditingComplete: () => FocusScope.of(context).unfocus(),
                      context: context,
                      autofocus: false,
                      onChanged: (value) {
                        setState(() {
                          if (value != "")
                            data = MedicalDirectoryLogic.medicationFilter(
                                source, value);
                          else
                            data = MedicalDirectoryLogic
                                .formatMedicationToMaskList(source);
                        });
                      }))
            ]))
      ]));

  Widget buildContact(
          BuildContext context, MedicalDirectoryAlphabetMarkData mask) =>
      GestureDetector(
          onTap: () => setState(() {
                medicine = DigitalMedicine(
                    source[mask.index].getId(),
                    source[mask.index].getName(),
                    0,
                    source[mask.index].getUnit(),
                    source[mask.index].getUsage(),
                    [0, 0, 0, 0],
                    [],
                    0,
                    source[mask.index].getImagePath(),
                    source[mask.index].getURL(),
                    source[mask.index].getNote());
              }),
          child: Container(
              color: Colors.transparent,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (mask.mark)
                      Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 10),
                          child: Text(
                              (mask.name.length != 0)
                                  ? mask.name.substring(0, 1).toUpperCase()
                                  : mask.highlight
                                      .substring(0, 1)
                                      .toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: AnthealthColors.black2))),
                    if (mask.mark) CustomDivider.common(),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(letterSpacing: 0.35),
                                children: <TextSpan>[
                                  TextSpan(text: mask.name),
                                  TextSpan(
                                      text: mask.highlight,
                                      style: TextStyle(
                                          color: AnthealthColors.primary1)),
                                  TextSpan(text: mask.subName)
                                ]))),
                    CustomDivider.common()
                  ])));
}

class AddPrescriptionMedicine extends StatefulWidget {
  const AddPrescriptionMedicine(
      {Key? key, required this.medicine, this.change, required this.result})
      : super(key: key);

  final DigitalMedicine medicine;
  final VoidCallback? change;
  final Function(DigitalMedicine) result;

  @override
  State<AddPrescriptionMedicine> createState() =>
      _AddPrescriptionMedicineState();
}

class _AddPrescriptionMedicineState extends State<AddPrescriptionMedicine> {
  DigitalMedicine data =
      DigitalMedicine("", "", 0, 0, 0, [0, 0, 0, 0], [], 0, "", "", "");
  int customDosageCount = 0;

  @override
  void initState() {
    super.initState();
    data = widget.medicine;
    for (int i = 0; i < 20; i++)
      data.customDosage.add(DigitalCustomMedicineDosage("", 0, false));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 56, bottom: 32),
      child: buildContent(context),
    );
  }

  Widget buildContent(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (widget.change != null)
        CommonButton.round(
            context,
            widget.change!,
            S.of(context).Choose_another_medication,
            AnthealthColors.primary0.withOpacity(0.64)),
      SizedBox(height: 16),
      if (data.name != "") buildMedicineEditing(context),
      SizedBox(height: 16),
      if (data.name != "") buildButton(context)
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
      if (widget.change != null)
        CommonButton.round(context, () => addMedicine(context),
            S.of(context).button_add_medicine, AnthealthColors.primary1),
      if (widget.change == null)
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
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
      SizedBox(
        width: MediaQuery.of(context).size.width - 150,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.name, style: Theme.of(context).textTheme.headline6),
              SizedBox(height: 6),
              Text(
                  S.of(context).Unit +
                      ": " +
                      MedicineLogic.getUnit(context, data.unit),
                  style: Theme.of(context).textTheme.bodyText2)
            ]),
      )
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
              textInputType: TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.end,
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
      buildDosageComponent(context, 3, S.of(context).night)
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
              maxLines: null,
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
              textInputType: TextInputType.numberWithOptions(decimal: true),
              context: context,
              textAlign: TextAlign.end,
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
                  textInputType: TextInputType.numberWithOptions(decimal: true),
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
              textInputType: TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.end,
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
              ShowSnackBar.showSuccessSnackBar(
                  context,
                  S.of(context).Delete_medicine +
                      ' ' +
                      S.of(context).successfully +
                      '!');
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
      ShowSnackBar.showErrorSnackBar(
          context, S.of(context).required_fill + '!');
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
      ShowSnackBar.showErrorSnackBar(
          context, S.of(context).required_fill + '!');
  }

  bool checkFill(DigitalMedicine medicine) {
    if (medicine.quantity == 0) return false;
    if (MedicineLogic.isNullDosage(medicine.dosage) &&
        medicine.customDosage.length == 0) return false;
    if (medicine.repeat == 0) return false;
    return true;
  }
}
