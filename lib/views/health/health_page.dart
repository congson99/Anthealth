import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/dashboard_logic.dart';
import 'package:anthealth_mobile/models/dashboard/dashboard_models.dart';
import 'package:anthealth_mobile/views/common_pages/error_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_dashboard_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/health/activity/calo_page.dart';
import 'package:anthealth_mobile/views/health/activity/steps_page.dart';
import 'package:anthealth_mobile/views/health/activity/water_page.dart';
import 'package:anthealth_mobile/views/health/indicator/blood_pressure_page.dart';
import 'package:anthealth_mobile/views/health/indicator/heart_rate_page.dart';
import 'package:anthealth_mobile/views/health/indicator/height_page.dart';
import 'package:anthealth_mobile/views/health/indicator/spo2_page.dart';
import 'package:anthealth_mobile/views/health/indicator/temperature_page.dart';
import 'package:anthealth_mobile/views/health/indicator/weight_page.dart';
import 'package:anthealth_mobile/views/health/widgets/indicator_component_widget.dart';
import 'package:anthealth_mobile/views/settings/setting_page.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HealthPage extends StatelessWidget {
  const HealthPage({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<DashboardCubit, CubitState>(builder: (context, state) {
        if (state is HealthState)
          return TemplateDashboardPage(
              title: S.of(context).Health_record,
              name: name,
              setting: () => setting(context),
              content: buildContent(context, state.healthPageData));
        return ErrorPage();
      });

  Column buildContent(BuildContext context, HealthPageData data) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CustomDivider.common(),
      SizedBox(height: 16),
      CommonText.section(S.of(context).Health_indicator, context),
      SizedBox(height: 16),
      buildHealthIndicator(
          context,
          DashboardLogic.handleIndicatorToShow(data.getIndicatorsLatestData()),
          data.getIndicatorsLatestData()[0]),
      SizedBox(height: 32),
      CustomDivider.common(),
      SizedBox(height: 16),
      CommonText.section(S.of(context).Activity, context),
      SizedBox(height: 16),
      buildActivity(context)
    ]);
  }

  Widget buildHealthIndicator(BuildContext context,
      List<String> indicatorLatestData, double latestHeight) {
    double width = (MediaQuery.of(context).size.width - 64) / 3;
    return Column(children: [
      Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        IndicatorComponent(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => HeightPage(dashboardContext: context))),
            colorID: 0,
            iconPath: "assets/indicators/height.png",
            value: indicatorLatestData[0],
            unit: "m",
            title: S.of(context).Height,
            width: width),
        SizedBox(width: 16),
        IndicatorComponent(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => WeightPage(
                    dashboardContext: context, latestHeight: latestHeight))),
            colorID: 1,
            iconPath: "assets/indicators/weight.png",
            value: indicatorLatestData[1],
            unit: "kg",
            title: S.of(context).Weight,
            width: width),
        SizedBox(width: 16),
        IndicatorComponent(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => HeartRatePage(dashboardContext: context))),
            colorID: 2,
            iconPath: "assets/indicators/heart_rate.png",
            value: indicatorLatestData[2],
            unit: "BPM",
            title: S.of(context).Heart_rate,
            width: width)
      ]),
      SizedBox(height: 16),
      Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        IndicatorComponent(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => TemperaturePage(dashboardContext: context))),
            colorID: 1,
            iconPath: "assets/indicators/temperature.png",
            value: indicatorLatestData[3],
            unit: "°C",
            title: S.of(context).Temperature,
            width: width),
        SizedBox(width: 16),
        IndicatorComponent(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BloodPressurePage(dashboardContext: context))),
            colorID: 2,
            iconPath: "assets/indicators/blood_pressure.png",
            value: indicatorLatestData[4],
            unit: (indicatorLatestData[4].length > 6) ? "" : "mmHg",
            title: S.of(context).Blood_pressure,
            width: width),
        SizedBox(width: 16),
        IndicatorComponent(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SPO2Page(dashboardContext: context))),
            colorID: 0,
            iconPath: "assets/indicators/spo2.png",
            value: indicatorLatestData[5],
            unit: "%",
            title: S.of(context).Spo2,
            width: width)
      ])
    ]);
  }

  Widget buildActivity(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 64) / 3;
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IndicatorComponent(
              colorID: 2,
              iconPath: "assets/indicators/calo.png",
              value: "1.200",
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => CaloPage())),
              title: S.of(context).Calo,
              width: width),
          SizedBox(width: 16),
          IndicatorComponent(
              colorID: 0,
              iconPath: "assets/indicators/water.png",
              value: "1.200",
              unit: "ml",
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => WaterPage())),
              title: S.of(context).Drink_water,
              width: width),
          SizedBox(width: 16),
          IndicatorComponent(
              colorID: 1,
              iconPath: "assets/indicators/steps.png",
              value: "4.600",
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => StepsPage())),
              title: S.of(context).Steps,
              width: width)
        ]);
  }

  // Actions
  void setting(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => SettingsPage(appContext: context)));
  }
}
