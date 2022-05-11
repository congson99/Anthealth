import 'dart:math';

import 'package:anthealth_mobile/blocs/health/calo_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/dateTime_logic.dart';
import 'package:anthealth_mobile/logics/number_logic.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/models/health/calo_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_avatar_form_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/next_previous_bar.dart';
import 'package:anthealth_mobile/views/common_widgets/switch_bar.dart';
import 'package:anthealth_mobile/views/health/activity/widgets/calo_chart.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaloDetailPage extends StatefulWidget {
  const CaloDetailPage({Key? key, required this.superContext, this.data})
      : super(key: key);

  final BuildContext superContext;
  final FamilyMemberData? data;

  @override
  State<CaloDetailPage> createState() => _CaloDetailPageState();
}

class _CaloDetailPageState extends State<CaloDetailPage> {
  int switchIndex = 0;
  DateTime dateTimePicker = DateTime.now();

  @override
  Widget build(BuildContext context) {
    if (widget.data == null)
      return TemplateFormPage(
          title: S.of(context).Detail,
          back: () => back(context),
          content: buildContent(context));
    else
      return TemplateAvatarFormPage(
          firstTitle: S.of(context).Calo_detail,
          name: widget.data!.name,
          avatarPath: widget.data!.avatarPath,
          content: buildContent(context));
  }

  // Content
  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8),
        SwitchBar(
            content: [
              S.of(context).Day,
              S.of(context).Month,
              S.of(context).Year
            ],
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
      ],
    );
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
    double size = (MediaQuery.of(context).size.width - 88) / 4;
    CaloDayData data = BlocProvider.of<CaloCubit>(widget.superContext)
        .getDayData(dateTimePicker);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildCalculator(size, data),
        SizedBox(height: 32),
        buildCaloIn(data),
        SizedBox(height: 32),
        buildCaloOut(data)
      ],
    );
  }

  Widget buildMonthDetails() {
    List<CaloDayReportData> data =
        BlocProvider.of<CaloCubit>(widget.superContext)
            .getMonthReport(dateTimePicker);
    return Container(
        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
        decoration: BoxDecoration(
            color: AnthealthColors.black5,
            borderRadius: BorderRadius.circular(16)),
        child: Column(children: [
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                  padding: EdgeInsets.only(top: 8),
                  width: max(
                      MediaQuery.of(context).size.width - 64, data.length * 64),
                  child: CaloChart(monthData: data))),
          Row(children: [
            Container(height: 16, width: 16, color: AnthealthColors.secondary2),
            SizedBox(width: 8),
            Text(S.of(context).Calo_in + " (" + S.of(context).Food + ")",
                style: Theme.of(context).textTheme.bodyText1)
          ]),
          SizedBox(height: 8),
          Row(children: [
            Container(height: 16, width: 16, color: AnthealthColors.black3),
            SizedBox(width: 8),
            Text(S.of(context).Goal,
                style: Theme.of(context).textTheme.bodyText1)
          ]),
          SizedBox(height: 8),
          Row(children: [
            Container(height: 16, width: 16, color: AnthealthColors.primary2),
            SizedBox(width: 8),
            Text(S.of(context).Calo_out + " (" + S.of(context).Exercise + ")",
                style: Theme.of(context).textTheme.bodyText1)
          ]),
          SizedBox(height: 8)
        ]));
  }

  Widget buildYearDetails() {
    List<CaloMonthReportData> data =
        BlocProvider.of<CaloCubit>(widget.superContext)
            .getYearReport(dateTimePicker);
    return Container(
        padding: const EdgeInsets.only(left: 16, bottom: 24),
        decoration: BoxDecoration(
            color: AnthealthColors.black5,
            borderRadius: BorderRadius.circular(16)),
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  padding: EdgeInsets.only(top: 16),
                  width: max(
                      MediaQuery.of(context).size.width - 64, data.length * 64),
                  child: CaloChart(yearData: data)),
              Row(children: [
                Container(
                    height: 16, width: 16, color: AnthealthColors.secondary2),
                SizedBox(width: 8),
                Text(
                    S.of(context).Average_calo_in_per_day +
                        " (" +
                        S.of(context).Food +
                        ")",
                    style: Theme.of(context).textTheme.bodyText1)
              ]),
              SizedBox(height: 8),
              Row(children: [
                Container(
                    height: 16, width: 16, color: AnthealthColors.primary2),
                SizedBox(width: 8),
                Text(
                    S.of(context).Average_calo_out_per_day +
                        " (" +
                        S.of(context).Exercise +
                        ")",
                    style: Theme.of(context).textTheme.bodyText1)
              ])
            ])));
  }

  // Child Component
  Row buildCalculator(double size, CaloDayData data) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: size,
              child: Column(children: [
                Text(NumberLogic.formatIntMore3(data.getGoal()),
                    style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: 4),
                Text(S.of(context).Goal,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2)
              ])),
          Text("-", style: Theme.of(context).textTheme.subtitle1),
          SizedBox(
              width: size,
              child: Column(children: [
                Text(NumberLogic.formatIntMore3(data.getCaloIn()),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: AnthealthColors.secondary1)),
                SizedBox(height: 4),
                Text(S.of(context).In,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2),
                SizedBox(height: 4),
                Text("(" + S.of(context).Food + ")",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 12))
              ])),
          Text("+", style: Theme.of(context).textTheme.subtitle1),
          SizedBox(
              width: size,
              child: Column(children: [
                Text(NumberLogic.formatIntMore3(data.getCaloOut()),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: AnthealthColors.primary1)),
                SizedBox(height: 4),
                Text(S.of(context).Out,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2),
                SizedBox(height: 4),
                Text("(" + S.of(context).Exercise + ")",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 12))
              ])),
          Text("=", style: Theme.of(context).textTheme.subtitle1),
          SizedBox(
              width: size,
              child: Column(children: [
                Text(
                    NumberLogic.formatIntMore3(
                        data.getGoal() - data.getCaloIn() + data.getCaloOut()),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: AnthealthColors.warning1)),
                SizedBox(height: 4),
                Text(S.of(context).Remaining,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2)
              ]))
        ]);
  }

  Container buildCaloIn(CaloDayData data) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
            color: AnthealthColors.secondary5,
            borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(S.of(context).Calo_in + " (" + S.of(context).Food + ")",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: AnthealthColors.secondary0)),
          SizedBox(height: 12),
          Container(
              height: 36,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).Food,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: AnthealthColors.secondary0)),
                    Text(S.of(context).Total_calories,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: AnthealthColors.secondary0))
                  ])),
          Divider(thickness: 1, height: 1, color: AnthealthColors.secondary0),
          ...data.getListCaloIn().map((food) => Column(children: [
                Container(
                    height: 36,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(food.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(color: AnthealthColors.secondary0)),
                          Text(food.getCalo().toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(color: AnthealthColors.secondary0))
                        ])),
                Divider(
                    thickness: 0.5,
                    height: 0.5,
                    color: AnthealthColors.secondary0),
                Container(
                    height: 36,
                    alignment: Alignment.centerLeft,
                    child: Text(
                        NumberLogic.handleDoubleFix0(food.serving) +
                            " x " +
                            ((food.servingName == "")
                                ? S.of(context).serving
                                : food.servingName) +
                            " | " +
                            food.servingCalo.toString() +
                            " " +
                            S.of(context).calo +
                            "/" +
                            ((food.servingName == "")
                                ? S.of(context).serving
                                : food.servingName),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: AnthealthColors.secondary0))),
                Divider(
                    thickness: 1, height: 1, color: AnthealthColors.secondary0)
              ]))
        ]));
  }

  Container buildCaloOut(CaloDayData data) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
            color: AnthealthColors.primary5,
            borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(S.of(context).Calo_out + " (" + S.of(context).Exercise + ")",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: AnthealthColors.primary0)),
          SizedBox(height: 12),
          Container(
              height: 36,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).Exercise,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: AnthealthColors.primary0)),
                    Text(S.of(context).Total_calories,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: AnthealthColors.primary0))
                  ])),
          Divider(thickness: 1, height: 1, color: AnthealthColors.primary0),
          ...data.getListCaloOut().map((exercise) => Column(children: [
                Container(
                    height: 36,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(exercise.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(color: AnthealthColors.primary0)),
                          Text(exercise.getCalo().toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(color: AnthealthColors.primary0))
                        ])),
                Divider(
                    thickness: 0.5,
                    height: 0.5,
                    color: AnthealthColors.primary0),
                Container(
                    height: 36,
                    alignment: Alignment.centerLeft,
                    child: Text(
                        NumberLogic.handleMinTimeToPrint(exercise.min) +
                            " | " +
                            exercise.unitCalo.toString() +
                            " calo/" +
                            S.of(context).min,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: AnthealthColors.primary0))),
                Divider(
                    thickness: 1, height: 1, color: AnthealthColors.primary0)
              ]))
        ]));
  }

  // Actions
  void back(BuildContext context) {
    Navigator.of(context).pop();
  }
}
