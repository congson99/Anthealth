import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/dashboard/dashboard_models.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/views/common_pages/error_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_dashboard_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/medic/medical_directory/medical_directory_page.dart';
import 'package:anthealth_mobile/views/medic/medical_map/medical_map_page.dart';
import 'package:anthealth_mobile/views/medic/medical_record/medical_record_page.dart';
import 'package:anthealth_mobile/views/medic/medicine_box/medicine_box_add_page.dart';
import 'package:anthealth_mobile/views/medic/medicine_box/medicine_box_page.dart';
import 'package:anthealth_mobile/views/settings/setting_page.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicPage extends StatelessWidget {
  const MedicPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<DashboardCubit, CubitState>(builder: (context, state) {
        if (state is MedicState)
          return TemplateDashboardPage(
              title: S.of(context).Medic_record,
              name: user.name,
              setting: () => setting(context),
              content: buildContent(context, state.medicPageData));
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
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => MedicineBoxPage(id: "id")))),
                      SizedBox(height: 16)
                    ]))
            .toList(),
        SectionComponent(
            title: S.of(context).Add_medicine_box,
            colorID: 1,
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => MedicineBoxAddPage())),
            isDirection: false,
            iconPath: "assets/app_icon/small_icons/add_medicine_box_sec2.png")
      ]);

  Widget buildDirectory(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        CommonText.section(S.of(context).Hospital, context),
        SizedBox(height: 16),
        SectionComponent(
            title: S.of(context).Medical_directory,
            colorID: 0,
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => MedicalDirectoryPage()))),
        SizedBox(height: 16),
        SectionComponent(
            iconPath: "assets/app_icon/common/location_sec0.png",
            title: S.of(context).Medical_map,
            colorID: 1,
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => MedicalMapPage())))
      ]);

  // Actions
  void setting(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => SettingsPage(appContext: context)));
  }
}
