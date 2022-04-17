import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/dashboard/dashboard_models.dart';
import 'package:anthealth_mobile/views/common_pages/error_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/header.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/medic/medic_directory/medical_directory_page.dart';
import 'package:anthealth_mobile/views/medic/medical_record/medical_record_page.dart';
import 'package:anthealth_mobile/views/settings/setting_page.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicPage extends StatelessWidget {
  const MedicPage({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<DashboardCubit, CubitState>(builder: (context, state) {
        if (state is MedicState)
          return Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                  child: Stack(children: [
                Container(
                    margin: const EdgeInsets.only(
                        left: 16, right: 16, top: 82, bottom: 130),
                    child: buildContent(context, state.medicPageData)),
                Header(
                    title: S.of(context).Medic_record,
                    content: name,
                    isNotification: false,
                    isMessage: false,
                    onSettingsTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => SettingsPage(appContext: context))))
              ])));
        return ErrorPage();
      });

  Widget buildContent(BuildContext context, MedicPageData pageData) =>
      Column(children: [
        CustomDivider.common(),
        SizedBox(height: 16),
        buildMedicalRecord(context, pageData),
        SizedBox(height: 32),
        CustomDivider.common(),
        SizedBox(height: 16),
        buildMedicineBoxManagement(context, pageData),
        SizedBox(height: 32),
        CustomDivider.common(),
        SizedBox(height: 16),
        buildDirectory(context)
      ]);

  Widget buildMedicalRecord(BuildContext context, MedicPageData pageData) =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        CommonText.section(S.of(context).Medical_record, context),
        SizedBox(height: 16),
        SectionComponent(
            title: S.of(context).Medical_history,
            subTitle: S.of(context).Latest + ': ' + pageData.getLatestRecord(),
            colorID: 0,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => MedicalRecordPage(dashboardContext: context)))),
        if (pageData.getLatestAppointment() != '') SizedBox(height: 16),
        if (pageData.getLatestAppointment() != '')
          SectionComponent(
              title: S.of(context).Medical_appointment,
              subTitle: pageData.getLatestAppointment(),
              colorID: 1)
      ]);

  Widget buildMedicineBoxManagement(
          BuildContext context, MedicPageData pageData) =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        CommonText.section(S.of(context).Medicine_box_management, context),
        SizedBox(height: 16),
        ...pageData
            .getListMedicineBox()
            .map((data) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SectionComponent(
                          title: data,
                          colorID: 0,
                          onTap: () {
                            //Todo
                          }),
                      SizedBox(height: 16)
                    ]))
            .toList(),
        SectionComponent(
            title: S.of(context).Add_medicine_box,
            colorID: 1,
            isDirection: false,
            iconPath: "assets/app_icon/small_icons/add_medicine_box_sec2.png")
      ]);

  Widget buildDirectory(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        CommonText.section(S.of(context).Directory, context),
        SizedBox(height: 16),
        SectionComponent(
            title: S.of(context).Medical_directory,
            colorID: 0,
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => MedicalDirectoryPage())))
      ]);
}
