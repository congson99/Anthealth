import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/logics/medicine_logic.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_cubit.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_detail_cubit.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_detail_state.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/views/common_pages/add_photo_view.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_pages/photo_view.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
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
  var _timeController = TextEditingController();
  var _appointmentTimeController = TextEditingController();
  var _nameFocus = FocusNode();
  var _locationFocus = FocusNode();

  @override
  void initState() {
    _timeController.text = DateFormat("dd.MM.yyyy").format(
        (widget.medicalRecordDetailData == null)
            ? DateTime.now()
            : widget.medicalRecordDetailData!.getLabel().getDateTime());
    _appointmentTimeController.text = (widget.medicalRecordDetailData == null)
        ? DateFormat("dd.MM.yyyy").format(DateTime.now())
        : ((widget.medicalRecordDetailData!.getAppointment()!.getName() == "")
            ? ""
            : DateFormat("dd.MM.yyyy").format(widget.medicalRecordDetailData!
                .getAppointment()!
                .getDateTime()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocProvider<MedicalRecordDetailCubit>(
      create: (context) =>
          MedicalRecordDetailCubit("add", widget.medicalRecordDetailData),
      child: BlocBuilder<MedicalRecordDetailCubit, CubitState>(
          builder: (context, state) {
        if (state is MedicalRecordDetailState)
          return Scaffold(
              body: SafeArea(
                  child: Stack(children: [
            Container(
                color: AnthealthColors.black4,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.only(top: 57, left: 8, right: 8),
                child:
                    SingleChildScrollView(child: buildContent(context, state))),
            CustomAppBar(
                title: (widget.medicalRecordDetailData == null)
                    ? S.of(context).Add_medical_record
                    : S.of(context).Update_medical_record,
                back: () => back())
          ])));
        else
          return LoadingPage();
      }));

  // Content
  Widget buildContent(BuildContext context, MedicalRecordDetailState state) =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(height: 8, color: Colors.transparent),
        buildEditingComponent(context, state),
        buildButton(context, state)
      ]);

  // Content Component
  Container buildEditingComponent(
      BuildContext context, MedicalRecordDetailState state) {
    return Container(
        color: Colors.white,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          buildDescription(context, state),
          CustomDivider.cutLine(MediaQuery.of(context).size.width),
          buildPhotoComponent(context, 0, state,
              title: S.of(context).General_information),
          CustomDivider.cutLine(MediaQuery.of(context).size.width),
          buildPhotoComponent(context, 1, state,
              title: S.of(context).Medical_test),
          CustomDivider.cutLine(MediaQuery.of(context).size.width),
          buildPhotoComponent(context, 2, state, title: S.of(context).Diagnose),
          CustomDivider.cutLine(MediaQuery.of(context).size.width),
          buildPrescription(context, state),
          buildPhotoComponent(context, 3, state,
              isShowNullData:
                  (state.data.getPrescription().length == 0) ? true : false),
          CustomDivider.cutLine(MediaQuery.of(context).size.width),
          buildAppointment(context, state),
          SizedBox(height: 8)
        ]));
  }

  Padding buildButton(BuildContext context, MedicalRecordDetailState state) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: (widget.medicalRecordDetailData == null)
            ? CommonButton.round(context, () => addMedicalRecord(state),
                S.of(context).Add_medical_record, AnthealthColors.secondary1)
            : CommonButton.round(
                context,
                () => updateMedicalRecord(state),
                S.of(context).Update_medical_record,
                AnthealthColors.secondary1));
  }

  // Editing Component
  Widget buildDescription(
          BuildContext context, MedicalRecordDetailState state) =>
      Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 16),
            CommonTextField.fill(
                context: context,
                initialValue: state.data.getLabel().getName(),
                focusNode: _nameFocus,
                onChanged: (String value) => editName(state, value),
                labelText: S.of(context).Record_name + " (*)",
                hintText: S.of(context).Hint_record_name),
            SizedBox(height: 28),
            CommonTextField.select(
                labelText: S.of(context).Medical_location + " (*)",
                focusNode: _locationFocus,
                data: state.locationList,
                value: (state.data.getLabel().getLocation() == "")
                    ? null
                    : state.data.getLabel().getLocation(),
                onChanged: (value) => editLocation(state, value!)),
            SizedBox(height: 20),
            CommonTextField.fill(
                textEditingController: _timeController,
                onTap: () => onTimeTap(state),
                context: context,
                onChanged: (String value) => {},
                labelText: S.of(context).Medical_date + " (*)"),
            SizedBox(height: 24),
            Text("(*) " + S.of(context).Required_content,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: AnthealthColors.warning0)),
            SizedBox(height: 4)
          ]));

  Widget buildPhotoComponent(
          BuildContext context, int index, MedicalRecordDetailState state,
          {String? title, bool? isShowNullData}) =>
      Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            if (title != null) CommonText.subSection(title, context),
            if (title != null) SizedBox(height: 16),
            buildPhotoAddList(context, state, index)
          ]));

  Widget buildPrescription(
          BuildContext context, MedicalRecordDetailState state) =>
      Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            CommonText.subSection(S.of(context).Prescription, context),
            SizedBox(height: 16),
            buildDigitalPrescription(context, state)
          ]));

  Widget buildAppointment(
          BuildContext context, MedicalRecordDetailState state) =>
      Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 16),
            CommonText.subSection(S.of(context).Re_examination, context),
            SizedBox(height: 24),
            CommonTextField.fill(
                context: context,
                initialValue: state.data.getAppointment()!.getName(),
                onChanged: (String value) =>
                    editAppointmentContent(state, value),
                labelText: S.of(context).Content,
                hintText: S.of(context).Hint_re_examination),
            SizedBox(height: 28),
            CommonTextField.select(
                labelText: S.of(context).Medical_location,
                data: state.locationList,
                value: (state.data.getAppointment()!.getLocation() == "")
                    ? ((state.data.getLabel().getLocation() == "")
                        ? null
                        : state.data.getLabel().getLocation())
                    : state.data.getAppointment()!.getLocation(),
                onChanged: (value) => editAppointmentLocation(state, value!)),
            SizedBox(height: 20),
            CommonTextField.fill(
                textEditingController: _appointmentTimeController,
                onTap: () => onAppointmentTimeTap(state),
                context: context,
                onChanged: (String value) => {},
                labelText: S.of(context).Medical_date),
            SizedBox(height: 8)
          ]));

  // Child Component
  Widget buildTitleTextLine(
          BuildContext context, String label, String content) =>
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(label + ":",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: AnthealthColors.black1)),
            Expanded(
                child: CustomDivider.dash(
                    height: 1,
                    weight: MediaQuery.of(context).size.width * 0.8)),
            Text(content,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AnthealthColors.black1))
          ]);

  Widget buildPhotoAddList(
      BuildContext context, MedicalRecordDetailState state, int index) {
    final double width = MediaQuery.of(context).size.width - 48;
    final int count = width ~/ 100;
    final double size = (width - (count - 1) * 16) / count;
    return Wrap(spacing: 16, runSpacing: 16, children: [
      ...state.list[index]
              .map((e) => Container(
                  height: size,
                  width: size,
                  child: GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => PhotoView(
                              photo: e,
                              superContext: context,
                              state: state,
                              photoIndex: state.list[index].indexOf(e),
                              index: index))),
                      child: Image.file(e, fit: BoxFit.cover))))
              .toList() +
          [
            Container(
                height: (state.list[index].length == 0) ? 32 : size,
                width: (state.list[index].length == 0) ? 150 : size,
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => AddPhotoView(
                            superContext: context,
                            state: state,
                            index: index))),
                    child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CommonText.tapTextImage(
                            context,
                            "assets/app_icon/small_icons/add_photo_pri1.png",
                            S.of(context).Add_photo,
                            AnthealthColors.primary1))))
          ]
    ]);
  }

  Widget buildDigitalPrescription(
          BuildContext context, MedicalRecordDetailState state) =>
      Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: state.medicine
                  .map((medicine) => Container(
                      child: buildPrescriptionComponent(context, state,
                          medicine, state.medicine.indexOf(medicine))))
                  .toList() +
              [
                Container(
                  child: GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => AddPrescriptionMedicinePage(
                              superContext: context, superState: state))),
                      child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CommonText.tapTextImage(
                              context,
                              "assets/app_icon/small_icons/add_medicine_sec1.png",
                              S.of(context).Add_medicine,
                              AnthealthColors.secondary1))),
                )
              ]);

  Widget buildPrescriptionComponent(BuildContext context,
      MedicalRecordDetailState state, DigitalMedicine medicine, int index) {
    return GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => AddPrescriptionMedicinePage(
                superContext: context,
                superState: state,
                medicine: medicine,
                index: index))),
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
                        child: Text(medicine.getName(),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: AnthealthColors.secondary0))),
                    Text(
                        MedicineLogic.handleQuantity(medicine.getQuantity()) +
                            " " +
                            MedicineLogic.getUnit(context, medicine.getUnit()),
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

  // Editing Function
  void editName(MedicalRecordDetailState state, String value) {
    BlocProvider.of<MedicalRecordDetailCubit>(context)
        .updateData(state.data, "name", value, state.list, state.medicine);
  }

  void editLocation(MedicalRecordDetailState state, String value) {
    BlocProvider.of<MedicalRecordDetailCubit>(context)
        .updateData(state.data, "location", value, state.list, state.medicine);
  }

  void editAppointmentContent(MedicalRecordDetailState state, String value) {
    BlocProvider.of<MedicalRecordDetailCubit>(context).updateData(
        state.data, "appointment_content", value, state.list, state.medicine);
  }

  void editAppointmentLocation(MedicalRecordDetailState state, String value) {
    BlocProvider.of<MedicalRecordDetailCubit>(context).updateData(
        state.data, "appointment_location", value, state.list, state.medicine);
  }

  void onTimeTap(MedicalRecordDetailState state) {
    showModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        builder: (_) => DateTimePickerBottomSheet(
            dateTime: state.data.getLabel().getDateTime(),
            isTime: false,
            cancel: () => Navigator.pop(context),
            ok: (time) {
              setState(() =>
                  _timeController.text = DateFormat("dd.MM.yyyy").format(time));
              BlocProvider.of<MedicalRecordDetailCubit>(context).updateData(
                  state.data, "time", time, state.list, state.medicine);
              Navigator.pop(context);
            }));
  }

  void onAppointmentTimeTap(MedicalRecordDetailState state) {
    showModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        builder: (_) => DateTimePickerBottomSheet(
            isFuture: true,
            dateTime: state.data.getLabel().getDateTime(),
            isTime: false,
            cancel: () => Navigator.pop(context),
            ok: (time) {
              setState(() => _appointmentTimeController.text =
                  DateFormat("dd.MM.yyyy").format(time));
              BlocProvider.of<MedicalRecordDetailCubit>(context).updateData(
                  state.data,
                  "appointment_time",
                  time,
                  state.list,
                  state.medicine);
              Navigator.pop(context);
            }));
  }

  // Actions
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

  void addMedicalRecord(MedicalRecordDetailState state) {
    if (checkRequiredFill(state.data.getLabel())) {
      BlocProvider.of<MedicalRecordCubit>(widget.superContext)
          .addData(state.data, state.list)
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

  void updateMedicalRecord(MedicalRecordDetailState state) {
    if (checkRequiredFill(state.data.getLabel())) {
      BlocProvider.of<MedicalRecordCubit>(widget.superContext)
          .addData(state.data, state.list)
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
    if (label.getName() == "") {
      FocusScope.of(context).requestFocus(_nameFocus);
      return false;
    }
    if (label.getLocation() == "") {
      FocusScope.of(context).requestFocus(_locationFocus);
      return false;
    }
    return true;
  }
}
