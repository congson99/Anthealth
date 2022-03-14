import 'package:anthealth_mobile/blocs/app_cubit.dart';
import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/dashboard/dashboard_models.dart';
import 'package:anthealth_mobile/views/common_pages/error_page.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
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

class HealthPage extends StatelessWidget {
  const HealthPage({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, CubitState>(builder: (context, state) {
      if (state is HealthState)
        return Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: Stack(children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 90),
                child: buildContent(context, state.healthPageData),
              ),
              Header(
                  title: S.of(context).Health_record,
                  content: name,
                  isNotification: false,
                  isMessage: false,
                  onSettingsTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => SettingsPage(appContext: context))))
            ])));
      else
        return ErrorPage();
    });
  }

  Column buildContent(BuildContext context, HealthPageData data) {
    return Column(children: [
      Divider(height: 0.5, color: AnthealthColors.black3),
      SizedBox(height: 16),
      buildHealthIndicator(context, data.getIndicatorsLatestData()),
      SizedBox(height: 32),
      Divider(height: 0.5, color: AnthealthColors.black3),
      SizedBox(height: 16),
      buildActivity(context),
      SizedBox(height: 32),
      Divider(height: 0.5, color: AnthealthColors.black3),
      SizedBox(height: 16),
      buildPeriod(context),
      SizedBox(height: 32)
    ]);
  }

  Container buildHealthIndicator(
      BuildContext context, List<double> indicatorLatestData) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          CommonText.section(S.of(context).Health_indicator, context),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IndicatorComponent(
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => HeightPage())),
                  colorID: 0,
                  iconPath: "assets/indicators/height.png",
                  value: (indicatorLatestData[0] != 0)
                      ? indicatorLatestData[0].toString()
                      : '_',
                  unit: "m",
                  title: S.of(context).Height),
              SizedBox(width: 16),
              IndicatorComponent(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => IndicatorPage(
                          indicatorIndex: 1,
                          title: S.of(context).Weight,
                          unit: "kg"))),
                  colorID: 1,
                  iconPath: "assets/indicators/weight.png",
                  value: (indicatorLatestData[1] != 0)
                      ? indicatorLatestData[1].toString()
                      : '_',
                  unit: "kg",
                  title: S.of(context).Weight),
              SizedBox(width: 16),
              IndicatorComponent(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => IndicatorPage(
                          indicatorIndex: 2,
                          title: S.of(context).Heart_rate,
                          unit: "BPM"))),
                  colorID: 2,
                  iconPath: "assets/indicators/heart_rate.png",
                  value: (indicatorLatestData[2] != 0)
                      ? indicatorLatestData[2].toStringAsFixed(0)
                      : '_',
                  unit: "BPM",
                  title: S.of(context).Heart_rate),
            ],
          ),
          SizedBox(height: 16),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IndicatorComponent(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => IndicatorPage(
                            indicatorIndex: 3,
                            title: S.of(context).Temperature,
                            unit: "°C"))),
                    colorID: 1,
                    iconPath: "assets/indicators/temperature.png",
                    value: (indicatorLatestData[3] != 0)
                        ? indicatorLatestData[3].toString()
                        : '_',
                    unit: "°C",
                    title: S.of(context).Temperature),
                SizedBox(width: 16),
                IndicatorComponent(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => IndicatorPage(
                            indicatorIndex: 4,
                            title: S.of(context).Blood_pressure,
                            unit: "mmHg"))),
                    colorID: 2,
                    iconPath: "assets/indicators/blood_pressure.png",
                    value: ((indicatorLatestData[4] != 0)
                            ? indicatorLatestData[4].toStringAsFixed(0)
                            : '_') +
                        '/' +
                        ((indicatorLatestData[6] != 0)
                            ? indicatorLatestData[6].toStringAsFixed(0)
                            : '_'),
                    unit: "mmHg",
                    title: S.of(context).Blood_pressure),
                SizedBox(width: 16),
                IndicatorComponent(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => IndicatorPage(
                            indicatorIndex: 5,
                            title: S.of(context).Spo2,
                            unit: "%"))),
                    colorID: 0,
                    iconPath: "assets/indicators/spo2.png",
                    value: (indicatorLatestData[5] != 0)
                        ? indicatorLatestData[5].toStringAsFixed(0)
                        : '_',
                    unit: "%",
                    title: S.of(context).Spo2)
              ])
        ]));
  }

  Container buildActivity(BuildContext context) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          CommonText.section(S.of(context).Activity, context),
          SizedBox(height: 16),
          Row(
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
              ])
        ]));
  }

  Container buildPeriod(BuildContext context) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          CommonText.section(S.of(context).Period, context),
          SizedBox(height: 16),
          SectionComponent(
              title: "Hành kinh trong 1 ngày nữa",
              subTitle: "Cơ hội thụ thai thấp",
              colorID: 2,
              isWarning: true)
        ]));
  }
}

class IndicatorComponent extends StatelessWidget {
  const IndicatorComponent({
    Key? key,
    required this.colorID,
    required this.iconPath,
    this.value,
    this.unit,
    required this.title,
    this.isWarning,
    this.onTap,
  }) : super(key: key);

  final int colorID;
  final String iconPath;
  final String? value;
  final String? unit;
  final String title;
  final bool? isWarning;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(children: [
      GestureDetector(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
                color: colorID == 0
                    ? AnthealthColors.primary5
                    : colorID == 1
                        ? AnthealthColors.secondary5
                        : AnthealthColors.warning5,
                borderRadius: BorderRadius.circular(8),
                boxShadow: isWarning == true
                    ? [
                        BoxShadow(
                            color: AnthealthColors.warning1, spreadRadius: 5)
                      ]
                    : []),
            margin: isWarning == true
                ? EdgeInsets.only(top: 15)
                : EdgeInsets.only(top: 0),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: Image.asset(iconPath,
                          height: 44.0, width: 44.0, fit: BoxFit.cover)),
                  SizedBox(height: 12),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RichText(
                            text: TextSpan(
                                text: value,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(color: AnthealthColors.black1),
                                children: [
                              TextSpan(
                                  text: unit, style: TextStyle(fontSize: 8)),
                            ]))
                      ]),
                  SizedBox(height: 4),
                  Text(title,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: colorID == 0
                              ? AnthealthColors.primary0
                              : colorID == 1
                                  ? AnthealthColors.secondary0
                                  : AnthealthColors.warning0))
                ])),
      ),
      isWarning == true
          ? Container(
              alignment: Alignment.center,
              child: Image.asset(
                  "assets/app_icon/common/warning_border_war2.png",
                  height: 22.0,
                  fit: BoxFit.cover))
          : Container()
    ]));
  }
}
