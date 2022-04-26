import 'dart:math';

import 'package:anthealth_mobile/blocs/health/steps_cubit.dart';
import 'package:anthealth_mobile/blocs/health/water_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/dateTime_logic.dart';
import 'package:anthealth_mobile/logics/number_logic.dart';
import 'package:anthealth_mobile/models/health/steps_models.dart';
import 'package:anthealth_mobile/models/health/water_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/next_previous_bar.dart';
import 'package:anthealth_mobile/views/common_widgets/switch_bar.dart';
import 'package:anthealth_mobile/views/health/activity/widgets/activity_date_detail.dart';
import 'package:anthealth_mobile/views/health/activity/widgets/activity_month_chart.dart';
import 'package:anthealth_mobile/views/health/activity/widgets/activity_year_chart.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WaterDetailPage extends StatefulWidget {
  const WaterDetailPage({Key? key, required this.superContext})
      : super(key: key);

  final BuildContext superContext;

  @override
  State<WaterDetailPage> createState() => _WaterDetailPageState();
}

class _WaterDetailPageState extends State<WaterDetailPage> {
  int switchIndex = 0;
  DateTime dateTimePicker = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: S.of(context).Detail,
        back: () => back(context),
        content: buildContent(context));
  }

  // Content
  Widget buildContent(BuildContext context) {
    return Column(children: [
      SizedBox(height: 8),
      SwitchBar(
          content: [S.of(context).Day, S.of(context).Month, S.of(context).Year],
          index: switchIndex,
          onIndexChange: (value) {
            setState(() {
              switchIndex = value;
              dateTimePicker = DateTime.now();
            });
          },
          colorID: 3),
      SizedBox(height: 24),
      buildNextPreviousBar(),
      SizedBox(height: 24),
      if (switchIndex == 0) buildDayDetails(),
      if (switchIndex == 1) buildMonthDetails(),
      if (switchIndex == 2) buildYearDetails()
    ]);
  }

  // Content Component
  NextPreviousBar buildNextPreviousBar() {
    String content = "";
    if (switchIndex == 0)
      content =
          DateTimeLogic.todayFormat(context, dateTimePicker, "dd.MM.yyyy");
    if (switchIndex == 1)
      content = DateTimeLogic.formatMonthYear(context, dateTimePicker);
    if (switchIndex == 2) content = dateTimePicker.year.toString();
    return NextPreviousBar(
        content: content,
        increase: () {
          setState(() {
            if (switchIndex ==
                0) if (DateTimeLogic.compareDayWithNow(dateTimePicker))
              dateTimePicker = DateTimeLogic.increaseDay(dateTimePicker);
            if (switchIndex ==
                1) if (DateTimeLogic.compareMonthWithNow(dateTimePicker))
              dateTimePicker = DateTimeLogic.increaseMonth(dateTimePicker);
            if (switchIndex == 2) if (dateTimePicker.year < DateTime.now().year)
              dateTimePicker = DateTimeLogic.increaseYear(dateTimePicker);
          });
        },
        decrease: () {
          setState(() {
            if (switchIndex == 0)
              dateTimePicker = DateTimeLogic.decreaseDay(dateTimePicker);
            if (switchIndex == 1)
              dateTimePicker = DateTimeLogic.decreaseMonth(dateTimePicker);
            if (switchIndex == 2)
              dateTimePicker = DateTimeLogic.decreaseYear(dateTimePicker);
          });
        });
  }

  Widget buildDayDetails() {
    WaterDayData data = BlocProvider.of<WaterCubit>(widget.superContext)
        .getDayData(dateTimePicker);
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: AnthealthColors.black5,
            borderRadius: BorderRadius.circular(16)),
        child: Column(children: [
          Row(children: [
            Text(S.of(context).Goal + ": ",
                style: Theme.of(context).textTheme.subtitle2),
            Text(NumberLogic.formatIntMore3(data.getGoal()) + " ml",
                style: Theme.of(context).textTheme.bodyText1)
          ]),
          SizedBox(height: 12),
          Row(children: [
            Text(S.of(context).Drank + ": ",
                style: Theme.of(context).textTheme.subtitle2),
            Text(NumberLogic.formatIntMore3(data.getWaterValue()) + " ml",
                style: Theme.of(context).textTheme.bodyText1)
          ]),
          SizedBox(height: 12),
          ActivityDateDetail(
              type: 1, unit: "ml", data: data.getWater())
        ]));
  }

  Widget buildMonthDetails() {
    WaterMonthReport data = BlocProvider.of<WaterCubit>(widget.superContext)
        .getMonthData(dateTimePicker);
    return Container(
        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
        decoration: BoxDecoration(
            color: AnthealthColors.black5,
            borderRadius: BorderRadius.circular(16)),
        child: Column(children: [
          Row(children: [
            Text(S.of(context).Goal_days + ": ",
                style: Theme.of(context).textTheme.subtitle2),
            Text(
                data.getGoalDay().toString() +
                    " " +
                    S.of(context).days +
                    " / " +
                    data.getDay().toString() +
                    " " +
                    S.of(context).days,
                style: Theme.of(context).textTheme.bodyText1)
          ]),
          SizedBox(height: 16),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                  padding: EdgeInsets.only(top: 8),
                  width: max(MediaQuery.of(context).size.width - 64,
                      data.getData().length * 32),
                  child: ActivityMonthChart(dataWater: data.getData()))),
          Row(children: [
            Container(height: 16, width: 16, color: AnthealthColors.black3),
            SizedBox(width: 8),
            Text(S.of(context).Goal,
                style: Theme.of(context).textTheme.bodyText1),
            SizedBox(width: 16),
            Container(height: 16, width: 16, color: AnthealthColors.primary2),
            SizedBox(width: 8),
            Text(S.of(context).Water_count,
                style: Theme.of(context).textTheme.bodyText1)
          ])
        ]));
  }

  Widget buildYearDetails() {
    WaterYearReport data = BlocProvider.of<WaterCubit>(widget.superContext)
        .getYearData(dateTimePicker);
    return Container(
        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
        decoration: BoxDecoration(
            color: AnthealthColors.black5,
            borderRadius: BorderRadius.circular(16)),
        child: Column(children: [
          Row(children: [
            Text(S.of(context).Average_per_day + ": ",
                style: Theme.of(context).textTheme.subtitle2),
            Text(
                NumberLogic.formatIntMore3(data.getAVGDay()) +
                    " ml",
                style: Theme.of(context).textTheme.bodyText1)
          ]),
          SizedBox(height: 12),
          Row(children: [
            Text(S.of(context).Goal_days + ": ",
                style: Theme.of(context).textTheme.subtitle2),
            Text(
                data.getTotalGoalDay().toString() +
                    " " +
                    S.of(context).days +
                    " / " +
                    data.getTotalDay().toString() +
                    " " +
                    S.of(context).days,
                style: Theme.of(context).textTheme.bodyText1)
          ]),
          SizedBox(height: 24),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                  padding: EdgeInsets.only(top: 8),
                  width: max(MediaQuery.of(context).size.width - 64,
                      data.getData().length * 42),
                  child: ActivityYearChart(dataWater: data.getData()))),
          Row(children: [
            Container(height: 16, width: 16, color: AnthealthColors.primary2),
            SizedBox(width: 8),
            Text(S.of(context).Average_water_per_day,
                style: Theme.of(context).textTheme.bodyText1)
          ])
        ]));
  }

  // Actions
  void back(BuildContext context) {
    Navigator.of(context).pop();
  }
}
