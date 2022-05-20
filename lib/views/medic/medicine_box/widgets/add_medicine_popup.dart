import 'package:anthealth_mobile/blocs/medic/medicine_box_cubit.dart';
import 'package:anthealth_mobile/blocs/medic/medicine_box_state.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/medicine_logic.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AddMedicinePopup extends StatefulWidget {
  const AddMedicinePopup(
      {Key? key,
      required this.superContext,
      required this.state,
      this.medicineList,
      this.index,
      this.data})
      : super(key: key);

  final BuildContext superContext;
  final MedicineBoxState state;
  final List<String>? medicineList;
  final int? index;
  final MedicineData? data;

  @override
  State<AddMedicinePopup> createState() => _AddMedicinePopupState();
}

class _AddMedicinePopupState extends State<AddMedicinePopup> {
  List<String> medicineList = [];
  MedicineData medicine = MedicineData("", "", 0, 0, 0, "", "", "");

  @override
  void initState() {
    if (widget.medicineList != null) medicineList = widget.medicineList!;
    if (widget.data != null) medicine = widget.data!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: EdgeInsets.symmetric(horizontal: 16),
        child: Container(
            height: (widget.index != null) ? 350 : 500,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.index == null) buildTitle(context),
                  Expanded(
                      child:
                          SingleChildScrollView(child: buildContent(context))),
                  Divider(height: 1, color: AnthealthColors.black3),
                  buildButton(context)
                ])));
  }

  // Content Component
  Widget buildTitle(BuildContext context) {
    return Column(children: [
      SizedBox(height: 8),
      Text(S.of(context).Add_medicine,
          style: Theme.of(context).textTheme.subtitle1),
      SizedBox(height: 8),
      Divider(height: 1, color: AnthealthColors.black3)
    ]);
  }

  Widget buildContent(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          if (widget.index == null) buildChoseComponent(context),
          if (medicine.getName() != "")
            Column(
              children: [
                buildLabel(context),
                SizedBox(height: 16),
                buildQuantity(context),
                SizedBox(height: 16),
                buildNote(context)
              ],
            )
        ]));
  }

  Widget buildButton(BuildContext context) {
    return GestureDetector(
        onTap: () => done(),
        child: Container(
            color: Colors.transparent,
            height: 40,
            alignment: Alignment.center,
            child: Text(
                (widget.index == null)
                    ? S.of(context).button_add_medicine
                    : ((medicine.getQuantity() != 0)
                        ? S.of(context).button_done
                        : S.of(context).button_delete_medicine),
                style: Theme.of(context).textTheme.button!.copyWith(
                    color: (widget.index != null && medicine.getQuantity() == 0)
                        ? AnthealthColors.warning1
                        : AnthealthColors.primary1))));
  }

  // Child Component
  Padding buildChoseComponent(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(S.of(context).Choose_medicine,
              style: Theme.of(context).textTheme.caption),
          SizedBox(height: 8),
          CommonTextField.selectBox(
              value: (medicine.getName() == "") ? null : medicine.getName(),
              data: medicineList,
              onChanged: (value) {
                setState(() {
                  medicine =
                      BlocProvider.of<MedicineBoxCubit>(widget.superContext)
                          .getMedicineData(medicineList.indexOf(value!));
                });
              })
        ]));
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
              child: Image.network(medicine.getImagePath(),
                  height: 70.0, width: 70.0, fit: BoxFit.cover))),
      SizedBox(width: 16),
      SizedBox(
          width: MediaQuery.of(context).size.width - 70 - 16 - 64,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(medicine.getName(),
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 6),
                Text(
                    S.of(context).Unit +
                        ": " +
                        MedicineLogic.getUnit(context, medicine.getUnit()),
                    style: Theme.of(context).textTheme.bodyText2),
                SizedBox(height: 4),
                Text(
                    S.of(context).Usage +
                        ": " +
                        MedicineLogic.getUsage(context, medicine.getUsage()),
                    style: Theme.of(context).textTheme.bodyText2),
                SizedBox(height: 4),
                InkWell(
                    onTap: () => launchUrlString(medicine.getURL()),
                    child: Text(S.of(context).Learn_more,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: AnthealthColors.primary1)))
              ]))
    ]);
  }

  Widget buildQuantity(BuildContext context) {
    return Row(children: [
      SizedBox(
        width: 90,
        child: Text(S.of(context).Quantity + "  ",
            style: Theme.of(context).textTheme.subtitle1),
      ),
      SizedBox(
          width: 70,
          child: CommonTextField.box(
              context: context,
              initialValue:
                  MedicineLogic.handleQuantity(medicine.getQuantity()),
              onChanged: (String value) {
                double result = (value == "") ? 0 : double.parse(value);
                setState(() {
                  medicine = MedicineData.updateQuantity(medicine, result);
                });
              })),
      Text("  " + MedicineLogic.getUnit(context, medicine.getUnit()),
          style: Theme.of(context).textTheme.bodyText1)
    ]);
  }

  Widget buildNote(BuildContext context) {
    return Row(children: [
      SizedBox(
        width: 90,
        child: Text(S.of(context).Note + "  ",
            style: Theme.of(context).textTheme.subtitle1),
      ),
      Expanded(
          child: CommonTextField.box(
              context: context,
              initialValue: medicine.getNote(),
              onChanged: (String value) {
                setState(() {
                  medicine = MedicineData.updateNote(medicine, value);
                });
              }))
    ]);
  }

  // Actions
  void done() {
    if (widget.index == null && checkNullData()) {
      BlocProvider.of<MedicineBoxCubit>(widget.superContext)
          .updateData(widget.state, 2, medicine);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(S.of(context).Add_medicine +
              ' ' +
              S.of(context).successfully +
              '!')));
      Navigator.of(context).pop();
    }
    if (widget.index != null) {
      BlocProvider.of<MedicineBoxCubit>(widget.superContext)
          .updateData(widget.state, 3, [widget.index, medicine]);
      if (medicine.getQuantity() == 0)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(S.of(context).Delete_medicine +
                ' ' +
                S.of(context).successfully +
                '!')));
      Navigator.of(context).pop();
    }
  }

  bool checkNullData() {
    if (medicine.getQuantity() == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).quantity_check + '!')));
      return false;
    }
    return true;
  }
}
