import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/dashboard_logic.dart';
import 'package:anthealth_mobile/models/dashboard/dashboard_models.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_avatar_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/health/activity/calo_page.dart';
import 'package:anthealth_mobile/views/health/activity/water_page.dart';
import 'package:anthealth_mobile/views/health/indicator/blood_pressure_page.dart';
import 'package:anthealth_mobile/views/health/indicator/heart_rate_page.dart';
import 'package:anthealth_mobile/views/health/indicator/height_page.dart';
import 'package:anthealth_mobile/views/health/indicator/spo2_page.dart';
import 'package:anthealth_mobile/views/health/indicator/temperature_page.dart';
import 'package:anthealth_mobile/views/health/indicator/weight_page.dart';
import 'package:anthealth_mobile/views/health/widgets/indicator_component_widget.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FamilyMemberHealth extends StatefulWidget {
  const FamilyMemberHealth(
      {Key? key, required this.dashboardContext, required this.data})
      : super(key: key);

  final BuildContext dashboardContext;
  final FamilyMemberData data;

  @override
  State<FamilyMemberHealth> createState() => _FamilyMemberHealthState();
}

class _FamilyMemberHealthState extends State<FamilyMemberHealth> {
  HealthPageData healthPageData = HealthPageData([0, 0, 0, 0, 0, 0]);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DashboardCubit>(widget.dashboardContext)
        .getHealthPageData(widget.data.id)
        .then((value) => setState(() => healthPageData = value));
  }

  @override
  Widget build(BuildContext context) {
    return TemplateAvatarFormPage(
        name: widget.data.name,
        avatarPath: widget.data.avatarPath,
        firstTitle: S.of(context).Health_record,
        content: buildContent(context));
  }

  Widget buildContent(BuildContext context) {
    bool isShowIndicator = false;
    bool isShowActivity = false;
    for (int i = 0; i < 6; i++)
      if (widget.data.permission[i] > -1) isShowIndicator = true;
    for (int i = 6; i < 9; i++)
      if (widget.data.permission[i] > -1) isShowActivity = true;
    return Column(children: [
      if (isShowIndicator)
        buildHealthIndicator(
            context,
            DashboardLogic.handleIndicatorToShow(
                healthPageData.indicatorsLatestData),
            healthPageData.indicatorsLatestData[0]),
      if (isShowActivity) buildActivity(context)
    ]);
  }

  Widget buildHealthIndicator(BuildContext context,
      List<String> indicatorLatestData, double latestHeight) {
    double width = (MediaQuery.of(context).size.width - 48) / 2;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CommonText.section(S.of(context).Health_indicator, context),
      SizedBox(height: 16),
      Wrap(
          spacing: 16,
          runSpacing: 16,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            IndicatorComponent(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => HeightPage(
                          dashboardContext: context,
                          data: widget.data,
                          user: User("id", "name", "avatarPath", "phoneNumber",
                              "email", false, widget.data.yob, 0),
                        ))),
                colorID: 0,
                iconPath: "assets/indicators/height.png",
                value: indicatorLatestData[0],
                unit: "m",
                title: S.of(context).Height,
                isVisible: (widget.data.permission[0] < 0),
                width: width),
            IndicatorComponent(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => WeightPage(
                        dashboardContext: context,
                        latestHeight: latestHeight,
                        data: widget.data))),
                colorID: 1,
                iconPath: "assets/indicators/weight.png",
                value: indicatorLatestData[1],
                unit: "kg",
                title: S.of(context).Weight,
                isVisible: (widget.data.permission[1] < 0),
                width: width),
            IndicatorComponent(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => HeartRatePage(
                        dashboardContext: context, data: widget.data))),
                colorID: 2,
                iconPath: "assets/indicators/heart_rate.png",
                value: indicatorLatestData[2],
                unit: "BPM",
                title: S.of(context).Heart_rate,
                isVisible: (widget.data.permission[2] < 0),
                width: width),
            IndicatorComponent(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => TemperaturePage(
                        dashboardContext: context, data: widget.data))),
                colorID: 1,
                iconPath: "assets/indicators/temperature.png",
                value: indicatorLatestData[3],
                unit: "°C",
                title: S.of(context).Temperature,
                isVisible: (widget.data.permission[3] < 0),
                width: width),
            IndicatorComponent(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => BloodPressurePage(
                        dashboardContext: context, data: widget.data))),
                colorID: 2,
                iconPath: "assets/indicators/blood_pressure.png",
                value: indicatorLatestData[4],
                unit: (indicatorLatestData[4].length > 6) ? "" : "mmHg",
                title: S.of(context).Blood_pressure,
                isVisible: (widget.data.permission[4] < 0),
                width: width),
            IndicatorComponent(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => SPO2Page(
                        dashboardContext: context, data: widget.data))),
                colorID: 0,
                iconPath: "assets/indicators/spo2.png",
                value: indicatorLatestData[5],
                unit: "%",
                title: S.of(context).Spo2,
                isVisible: (widget.data.permission[5] < 0),
                width: width)
          ]),
      SizedBox(height: 32),
      CustomDivider.common(),
      SizedBox(height: 16)
    ]);
  }

  Widget buildActivity(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 48) / 2;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CommonText.section(S.of(context).Activity, context),
      SizedBox(height: 16),
      Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IndicatorComponent(
                colorID: 2,
                iconPath: "assets/indicators/calo.png",
                value: "1.200",
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CaloPage(data: widget.data))),
                title: S.of(context).Calo,
                isVisible: (widget.data.permission[6] < 0),
                width: width),
            SizedBox(width: 16),
            IndicatorComponent(
                colorID: 0,
                iconPath: "assets/indicators/water.png",
                value: "1.200",
                unit: "ml",
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => WaterPage(data: widget.data))),
                title: S.of(context).Drink_water,
                isVisible: (widget.data.permission[7] < 0),
                width: width),
          ]),
      SizedBox(height: 32),
      CustomDivider.common(),
      SizedBox(height: 16)
    ]);
  }
}
