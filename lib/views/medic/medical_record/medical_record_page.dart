import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_cubit.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_appbar.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/medic/medical_record/medical_record_detail_page.dart';
import 'package:anthealth_mobile/views/medic/medical_record/widgets/medical_record_list.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MedicalRecordPage extends StatelessWidget {
  const MedicalRecordPage({Key? key}) : super(key: key);

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
                margin: const EdgeInsets.only(top: 65),
                child: SingleChildScrollView(
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: buildContent(context, state.data, state)))),
            CustomAppBar(
                title: S.of(context).Medical_record,
                back: () => Navigator.pop(context),
                add: () {},
                settings: () {})
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
            CommonText.section(S.of(context).Record, context),
            SizedBox(height: 16),
            buildDetailContainer(context, pageData.getListYearLabel(), state),
            if (pageData.getListAppointment().length != 0)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 32),
                  CommonText.section(
                      S.of(context).Medical_appointment, context),
                  SizedBox(height: 16),
                  buildAppointmentList(context, pageData.getListAppointment()),
                ],
              ),
            SizedBox(height: 32)
          ]);

  // Content
  Widget buildDetailContainer(
      BuildContext context,
      List<MedicalRecordYearLabel> listYearLabel,
      MedicalRecordState state) =>
      Container(
          decoration: BoxDecoration(
              color: AnthealthColors.primary5,
              borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: (listYearLabel.length != 0)
              ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 35,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(S.of(context).Time,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                  color: AnthealthColors.primary1)),
                          Text(S.of(context).Number_of_record,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                  color: AnthealthColors.primary1))
                        ])),
                Divider(
                    thickness: 1,
                    height: 1,
                    color: AnthealthColors.primary1),
                ...listYearLabel
                    .map((data) => buildYearLabel(
                    data, context, listYearLabel, state))
                    .toList()
              ])
              : Text(S.of(context).no_medical_record,
              style: Theme.of(context).textTheme.bodyText2));

  Widget buildAppointmentList(
          BuildContext context, List<MedicalAppointment> listAppointment) =>
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: listAppointment
              .map((data) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: SectionComponent(
                        title: DateFormat("dd.MM.yyyy")
                                .format(data.getDateTime()) +
                            ' - ' +
                            data.getLocation(),
                        subTitle: S.of(context).Previous_medical_record +
                            ": " +
                            DateFormat("dd.MM.yyyy").format(data.getLastTime()),
                        subSubTitle: data.getName(),
                        onTap: () {
                          //Todo
                        },
                        colorID: 1),
                  ))
              .toList());

  Widget buildYearLabel(
          MedicalRecordYearLabel data,
          BuildContext context,
          List<MedicalRecordYearLabel> listYearLabel,
          MedicalRecordState state) =>
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MedicalRecordLabelComponent(
                left: data.getDateTime().year.toString(),
                right: data.getQuantity().toString(),
                isOpen: data.getOpeningState(),
                onTap: () => BlocProvider.of<MedicalRecordCubit>(context)
                    .updateOpeningState(
                        listYearLabel.indexOf(data), state.data)),
            if (data.getOpeningState())
              Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: data
                          .getData()
                          .map((mData) => buildLabel(context, mData))
                          .toList())),
            if (listYearLabel.indexOf(data) < listYearLabel.length - 1)
              Divider(
                  thickness: 0.5, height: 0.5, color: AnthealthColors.primary1)
          ]);

  Widget buildLabel(BuildContext context, MedicalRecordLabel mData) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(
                thickness: 0.5, height: 0.5, color: AnthealthColors.primary1),
            MedicalRecordLabelComponent(
                left: DateFormat('dd.MM').format(mData.getDateTime()) +
                    ' ' +
                    mData.getLocation(),
                right: mData.getName(),
                isOpen: false,
                isDirection: false,
                onTap: () =>
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => MedicalRecordDetailPage()))
                )
          ]);

  void onDetailTap(int index) {
    // if (_filterIndex == 1)
    //   setState(() {
    //     _filterIndex = 0;
    //     _dataIndex = index;
    //   });
    // else
    //   showPopup(index);
  }
}
