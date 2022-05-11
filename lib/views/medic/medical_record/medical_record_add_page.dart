import 'dart:io';

import 'package:anthealth_mobile/blocs/medic/medical_record_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/medicine_logic.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_appbar.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/datetime_picker_bottom_sheet.dart';
import 'package:anthealth_mobile/views/common_widgets/warning_popup.dart';
import 'package:anthealth_mobile/views/medic/medical_record/add_prescription_medicine_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class MedicalRecordAddPage extends StatefulWidget {
  const MedicalRecordAddPage(
      {Key? key, required this.superContext, this.medicalRecordDetailData})
      : super(key: key);

  final BuildContext superContext;
  final MedicalRecordDetailData? medicalRecordDetailData;

  @override
  State<MedicalRecordAddPage> createState() => _MedicalRecordAddPageState();
}

class _MedicalRecordAddPageState extends State<MedicalRecordAddPage> {
  MedicalRecordDetailData data = MedicalRecordDetailData(
      MedicalRecordLabel("", DateTime.now(), "", ""),
      [],
      [],
      [],
      [],
      [],
      MedicalAppointment(DateTime.now(), "", DateTime.now(), ""));
  var _timeController = TextEditingController();
  var _appointmentTimeController = TextEditingController();
  var _nameFocus = FocusNode();
  var _locationFocus = FocusNode();
  List<List<File>> images = [[], [], [], []];

  @override
  void initState() {
    if (widget.medicalRecordDetailData != null)
      data = widget.medicalRecordDetailData!;
    _timeController.text = DateFormat("dd.MM.yyyy").format(data.label.dateTime);
    _appointmentTimeController.text =
        DateFormat("dd.MM.yyyy").format(data.appointment.dateTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      Container(
          color: AnthealthColors.black4,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(top: 57, left: 8, right: 8),
          child: SingleChildScrollView(child: buildContent(context))),
      CustomAppBar(
          title: (widget.medicalRecordDetailData == null)
              ? S.of(context).Add_medical_record
              : S.of(context).Update_medical_record,
          back: () => back())
    ])));
  }

  Widget buildContent(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(height: 8, color: Colors.transparent),
      buildEditingComponent(context),
      buildButton(context)
    ]);
  }

  /// Main Components
  Container buildEditingComponent(BuildContext context) {
    return Container(
        color: Colors.white,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          buildDescription(context),
          CustomDivider.cutLine(MediaQuery.of(context).size.width),
          buildPhotoComponent(context, 0,
              title: S.of(context).General_information),
          CustomDivider.cutLine(MediaQuery.of(context).size.width),
          buildPhotoComponent(context, 1, title: S.of(context).Medical_test),
          CustomDivider.cutLine(MediaQuery.of(context).size.width),
          buildPhotoComponent(context, 2, title: S.of(context).Diagnose),
          CustomDivider.cutLine(MediaQuery.of(context).size.width),
          buildPrescription(context),
          buildPhotoComponent(context, 3,
              isShowNullData: (data.prescription.length == 0) ? true : false),
          CustomDivider.cutLine(MediaQuery.of(context).size.width),
          buildAppointment(context),
          SizedBox(height: 8)
        ]));
  }

  Widget buildButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: (widget.medicalRecordDetailData == null)
            ? CommonButton.round(
                context,
                () => addMedicalRecord(),
                S.of(context).button_add_medical_record,
                AnthealthColors.secondary1)
            : CommonButton.round(
                context,
                () => updateMedicalRecord(),
                S.of(context).button_update_medical_record,
                AnthealthColors.secondary1));
  }

  /// Editing Components
  Widget buildDescription(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 16),
          CommonTextField.fill(
              context: context,
              initialValue: data.label.name,
              focusNode: _nameFocus,
              onChanged: (String value) =>
                  setState(() => data.label.name = value),
              labelText: S.of(context).Record_name + " (*)",
              hintText: S.of(context).Hint_record_name),
          SizedBox(height: 28),
          CommonTextField.select(
              labelText: S.of(context).Medical_location + " (*)",
              focusNode: _locationFocus,
              data: BlocProvider.of<MedicalRecordCubit>(widget.superContext)
                  .getLocationList(),
              value: (data.label.location == "") ? null : data.label.location,
              onChanged: (value) => setState(() {
                    data.label.location = value!;
                    data.appointment.location = value;
                  })),
          SizedBox(height: 20),
          CommonTextField.fill(
              textEditingController: _timeController,
              onTap: () => onTimeTap(),
              context: context,
              onChanged: (String value) {},
              labelText: S.of(context).Medical_date + " (*)"),
          SizedBox(height: 24),
          Text("(*) " + S.of(context).Required_content,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: AnthealthColors.warning0)),
          SizedBox(height: 4)
        ]));
  }

  Widget buildPhotoComponent(BuildContext context, int index,
      {String? title, bool? isShowNullData}) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          if (title != null) CommonText.subSection(title, context),
          if (title != null) SizedBox(height: 16),
          buildPhotoAddList(context, index)
        ]));
  }

  Widget buildPrescription(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          CommonText.subSection(S.of(context).Prescription, context),
          SizedBox(height: 16),
          buildDigitalPrescription(context)
        ]));
  }

  Widget buildAppointment(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 16),
          CommonText.subSection(S.of(context).Re_examination, context),
          SizedBox(height: 24),
          CommonTextField.fill(
              context: context,
              initialValue: data.appointment.name,
              onChanged: (String value) => setState(() {
                    data.appointment.name = value;
                  }),
              labelText: S.of(context).Content,
              hintText: S.of(context).Hint_re_examination),
          SizedBox(height: 28),
          CommonTextField.select(
              labelText: S.of(context).Medical_location,
              data: BlocProvider.of<MedicalRecordCubit>(widget.superContext)
                  .getLocationList(),
              value: (data.appointment.location == "")
                  ? ((data.label.location == "") ? null : data.label.location)
                  : data.appointment.location,
              onChanged: (value) =>
                  setState(() => data.appointment.location = value!)),
          SizedBox(height: 20),
          CommonTextField.fill(
              textEditingController: _appointmentTimeController,
              onTap: () => onAppointmentTimeTap(),
              context: context,
              onChanged: (String value) => {},
              labelText: S.of(context).Medical_date),
          SizedBox(height: 8)
        ]));
  }

  /// Child Components
  Widget buildPhotoAddList(BuildContext context, int index) {
    final double width = MediaQuery.of(context).size.width - 48;
    final int count = width ~/ 100;
    final double size = (width - (count - 1) * 16) / count;
    return Wrap(spacing: 16, runSpacing: 16, children: [
      ...images[index]
          .map((photo) => Container(
              height: size,
              width: size,
              child: GestureDetector(
                  onTap: () => onPhotoTap(index, images[index].indexOf(photo)),
                  child: Image.file(photo, fit: BoxFit.cover))))
          .toList(),
      Container(
          height: (images[index].length == 0) ? 32 : size,
          width: (images[index].length == 0) ? 150 : size,
          alignment: Alignment.centerLeft,
          child: GestureDetector(
              onTap: () => onAddPhotoTap(index),
              child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CommonText.tapTextImage(
                      context,
                      "assets/app_icon/small_icons/add_photo_pri1.png",
                      S.of(context).Add_photo,
                      AnthealthColors.primary1))))
    ]);
  }

  Widget buildDigitalPrescription(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        ...data.prescription
            .map((medicine) => Container(
                child: buildPrescriptionComponent(
                    context, medicine, data.prescription.indexOf(medicine))))
            .toList(),
        Container(
            child: GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => AddPrescriptionMedicinePage(
                        superContext: widget.superContext,
                        result: (medicine) =>
                            setState(() => data.prescription.add(medicine))))),
                child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CommonText.tapTextImage(
                        context,
                        "assets/app_icon/small_icons/add_medicine_sec1.png",
                        S.of(context).Add_medicine,
                        AnthealthColors.secondary1))))
      ]);

  Widget buildPrescriptionComponent(
      BuildContext context, DigitalMedicine medicine, int index) {
    return GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => AddPrescriptionMedicinePage(
                superContext: widget.superContext,
                medicine: medicine,
                result: (medicine) => setState(() {
                      data.prescription.removeAt(index);
                      if (medicine.name != "")
                        data.prescription.insert(index, medicine);
                    })))),
        child: Container(
            decoration: BoxDecoration(
                color: AnthealthColors.secondary5,
                borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(children: [
                    Expanded(
                        child: Text(medicine.name,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: AnthealthColors.secondary0))),
                    Text(
                        MedicineLogic.handleQuantity(medicine.quantity) +
                            " " +
                            MedicineLogic.getUnit(context, medicine.unit),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: AnthealthColors.secondary0)),
                  ]),
                  SizedBox(height: 8),
                  Text(MedicineLogic.handleMedicineString(context, medicine),
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: AnthealthColors.secondary1))
                ])));
  }

  /// Editing Functions
  void onTimeTap() {
    showModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        builder: (_) => DateTimePickerBottomSheet(
            dateTime: data.label.dateTime,
            isTime: false,
            cancel: () => Navigator.pop(context),
            ok: (time) {
              setState(() =>
                  _timeController.text = DateFormat("dd.MM.yyyy").format(time));
              data.label.dateTime = time;
              Navigator.pop(context);
            }));
  }

  void onAppointmentTimeTap() {
    showModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        builder: (_) => DateTimePickerBottomSheet(
            isFuture: true,
            dateTime: data.label.dateTime,
            isTime: false,
            cancel: () => Navigator.pop(context),
            ok: (time) {
              setState(() => _appointmentTimeController.text =
                  DateFormat("dd.MM.yyyy").format(time));
              data.appointment.dateTime = time;
              Navigator.pop(context);
            }));
  }

  /// Actions
  void back() {
    if (widget.medicalRecordDetailData == null)
      showDialog(
          context: context,
          builder: (_) => WarningPopup(
              title: S.of(context).Warning_cancel_record,
              cancel: () => Navigator.pop(context),
              delete: () {
                Navigator.pop(context);
                Navigator.pop(context);
              }));
    else
      Navigator.pop(context);
  }

  void addMedicalRecord() {
    if (checkRequiredFill(data.label)) {
      BlocProvider.of<MedicalRecordCubit>(widget.superContext)
          .addData(data)
          .then((value) {
        if (value) {
          BlocProvider.of<MedicalRecordCubit>(widget.superContext).loadData();
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(S.of(context).Add_record +
                  ' ' +
                  S.of(context).successfully +
                  '!')));
        }
      });
    } else
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).required_fill + '!')));
  }

  void updateMedicalRecord() {
    if (checkRequiredFill(data.label)) {
      BlocProvider.of<MedicalRecordCubit>(widget.superContext)
          .addData(data)
          .then((value) {
        if (value) {
          BlocProvider.of<MedicalRecordCubit>(widget.superContext).loadData();
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(S.of(context).Add_record +
                  ' ' +
                  S.of(context).successfully +
                  '!')));
        }
      });
    } else
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).required_fill + '!')));
  }

  bool checkRequiredFill(MedicalRecordLabel label) {
    if (label.name == "") {
      FocusScope.of(context).requestFocus(_nameFocus);
      return false;
    }
    if (label.location == "") {
      FocusScope.of(context).requestFocus(_locationFocus);
      return false;
    }
    return true;
  }

  Future<dynamic> onPhotoTap(int index, int photoIndex) {
    return showModalBottomSheet(
        enableDrag: false,
        isScrollControlled: true,
        context: context,
        builder: (_) => SafeArea(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: InteractiveViewer(
                            child: Image.file(images[index][photoIndex],
                                fit: BoxFit.contain)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: CommonButton.round(
                            context,
                            () => showDialog(
                                context: context,
                                builder: (_) => WarningPopup(
                                    title: S.of(context).Warning_delete_photo,
                                    cancel: () => Navigator.pop(context),
                                    delete: () {
                                      setState(() {
                                        images[index].removeAt(photoIndex);
                                      });
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    })),
                            S.of(context).Delete_photo,
                            AnthealthColors.warning1),
                      )
                    ]))));
  }

  Future<dynamic> onAddPhotoTap(int index) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => SafeArea(
            child: SizedBox(
                height: 150,
                child: Column(children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        pickImage(ImageSource.camera, index);
                      },
                      child: Container(
                          height: 64,
                          color: Colors.transparent,
                          padding: const EdgeInsets.all(16),
                          child: Row(children: [
                            Image.asset(
                                "assets/app_icon/small_icons/camera_bla2.png"),
                            SizedBox(width: 8),
                            Text(S.of(context).Pick_camera,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: AnthealthColors.black2))
                          ]))),
                  CustomDivider.common(),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        pickImage(ImageSource.gallery, index);
                      },
                      child: Container(
                          height: 64,
                          color: Colors.transparent,
                          padding: const EdgeInsets.all(16),
                          child: Row(children: [
                            Image.asset(
                                "assets/app_icon/small_icons/photo_bla2.png"),
                            SizedBox(width: 8),
                            Text(S.of(context).Pick_gallery,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: AnthealthColors.black2))
                          ])))
                ]))));
  }

  Future pickImage(ImageSource imageSource, int index) async {
    try {
      final mImage = await ImagePicker().pickImage(source: imageSource);
      if (mImage == null) return;
      setState(() {
        images[index].add(File(mImage.path));
      });
    } on PlatformException catch (e) {
      print("Failed to pick Image: $e");
    }
  }
}
