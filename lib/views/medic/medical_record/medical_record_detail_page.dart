import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_cubit.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_detail_cubit.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_detail_state.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_appbar.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/photo_list_label.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/common_widgets/warning_popup.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MedicalRecordDetailPage extends StatelessWidget {
  const MedicalRecordDetailPage(
      {Key? key, required this.superContext, required this.medicalRecordID})
      : super(key: key);

  final BuildContext superContext;
  final String medicalRecordID;

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
                padding: const EdgeInsets.only(top: 57, left: 8, right: 8),
                child:
                    SingleChildScrollView(child: buildContent(context, state))),
            CustomAppBar(
                title: S.of(context).Medical_record_detail,
                back: () => Navigator.pop(context),
                delete: () => showDialog(
                    context: context,
                    builder: (_) => WarningPopup(
                        title: S.of(context).Warning_delete_record,
                        cancel: () => Navigator.pop(context),
                        delete: () {
                          BlocProvider.of<MedicalRecordCubit>(superContext)
                              .deleteData(medicalRecordID)
                              .then((value) {
                            if (value) {
                              BlocProvider.of<MedicalRecordCubit>(superContext)
                                  .loadData();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          S.of(context).Delete_record +
                                              ' ' +
                                              S.of(context).successfully +
                                              '!')));
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          });
                        })))
          ])));
        else
          return LoadingPage();
      }));

  Widget buildContent(BuildContext context, MedicalRecordDetailState state) =>
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(height: 8, color: Colors.transparent),
            Container(
                color: Colors.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildDescription(context, state.data.getLabel()),
                      CustomDivider.cutLine(MediaQuery.of(context).size.width),
                      buildPhotoComponent(
                          context,
                          S.of(context).General_information,
                          state.data.getDetailPhoto()),
                      CustomDivider.cutLine(MediaQuery.of(context).size.width),
                      buildPhotoComponent(context, S.of(context).Medical_test,
                          state.data.getDetailPhoto()),
                      CustomDivider.cutLine(MediaQuery.of(context).size.width),
                      buildPhotoComponent(context, S.of(context).Diagnose,
                          state.data.getDetailPhoto()),
                      CustomDivider.cutLine(MediaQuery.of(context).size.width),
                      buildPrescription(
                          context,
                          state.data.getPrescriptionPhoto(),
                          state.data.getPrescription()),
                      if (state.data.getAppointment()!.getName() != "")
                        buildAppointment(state, context)
                    ])),
            Container(height: 16, color: Colors.transparent)
          ]);

  Widget buildAppointment(
      MedicalRecordDetailState state, BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomDivider.cutLine(MediaQuery.of(context).size.width),
          Padding(
            padding: const EdgeInsets.all(16),
            child:
                CommonText.section(S.of(context).Medical_appointment, context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SectionComponent(
                title: S.of(context).Content +
                    ": " +
                    state.data.getAppointment()!.getName(),
                subTitle: DateFormat("dd.MM.yyyy")
                        .format(state.data.getAppointment()!.getDateTime()) +
                    " - " +
                    state.data.getAppointment()!.getLocation(),
                isDirection: false,
                colorID: 1),
          ),
          SizedBox(height: 32)
        ]);
  }

  // Content
  Widget buildDescription(BuildContext context, MedicalRecordLabel label) =>
      Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTitleTextLine(
                    context, S.of(context).Record_name, label.getName()),
                SizedBox(height: 16),
                buildTitleTextLine(context, S.of(context).Medical_location,
                    label.getLocation()),
                SizedBox(height: 16),
                buildTitleTextLine(context, S.of(context).Medical_date,
                    DateFormat("dd.MM.yyyy").format(label.getDateTime()))
              ]));

  Widget buildPhotoComponent(
          BuildContext context, String title, List<String> photoData) =>
      Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CommonText.subSection(S.of(context).Prescription, context),
                SizedBox(height: 16),
                buildDigitalPrescription(context, prescription),
                SizedBox(height: 16),
                PhotoListLabel(
                    photoPath: photoData,
                    width: MediaQuery.of(context).size.width - 32 - 16,
                    onTap: () {},
                    isShowNoData: (prescription.length == 0) ? true : false)
              ]));

  // Component
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

  Widget buildDigitalPrescription(
          BuildContext context, List<DigitalMedicine> prescription) =>
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(S.of(context).Medicine,
                      style: Theme.of(context).textTheme.subtitle1),
                  Text(S.of(context).Quantity,
                      style: Theme.of(context).textTheme.subtitle1)
                ]),
            SizedBox(height: 8),
            Divider(height: 1, thickness: 1, color: AnthealthColors.black1),
            buildPrescriptionComponent(
                context, DigitalMedicine("", "name", 1, 0, 0, [],[], 0)),
          ]);

  Widget buildPrescriptionComponent(
          BuildContext context, DigitalMedicine medicine) =>
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 8),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(medicine.getName(),
                      style: Theme.of(context).textTheme.bodyText1),
                  Expanded(child: Container()),
                  Text(medicine.getQuantity().toString(),
                      style: Theme.of(context).textTheme.bodyText1),
                  SizedBox(width: 4),
                  Text(medicine.getUnit().toString(),
                      style: Theme.of(context).textTheme.bodyText1)
                ]),
            SizedBox(height: 8),
            CustomDivider.dash(),
            SizedBox(height: 8),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(medicine.getUsage().toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 12)),
                  Text(' | ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 12)),
                  Text(medicine.getRepeat().toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 12))
                ]),
            SizedBox(height: 8),
            Divider(height: 1, thickness: 1, color: AnthealthColors.black1)
          ]);
}
