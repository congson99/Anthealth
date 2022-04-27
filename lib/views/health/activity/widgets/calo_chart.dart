import 'package:anthealth_mobile/models/health/calo_models.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CaloChart extends StatelessWidget {
  const CaloChart({Key? key, this.monthData, this.yearData}) : super(key: key);

  final List<CaloDayReportData>? monthData;
  final List<CaloMonthReportData>? yearData;

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
              interval: (maxY() > 500) ? 500 : 100,
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
    if (monthData != null)
      for (CaloDayReportData x in monthData!)
        result.add(BarChartGroupData(
            x: monthData!.indexOf(x) + 1,
            barsSpace: 4,
            barRods: [
              BarChartRodData(
                  y: x.caloIn.toDouble(),
                  rodStackItems: [
                    BarChartRodStackItem(
                        0, x.caloIn.toDouble(), AnthealthColors.secondary2),
                  ],
                  width: 16,
                  borderRadius: const BorderRadius.all(Radius.zero)),
              BarChartRodData(
                  y: (x.goal + x.caloOut).toDouble(),
                  rodStackItems: [
                    BarChartRodStackItem(
                        0, x.goal.toDouble(), AnthealthColors.black3),
                    BarChartRodStackItem(
                        x.goal.toDouble(),
                        (x.goal + x.caloOut).toDouble(),
                        AnthealthColors.primary2)
                  ],
                  width: 16,
                  borderRadius: const BorderRadius.all(Radius.zero))
            ]));
    if (yearData != null)
      for (CaloMonthReportData x in yearData!)
        result.add(BarChartGroupData(
            x: yearData!.indexOf(x) + 1,
            barsSpace: 4,
            barRods: [
              BarChartRodData(
                  y: x.avgCaloIn.toDouble(),
                  rodStackItems: [
                    BarChartRodStackItem(
                        0, x.avgCaloIn.toDouble(), AnthealthColors.secondary2),
                  ],
                  width: 16,
                  borderRadius: const BorderRadius.all(Radius.zero)),
              BarChartRodData(
                  y: (x.avgCaloOut).toDouble(),
                  rodStackItems: [
                    BarChartRodStackItem(
                        0, x.avgCaloOut.toDouble(), AnthealthColors.primary2),
                  ],
                  width: 16,
                  borderRadius: const BorderRadius.all(Radius.zero))
            ]));
    return result;
  }

  double maxY() {
    int result = 0;
    if (monthData != null)
      for (CaloDayReportData x in monthData!) {
        if (x.caloIn > result) result = x.caloIn;
        if (x.goal + x.caloOut > result) result = x.goal + x.caloOut;
      }
    if (yearData != null)
      for (CaloMonthReportData x in yearData!) {
        if (x.avgCaloIn > result) result = x.avgCaloIn;
        if (x.avgCaloOut > result) result = x.avgCaloOut;
      }
    return result * 1.1;
  }
}
