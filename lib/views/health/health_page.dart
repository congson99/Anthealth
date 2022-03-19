import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/dashboard/dashboard_models.dart';
import 'package:anthealth_mobile/views/common_pages/error_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/header.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/health/indicator/blood_pressure_page.dart';
import 'package:anthealth_mobile/views/health/indicator/heart_rate_page.dart';
import 'package:anthealth_mobile/views/health/indicator/height_page.dart';
import 'package:anthealth_mobile/views/health/indicator/spo2_page.dart';
import 'package:anthealth_mobile/views/health/indicator/temperature_page.dart';
import 'package:anthealth_mobile/views/health/indicator/weight_page.dart';
import 'package:anthealth_mobile/views/health/indicator_component_widget.dart';
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
          return Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                  child: Stack(children: [
                Container(
                    margin: const EdgeInsets.only(
                        left: 16, right: 16, top: 90, bottom: 130),
                    child: buildContent(context, state.healthPageData)),
                Header(
                    title: S.of(context).Health_record,
                    content: name,
                    isNotification: false,
                    isMessage: false,
                    onSettingsTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => SettingsPage(appContext: context))))
              ])));
        return ErrorPage();
      });

  Column buildContent(BuildContext context, HealthPageData data) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomDivider.common(),
          SizedBox(height: 16),
          CommonText.section(S.of(context).Health_indicator, context),
          SizedBox(height: 16),
          buildHealthIndicator(
              context,
              HealthPageData.handleIndicatorToShow(
                  data.getIndicatorsLatestData()),
              data.getIndicatorsLatestData()[0]),
          SizedBox(height: 32),
          CustomDivider.common(),
          SizedBox(height: 16),
          CommonText.section(S.of(context).Activity, context),
          SizedBox(height: 16),
          buildActivity(context),
          SizedBox(height: 32),
          CustomDivider.common(),
          SizedBox(height: 16),
          CommonText.section(S.of(context).Period, context),
          SizedBox(height: 16),
          buildPeriod(context),
        ]);
  }

  Widget buildHealthIndicator(BuildContext context,
          List<String> indicatorLatestData, double latestHeight) =>
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IndicatorComponent(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              HeightPage(dashboardContext: context))),
                      colorID: 0,
                      iconPath: "assets/indicators/height.png",
                      value: indicatorLatestData[0],
                      unit: "m",
                      title: S.of(context).Height),
                  SizedBox(width: 16),
                  IndicatorComponent(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => WeightPage(
                              dashboardContext: context,
                              latestHeight: latestHeight))),
                      colorID: 1,
                      iconPath: "assets/indicators/weight.png",
                      value: indicatorLatestData[1],
                      unit: "kg",
                      title: S.of(context).Weight),
                  SizedBox(width: 16),
                  IndicatorComponent(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              HeartRatePage(dashboardContext: context))),
                      colorID: 2,
                      iconPath: "assets/indicators/heart_rate.png",
                      value: indicatorLatestData[2],
                      unit: "BPM",
                      title: S.of(context).Heart_rate)
                ]),
            SizedBox(height: 16),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IndicatorComponent(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              TemperaturePage(dashboardContext: context))),
                      colorID: 1,
                      iconPath: "assets/indicators/temperature.png",
                      value: indicatorLatestData[3],
                      unit: "°C",
                      title: S.of(context).Temperature),
                  SizedBox(width: 16),
                  IndicatorComponent(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              BloodPressurePage(dashboardContext: context))),
                      colorID: 2,
                      iconPath: "assets/indicators/blood_pressure.png",
                      value: indicatorLatestData[4],
                      unit: (indicatorLatestData[4].length > 6) ? "" : "mmHg",
                      title: S.of(context).Blood_pressure),
                  SizedBox(width: 16),
                  IndicatorComponent(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => SPO2Page(dashboardContext: context))),
                      colorID: 0,
                      iconPath: "assets/indicators/spo2.png",
                      value: indicatorLatestData[5],
                      unit: "%",
                      title: S.of(context).Spo2)
                ])
          ]);

  Widget buildActivity(BuildContext context) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IndicatorComponent(
                colorID: 2,
                iconPath: "assets/indicators/calo.png",
                value: "1.200",
                title: S.of(context).Calo),
            SizedBox(width: 16),
            IndicatorComponent(
                colorID: 0,
                iconPath: "assets/indicators/water.png",
                value: "1.200",
                unit: "ml",
                title: S.of(context).Water),
            SizedBox(width: 16),
            IndicatorComponent(
                colorID: 1,
                iconPath: "assets/indicators/steps.png",
                value: "4.600",
                title: S.of(context).Steps)
          ]);

  Widget buildPeriod(BuildContext context) => SectionComponent(
      title: "Hành kinh trong 1 ngày nữa",
      subTitle: "Cơ hội thụ thai thấp",
      colorID: 2,
      isWarning: true);
}
