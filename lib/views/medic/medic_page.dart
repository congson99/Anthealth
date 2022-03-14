import 'package:anthealth_mobile/blocs/app_cubit.dart';
import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/dashboard/dashboard_models.dart';
import 'package:anthealth_mobile/views/common_pages/error_page.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/medic/medical_record/medical_record_page.dart';
import 'package:anthealth_mobile/views/settings/setting_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:anthealth_mobile/views/common_widgets/header.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/health/indicator/height_page.dart';
import 'package:anthealth_mobile/views/health/indicator/indicator_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicPage extends StatelessWidget {
  const MedicPage({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: Stack(children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 90),
            child: buildContent(context),
          ),
          Header(
              title: S.of(context).Medic_record,
              content: name,
              isNotification: false,
              isMessage: false,
              onSettingsTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => SettingsPage(appContext: context))))
        ])));
  }

  Column buildContent(BuildContext context) {
    return Column(children: [
      Divider(height: 0.5, color: AnthealthColors.black3),
      SizedBox(height: 16),
      buildMedicalRecord(context),
      SizedBox(height: 32),
      Divider(height: 0.5, color: AnthealthColors.black3),
      SizedBox(height: 16),
      buildMedicineBoxManagement(context),
      SizedBox(height: 32),
      Divider(height: 0.5, color: AnthealthColors.black3),
      SizedBox(height: 16),
      buildDirectory(context),
      SizedBox(height: 32)
    ]);
  }

  Container buildMedicalRecord(BuildContext context) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          CommonText.section(S.of(context).Medical_record, context),
          SizedBox(height: 16),
          SectionComponent(
              title: S.of(context).Medical_history,
              subTitle: "Lần gần nhất: 18.10.2021 - BV Chợ Rẫy",
              colorID: 0,
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => MedicalRecordPage()))),
          SizedBox(height: 16),
          SectionComponent(
              title: S.of(context).Medical_appointment,
              subTitle: "21.02.2022 - BV ĐHYD",
              colorID: 1)
        ]));
  }

  Container buildMedicineBoxManagement(BuildContext context) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          CommonText.section(S.of(context).Medicine_box_management, context),
          SizedBox(height: 16),
          SectionComponent(title: "Hộp thuốc ở nhà", colorID: 0),
          SizedBox(height: 16),
          SectionComponent(title: "Hộp thuốc nhà nội", colorID: 0),
          SizedBox(height: 16),
          SectionComponent(title: "Hộp thuốc dự phòng", colorID: 0),
          SizedBox(height: 16),
          SectionComponent(
              title: S.of(context).Add_medicine_box,
              colorID: 1,
              isDirection: false,
              iconPath: "assets/app_icon/small_icons/add_medicine_box_sec2.png")
        ]));
  }

  Container buildDirectory(BuildContext context) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          CommonText.section(S.of(context).Medicine_box_management, context),
          SizedBox(height: 16),
          SectionComponent(title: S.of(context).Medical_directory, colorID: 0),
          SizedBox(height: 16),
          SectionComponent(title: S.of(context).Doctor_directory, colorID: 1)
        ]));
  }
}
