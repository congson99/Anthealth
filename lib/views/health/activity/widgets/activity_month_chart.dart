import 'package:anthealth_mobile/models/health/steps_models.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ActivityMonthChart extends StatelessWidget {
  const ActivityMonthChart({Key? key, required this.data}) : super(key: key);

  final List<StepsDayReportData> data;

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
                return value.toInt().toString();
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
    for (StepsDayReportData x in data)
      result.add(BarChartGroupData(x: data.indexOf(x) + 1, barRods: [
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
    return result;
  }

  double maxY() {
    double result = 0;
    for (StepsDayReportData x in data) {
      if (x.getSteps() > result) result = x.getSteps().toDouble();
      if (x.getGoal() > result) result = x.getGoal().toDouble();
    }
    return result * 1.1;
  }
}
