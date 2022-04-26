import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/health/steps_models.dart';
import 'package:anthealth_mobile/models/health/water_models.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ActivityYearChart extends StatelessWidget {
  const ActivityYearChart({Key? key, this.dataStep, this.dataWater})
      : super(key: key);

  final List<StepsMonthReportData>? dataStep;
  final List<WaterMonthReportData>? dataWater;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: AspectRatio(aspectRatio: 1.2, child: BarChart(mainData(context))),
    );
  }

  BarChartData mainData(BuildContext context) {
    return BarChartData(
      gridData: FlGridData(drawVerticalLine: false),
      titlesData: FlTitlesData(
          rightTitles: SideTitles(showTitles: false),
          topTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 32,
              margin: 8,
              getTextStyles: (context, value) => Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: AnthealthColors.black1),
              getTitles: (value) {
                return intToMonth(value.toInt(), context);
              }),
          leftTitles: SideTitles(
              showTitles: true,
              interval: (maxY() > 2500) ? ((maxY() / 5) ~/ 500) * 500.0 : 200,
              reservedSize: 42,
              margin: 8,
              textAlign: TextAlign.start,
              getTextStyles: (context, value) => Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: AnthealthColors.black1),
              getTitles: (value) {
                return value.toStringAsFixed(0);
              })),
      maxY: maxY(),
      borderData: FlBorderData(
          show: true,
          border: Border(
              bottom: BorderSide(width: 1, color: AnthealthColors.black1))),
      barGroups: getData(),
    );
  }

  List<BarChartGroupData> getData() {
    List<BarChartGroupData> result = [];
    if (dataStep != null)
      for (StepsMonthReportData x in dataStep!)
        result.add(BarChartGroupData(x: dataStep!.indexOf(x) + 1, barRods: [
          BarChartRodData(
              y: x.getSteps().toDouble(),
              rodStackItems: [
                BarChartRodStackItem(
                    0, x.getSteps().toDouble(), AnthealthColors.primary2),
              ],
              width: 16,
              backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  y: x.getGoal().toDouble(),
                  colors: [AnthealthColors.black3]),
              borderRadius: const BorderRadius.all(Radius.zero))
        ]));
    if (dataWater != null)
      for (WaterMonthReportData x in dataWater!)
        result.add(BarChartGroupData(x: dataWater!.indexOf(x) + 1, barRods: [
          BarChartRodData(
              y: x.getDrink().toDouble(),
              rodStackItems: [
                BarChartRodStackItem(
                    0, x.getDrink().toDouble(), AnthealthColors.primary2),
              ],
              width: 16,
              backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  y: x.getGoal().toDouble(),
                  colors: [AnthealthColors.black3]),
              borderRadius: const BorderRadius.all(Radius.zero))
        ]));
    return result;
  }

  double maxY() {
    double result = 0;
    if (dataStep != null)
      for (StepsMonthReportData x in dataStep!) {
        if (x.getSteps() > result) result = x.getSteps().toDouble();
        if (x.getGoal() > result) result = x.getGoal().toDouble();
      }
    if (dataWater != null)
      for (WaterMonthReportData x in dataWater!) {
        if (x.getDrink() > result) result = x.getDrink().toDouble();
        if (x.getGoal() > result) result = x.getGoal().toDouble();
      }
    return result * 1.1;
  }

  String intToMonth(int value, BuildContext context) {
    switch (value) {
      case 1:
        return S.of(context).jan;
      case 2:
        return S.of(context).feb;
      case 3:
        return S.of(context).mar;
      case 4:
        return S.of(context).apr;
      case 5:
        return S.of(context).may;
      case 6:
        return S.of(context).jun;
      case 7:
        return S.of(context).jul;
      case 8:
        return S.of(context).aug;
      case 9:
        return S.of(context).sep;
      case 10:
        return S.of(context).oct;
      case 11:
        return S.of(context).nov;
      case 12:
        return S.of(context).dec;
    }
    return '';
  }
}
