import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/logics/medicine_logic.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_cubit.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_detail_cubit.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_detail_state.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_appbar.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_appbar_with_avatar.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/photo_list_label.dart';
import 'package:anthealth_mobile/views/common_widgets/warning_popup.dart';
import 'package:anthealth_mobile/views/medic/medical_record/medical_record_add_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MedicalRecordDetailPage extends StatelessWidget {
  const MedicalRecordDetailPage(
      {Key? key,
       this.superContext,
      required this.medicalRecordID,
      this.data})
      : super(key: key);

  final BuildContext? superContext;
  final String medicalRecordID;
  final FamilyMemberData? data;

  @override
  Widget build(BuildContext context) => BlocProvider<MedicalRecordDetailCubit>(
      create: (context) => MedicalRecordDetailCubit(medicalRecordID),
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
                padding: (data == null)
                    ? EdgeInsets.only(top: 57, left: 8, right: 8)
                    : EdgeInsets.only(top: 81, left: 8, right: 8),
                child:
                    SingleChildScrollView(child: buildContent(context, state))),
            if (data == null)
              CustomAppBar(
                  title: S.of(context).Medical_record_detail,
                  back: () => Navigator.pop(context),
                  edit: () => edit(context, state.data),
                  delete: () => delete(context)),
            if (data != null)
              CustomAppbarWithAvatar(
                  context: context,
                  name: data!.name,
                  firstTitle: S.of(context).Medical_record_detail,
                  avatarPath: data!.avatarPath)
          ])));
        else
          return LoadingPage();
      }));

  Widget buildContent(BuildContext context, MedicalRecordDetailState state) =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(height: 8, color: Colors.transparent),
        Container(
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 4),
                  buildDescription(context, state.data.label),
                  CustomDivider.cutLine(MediaQuery.of(context).size.width),
                  buildPhotoComponent(
                      context,
                      S.of(context).General_information,
                      state.data.detailPhoto),
                  CustomDivider.cutLine(MediaQuery.of(context).size.width),
                  buildPhotoComponent(context, S.of(context).Medical_test,
                      state.data.detailPhoto),
                  CustomDivider.cutLine(MediaQuery.of(context).size.width),
                  buildPhotoComponent(
                      context, S.of(context).Diagnose, state.data.detailPhoto),
                  CustomDivider.cutLine(MediaQuery.of(context).size.width),
                  buildPrescription(context, state.data.prescriptionPhoto,
                      state.data.prescription),
                  buildAppointment(state, context)
                ])),
        Container(height: 16, color: Colors.transparent)
      ]);

  /// Main Components
  Widget buildDescription(BuildContext context, MedicalRecordLabel label) =>
      Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            buildTitleTextLine(context, S.of(context).Record_name, label.name),
            SizedBox(height: 16),
            buildTitleTextLine(
                context, S.of(context).Medical_location, label.location),
            SizedBox(height: 16),
            buildTitleTextLine(context, S.of(context).Medical_date,
                DateFormat("dd.MM.yyyy").format(label.dateTime))
          ]));

  Widget buildPhotoComponent(
          BuildContext context, String title, List<String> photoData) =>
      Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            CommonText.subSection(title, context),
            SizedBox(height: 16),
            PhotoListLabel(
                photoPath: photoData,
                width: MediaQuery.of(context).size.width - 32 - 16,
                onTap: () {})
          ]));

  Widget buildPrescription(BuildContext context, List<String> photoData,
          List<DigitalMedicine> prescription) =>
      Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            CommonText.subSection(S.of(context).Prescription, context),
            if (prescription.length > 0) SizedBox(height: 16),
            if (prescription.length > 0)
              buildDigitalPrescription(context, prescription),
            SizedBox(height: 16),
            PhotoListLabel(
                photoPath: photoData,
                width: MediaQuery.of(context).size.width - 32 - 16,
                onTap: () {},
                isShowNoData: (prescription.length == 0) ? true : false)
          ]));

  Widget buildAppointment(
      MedicalRecordDetailState state, BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CustomDivider.cutLine(MediaQuery.of(context).size.width),
      Padding(
        padding: const EdgeInsets.all(16),
        child: CommonText.section(S.of(context).Medical_appointment, context),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: (state.data.appointment.name != "")
              ? Container(
                  decoration: BoxDecoration(
                      color: AnthealthColors.secondary5,
                      borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            S.of(context).Content +
                                ": " +
                                state.data.appointment.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: AnthealthColors.secondary0)),
                        SizedBox(height: 4),
                        Text(
                            S.of(context).Medical_date +
                                ": " +
                                DateFormat("dd.MM.yyyy")
                                    .format(state.data.appointment.dateTime),
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: AnthealthColors.secondary1)),
                        SizedBox(height: 4),
                        Text(
                            S.of(context).Medical_location +
                                ": " +
                                state.data.appointment.location,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: AnthealthColors.secondary1))
                      ]))
              : Text(S.of(context).no_section_data,
                  style: Theme.of(context).textTheme.bodyText2)),
      SizedBox(height: 32)
    ]);
  }

  /// Sub Components
  Widget buildTitleTextLine(
          BuildContext context, String label, String content) =>
      Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(label + ":",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: AnthealthColors.black1)),
        SizedBox(width: 4),
        Container(
          width: MediaQuery.of(context).size.width - 48 - label.length * 11,
          child: Text(content,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: AnthealthColors.black1)),
        )
      ]);

  Widget buildDigitalPrescription(
      BuildContext context, List<DigitalMedicine> prescription) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(S.of(context).Medicine,
                    style: Theme.of(context).textTheme.subtitle1),
                Text(S.of(context).Quantity,
                    style: Theme.of(context).textTheme.subtitle1)
              ]),
              SizedBox(height: 8),
              Divider(height: 1, thickness: 1, color: AnthealthColors.black1)
            ] +
            prescription
                .map(
                    (medicine) => buildPrescriptionComponent(context, medicine))
                .toList());
  }

  Widget buildPrescriptionComponent(
      BuildContext context, DigitalMedicine medicine) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SizedBox(height: 8),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(medicine.name, style: Theme.of(context).textTheme.bodyText1),
        Expanded(child: Container()),
        Text(MedicineLogic.handleQuantity(medicine.quantity),
            style: Theme.of(context).textTheme.bodyText1),
        SizedBox(width: 4),
        Text(MedicineLogic.getUnit(context, medicine.unit),
            style: Theme.of(context).textTheme.bodyText1)
      ]),
      SizedBox(height: 8),
      CustomDivider.dash(),
      SizedBox(height: 10),
      Text(MedicineLogic.handleMedicineString(context, medicine),
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12)),
      SizedBox(height: 10),
      Divider(height: 0.5, thickness: 0.5, color: AnthealthColors.black1)
    ]);
  }

  /// Actions
  void edit(BuildContext context, MedicalRecordDetailData data) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => MedicalRecordAddPage(
            superContext: superContext!, medicalRecordDetailData: data)));
  }

  void delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => WarningPopup(
            title: S.of(context).Warning_delete_record,
            cancel: () => Navigator.pop(context),
            delete: () {
              BlocProvider.of<MedicalRecordCubit>(superContext!)
                  .deleteData(medicalRecordID)
                  .then((value) {
                if (value) {
                  BlocProvider.of<MedicalRecordCubit>(superContext!).loadData();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(S.of(context).Delete_record +
                          ' ' +
                          S.of(context).successfully +
                          '!')));
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              });
            }));
  }
}
