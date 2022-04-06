import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_cubit.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_appbar.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/photo_list_label.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MedicalRecordDetailPage extends StatelessWidget {
  const MedicalRecordDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<MedicalRecordCubit>(
      create: (context) => MedicalRecordCubit(),
      child: BlocBuilder<MedicalRecordCubit, CubitState>(
          builder: (context, state) {
        if (state is MedicalRecordState)
          return Scaffold(
              body: SafeArea(
                  child: Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: AnthealthColors.black4,
            ),
            Container(
                color: AnthealthColors.black4,
                padding: const EdgeInsets.only(top: 57, left: 8, right: 8),
                child: SingleChildScrollView(
                    child: buildContent(context, state.data, state))),
            CustomAppBar(
                title: S.of(context).Medical_record_detail,
                back: () => Navigator.pop(context),
                edit: () {})
          ])));
        else
          return LoadingPage();
      }));

  Widget buildContent(BuildContext context, MedicalRecordPageData pageData,
          MedicalRecordState state) =>
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(height: 8, color: Colors.transparent),
            Container(height: 16, color: Colors.white),
            Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: buildDescription(context,
                    MedicalRecordLabel(DateTime.now(), "BV DHYD HCM", "Sick"))),
            CustomDivider.cutLine(MediaQuery.of(context).size.width),
            Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: buildDetail(context, [])),
            CustomDivider.cutLine(MediaQuery.of(context).size.width),
            Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: buildTest(context, [])),
            CustomDivider.cutLine(MediaQuery.of(context).size.width),
            Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: buildDiagnose(context, [])),
            CustomDivider.cutLine(MediaQuery.of(context).size.width),
            Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: buildPrescription(context, [], [])),
            Container(height: 16, color: Colors.white),
            Container(height: 8, color: Colors.transparent)
          ]);

  // Content
  Widget buildDescription(BuildContext context, MedicalRecordLabel label) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitleTextLine(
              context, S.of(context).Record_name, label.getName()),
          SizedBox(height: 16),
          buildTitleTextLine(
              context, S.of(context).Medical_location, label.getLocation()),
          SizedBox(height: 16),
          buildTitleTextLine(context, S.of(context).Medical_date,
              DateFormat("dd.MM.yyyy").format(label.getDateTime()))
        ],
      );

  Widget buildDetail(BuildContext context, List<String> photoData) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonText.subSection(S.of(context).General_information, context),
            SizedBox(height: 16),
            PhotoListLabel(
                photoPath: photoData,
                width: MediaQuery.of(context).size.width - 32 - 16,
                onTap: () {})
          ]);

  Widget buildTest(BuildContext context, List<String> photoData) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonText.subSection(S.of(context).Medical_test, context),
            SizedBox(height: 16),
            PhotoListLabel(
                photoPath: photoData,
                width: MediaQuery.of(context).size.width - 32 - 16,
                onTap: () {})
          ]);

  Widget buildDiagnose(BuildContext context, List<String> photoData) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonText.subSection(S.of(context).Diagnose, context),
            SizedBox(height: 16),
            PhotoListLabel(
                photoPath: photoData,
                width: MediaQuery.of(context).size.width - 32 - 16,
                onTap: () {})
          ]);

  Widget buildPrescription(BuildContext context, List<String> photoData,
          List<DigitalMedicine> prescription) =>
      Column(
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
          ]);

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
            Divider(height: 1,thickness: 1, color: AnthealthColors.black1)
          ]);

  Widget buildPrescriptionComponent(BuildContext context,
      DigitalMedicine medicine) =>
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(medicine.getName(),
                      style: Theme.of(context).textTheme.bodyText1),
                  Text(medicine.getQuantity().toString(),
                      style: Theme.of(context).textTheme.bodyText1)
                ]),
            SizedBox(height: 8),
            Divider(height: 1,thickness: 1, color: AnthealthColors.black1)
          ]);
}
