import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_cubit.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/medic/medical_record/medical_record_add_page.dart';
import 'package:anthealth_mobile/views/medic/medical_record/medical_record_detail_page.dart';
import 'package:anthealth_mobile/views/medic/medical_record/widgets/medical_record_list.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MedicalRecordPage extends StatelessWidget {
  const MedicalRecordPage({Key? key, required this.dashboardContext})
      : super(key: key);

  final BuildContext dashboardContext;

  @override
  Widget build(BuildContext context) => BlocProvider<MedicalRecordCubit>(
      create: (context) => MedicalRecordCubit(),
      child: BlocBuilder<MedicalRecordCubit, CubitState>(
          builder: (context, state) {
        if (state is MedicalRecordState)
          return TemplateFormPage(
              title: S.of(context).Medical_record,
              back: () => back(context),
              add: () => add(context),
              settings: () {},
              content: buildContent(context, state));
        else
          return LoadingPage();
      }));

  // Content
  Widget buildContent(BuildContext context, MedicalRecordState state) =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        CommonText.section(S.of(context).Record, context),
        SizedBox(height: 16),
        buildDetailContainer(context, state),
        if (state.data.getListAppointment().length != 0)
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 32),
                CommonText.section(S.of(context).Medical_appointment, context),
                SizedBox(height: 16),
                buildAppointmentList(context, state.data.getListAppointment())
              ]),
        SizedBox(height: 32)
      ]);

  // Component
  Widget buildDetailContainer(BuildContext context, MedicalRecordState state) =>
      Container(
          decoration: BoxDecoration(
              color: AnthealthColors.primary5,
              borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: (state.data.getListYearLabel().length != 0)
              ? Column(children: [
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
                                    .copyWith(color: AnthealthColors.primary1)),
                            Text(S.of(context).Number_of_record,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: AnthealthColors.primary1))
                          ])),
                  Divider(
                      thickness: 1, height: 1, color: AnthealthColors.primary1),
                  ...state.data
                      .getListYearLabel()
                      .map((data) => buildYearLabel(data, context, state))
                      .toList()
                ])
              : Text(S.of(context).no_medical_record,
                  style: Theme.of(context).textTheme.bodyText2));

  Widget buildAppointmentList(
          BuildContext context, List<MedicalAppointment> listAppointment) =>
      Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: listAppointment
              .map((data) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SectionComponent(
                      title:
                          DateFormat("dd.MM.yyyy").format(data.getDateTime()) +
                              ' - ' +
                              data.getLocation(),
                      subTitle: S.of(context).Previous_medical_record +
                          ": " +
                          DateFormat("dd.MM.yyyy").format(data.getLastTime()),
                      subSubTitle:
                          S.of(context).Content + ": " + data.getName(),
                      onTap: () {
                        //Todo
                      },
                      colorID: 1)))
              .toList());

  Widget buildYearLabel(MedicalRecordYearLabel data, BuildContext context,
          MedicalRecordState state) =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        MedicalRecordLabelComponent(
            left: data.getDateTime().year.toString(),
            right: data.getQuantity().toString(),
            isOpen: data.getOpeningState(),
            onTap: () => BlocProvider.of<MedicalRecordCubit>(context)
                .updateOpeningState(
                    state.data.getListYearLabel().indexOf(data), state.data)),
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
        if (state.data.getListYearLabel().indexOf(data) <
            state.data.getListYearLabel().length - 1)
          Divider(thickness: 0.5, height: 0.5, color: AnthealthColors.primary1)
      ]);

  Widget buildLabel(BuildContext context, MedicalRecordLabel mData) =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Divider(thickness: 0.5, height: 0.5, color: AnthealthColors.primary1),
        MedicalRecordLabelComponent(
            left: DateFormat('dd.MM').format(mData.getDateTime()) +
                ' ' +
                mData.getLocation(),
            right: mData.getName(),
            isOpen: false,
            isDirection: false,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => MedicalRecordDetailPage(
                    superContext: context, medicalRecordID: mData.getID()))))
      ]);

  // Actions
  void back(BuildContext context) {
    BlocProvider.of<DashboardCubit>(dashboardContext).medic();
    Navigator.pop(context);
  }

  void add(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => MedicalRecordAddPage(superContext: context)));
  }
}
