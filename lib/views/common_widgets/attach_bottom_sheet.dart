import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/attach/attach_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/community/post_models.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AttachBottomSheet extends StatefulWidget {
  const AttachBottomSheet({
    Key? key,
    required this.medicalRecord,
    required this.family,
    required this.result,
  }) : super(key: key);

  final bool medicalRecord;
  final bool family;
  final Function(Attach) result;

  @override
  State<AttachBottomSheet> createState() => _AttachBottomSheetState();
}

class _AttachBottomSheetState extends State<AttachBottomSheet> {
  int showItem = 0;
  List<MedicalRecordYearLabel> medicalRecordList = [];
  List<FamilyMemberData> family = [];

  @override
  Widget build(BuildContext context) => BlocProvider<AttachCubit>(
      create: (context) => AttachCubit(),
      child: BlocBuilder<AttachCubit, CubitState>(builder: (context, state) {
        return SafeArea(
            child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                    child: (showItem == 0)
                        ? buildMainContent(context)
                        : ((showItem == 1)
                            ? MedicalRecordAttachBottomSheet(
                                medicalRecord: medicalRecordList,
                                result: (result) => widget.result(Attach(
                                    "",
                                    "",
                                    "",
                                    10,
                                    result.id,
                                    result.name +
                                        " (" +
                                        DateFormat("dd.MM.yyyy")
                                            .format(result.dateTime) +
                                        ") - " +
                                        result.location)))
                            : FamilyAttachBottomSheet(
                                family: family,
                                result: (result) => widget.result(Attach(
                                    result.id,
                                    result.name,
                                    result.avatarPath,
                                    11,
                                    "",
                                    "")))))));
      }));

  Widget buildMainContent(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SizedBox(height: 16),
      buildIndicator(),
      buildActivity(),
      if (widget.medicalRecord) buildMedicalRecord(context),
      if (widget.family) buildFamily(context),
    ]);
  }

  Column buildIndicator() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SizedBox(height: 16),
      Text(S.of(context).Health_indicator,
          style: Theme.of(context).textTheme.subtitle1),
      SizedBox(height: 16),
      SectionComponent(
          onTap: () => widget.result(Attach("", "", "", 1, "", "")),
          title: S.of(context).Height,
          colorID: 0,
          isDirection: false,
          iconPath: "assets/app_icon/attach/height.png"),
      SizedBox(height: 16),
      SectionComponent(
          onTap: () => widget.result(Attach("", "", "", 2, "", "")),
          title: S.of(context).Weight,
          colorID: 1,
          isDirection: false,
          iconPath: "assets/app_icon/attach/weight.png"),
      SizedBox(height: 16),
      SectionComponent(
          onTap: () => widget.result(Attach("", "", "", 3, "", "")),
          title: S.of(context).Heart_rate,
          colorID: 2,
          isDirection: false,
          iconPath: "assets/app_icon/attach/heart_rate.png"),
      SizedBox(height: 16),
      SectionComponent(
          onTap: () => widget.result(Attach("", "", "", 6, "", "")),
          title: S.of(context).Spo2,
          colorID: 0,
          isDirection: false,
          iconPath: "assets/app_icon/attach/spo2.png"),
      SizedBox(height: 16),
      SectionComponent(
          onTap: () => widget.result(Attach("", "", "", 4, "", "")),
          title: S.of(context).Temperature,
          colorID: 1,
          isDirection: false,
          iconPath: "assets/app_icon/attach/temperature.png"),
      SizedBox(height: 16),
      SectionComponent(
          onTap: () => widget.result(Attach("", "", "", 5, "", "")),
          title: S.of(context).Blood_pressure,
          colorID: 2,
          isDirection: false,
          iconPath: "assets/app_icon/attach/blood_pressure.png"),
      SizedBox(height: 32),
      CustomDivider.common()
    ]);
  }

  Column buildActivity() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SizedBox(height: 16),
      Text(S.of(context).Activity,
          style: Theme.of(context).textTheme.subtitle1),
      SizedBox(height: 16),
      SectionComponent(
          onTap: () => widget.result(Attach("", "", "", 8, "", "")),
          title: S.of(context).Drink_water,
          colorID: 0,
          isDirection: false,
          iconPath: "assets/app_icon/attach/water.png"),
      SizedBox(height: 16),
      SectionComponent(
          onTap: () => widget.result(Attach("", "", "", 9, "", "")),
          title: S.of(context).Steps,
          colorID: 1,
          isDirection: false,
          iconPath: "assets/app_icon/attach/steps.png"),
      SizedBox(height: 16),
      SectionComponent(
          onTap: () => widget.result(Attach("", "", "", 7, "", "")),
          title: S.of(context).Calo,
          colorID: 2,
          isDirection: false,
          iconPath: "assets/app_icon/attach/calo.png"),
      SizedBox(height: 32),
      CustomDivider.common()
    ]);
  }

  Column buildMedicalRecord(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SizedBox(height: 16),
      Text(S.of(context).Medical_record,
          style: Theme.of(context).textTheme.subtitle1),
      SizedBox(height: 16),
      SectionComponent(
          onTap: () {
            BlocProvider.of<AttachCubit>(context)
                .getMedicalRecord()
                .then((result) => setState(() {
                      medicalRecordList = result;
                      showItem = 1;
                    }));
          },
          title: S.of(context).Medical_record,
          colorID: 0,
          isDirection: false,
          iconPath: "assets/app_icon/attach/medical_record.png"),
      SizedBox(height: 32),
      CustomDivider.common()
    ]);
  }

  Column buildFamily(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SizedBox(height: 16),
      Text(S.of(context).Family, style: Theme.of(context).textTheme.subtitle1),
      SizedBox(height: 16),
      SectionComponent(
          onTap: () {
            BlocProvider.of<AttachCubit>(context)
                .getFamily()
                .then((result) => setState(() {
                      family = result;
                      showItem = 2;
                    }));
          },
          title: S.of(context).Family_member,
          colorID: 2,
          isDirection: false,
          iconPath: "assets/app_icon/attach/family.png"),
      SizedBox(height: 32),
      CustomDivider.common()
    ]);
  }
}

class MedicalRecordAttachBottomSheet extends StatelessWidget {
  const MedicalRecordAttachBottomSheet(
      {Key? key, required this.medicalRecord, required this.result})
      : super(key: key);

  final List<MedicalRecordYearLabel> medicalRecord;
  final Function(MedicalRecordLabel) result;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:
            medicalRecord.map((year) => buildYear(context, year)).toList());
  }

  Widget buildYear(BuildContext context, MedicalRecordYearLabel year) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SizedBox(height: 16),
      Text(year.dateTime.year.toString(),
          style: Theme.of(context).textTheme.subtitle1),
      SizedBox(height: 16),
      ...year.data.map((record) => buildRecord(context, record)),
      SizedBox(height: 16),
      CustomDivider.common()
    ]);
  }

  Widget buildRecord(BuildContext context, MedicalRecordLabel record) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SectionComponent(
          onTap: () => result(record),
          title: S.of(context).Content + ": " + record.name,
          colorID: 0,
          isDirection: false,
          subTitle: DateFormat("dd.MM.yyyy").format(record.dateTime) +
              " - " +
              record.location),
      SizedBox(height: 16)
    ]);
  }
}

class FamilyAttachBottomSheet extends StatelessWidget {
  const FamilyAttachBottomSheet(
      {Key? key, required this.family, required this.result})
      : super(key: key);

  final List<FamilyMemberData> family;
  final Function(FamilyMemberData) result;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 32),
      buildMembers(context),
    ]);
  }

  Widget buildMembers(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 32;
    final int count = width ~/ 90;
    final double size = (width - (count - 1) * 16) / count;
    return Wrap(
        runSpacing: 16,
        spacing: 16,
        children: family
            .map((member) => buildMemberComponent(context, member, size))
            .toList());
  }

  Widget buildMemberComponent(
      BuildContext context, FamilyMemberData member, double size) {
    return GestureDetector(
        onTap: () => result(member),
        child: Container(
            width: size,
            child: Column(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(size),
                child: Image.network(member.avatarPath,
                    width: size * 0.7, height: size * 0.7, fit: BoxFit.cover),
              ),
              SizedBox(height: 8),
              Text(member.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption)
            ])));
  }
}
