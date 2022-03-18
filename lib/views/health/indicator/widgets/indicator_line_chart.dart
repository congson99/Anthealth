import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class IndicatorLineChart extends StatelessWidget {
  const IndicatorLineChart(
      {Key? key,
      required this.indicatorIndex,
      required this.filterIndex,
      required this.data})
      : super(key: key);

  final int indicatorIndex;
  final int filterIndex;
  final List<FlSpot> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: AspectRatio(aspectRatio: 1.2, child: LineChart(mainData(context))),
    );
  }

  LineChartData mainData(BuildContext context) {
    return LineChartData(
        gridData: FlGridData(drawVerticalLine: false),
        titlesData: FlTitlesData(
            rightTitles: SideTitles(showTitles: false),
            topTitles: SideTitles(showTitles: false),
            bottomTitles: SideTitles(
                showTitles: true,
                interval: (data.last.x - data.first.x + 2) ~/ 5 + 2,
                reservedSize: 32,
                margin: 8,
                getTextStyles: (context, value) => Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: AnthealthColors.black1),
                getTitles: (value) {
                  switch (indicatorIndex) {
                    case 0:
                      return (filterIndex == 1)
                          ? value.toInt().toString()
                          : intToMonth(value.toInt(), context);
                    case 1:
                      return (filterIndex == 1)
                          ? intToMonth(value.toInt(), context)
                          : value.toInt().toString();
                  }
                  return (filterIndex == 0)
                      ? ((value.toInt() ~/ 60).toString() +
                          ':' +
                          ((value % 60 < 10) ? '0' : '') +
                          (value % 60).toStringAsFixed(0))
                      : (filterIndex == 1)
                          ? (value.toInt().toString() + ':00')
                          : value.toInt().toString();
                }),
            leftTitles: SideTitles(
                showTitles: true,
                interval: intervalLeft(data),
                reservedSize: 32,
                margin: 8,
                getTextStyles: (context, value) => Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: AnthealthColors.black1),
                getTitles: (value) {
                  switch (indicatorIndex) {
                    case 0:
                      return (value ~/ 100).toInt().toString() +
                          '.' +
                          (value % 100).toInt().toString();
                    case 3:
                      return value.toStringAsFixed(1);
                  }
                  return value.toStringAsFixed(0);
                })),
        borderData: FlBorderData(
            show: true,
            border: Border(
                bottom: BorderSide(width: 1, color: AnthealthColors.black1))),
        minX: data.first.x - 1,
        maxX: data.last.x + 1,
        minY: minLeft(data) - 10,
        maxY: (indicatorIndex == 5) ? 100 : maxLeft(data) + 10,
        lineBarsData: [
          LineChartBarData(
              spots: data,
              isCurved: false,
              colors: [AnthealthColors.secondary2],
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
              ),
              belowBarData: BarAreaData(
                  show: true,
                  gradientFrom: Offset(0, 0),
                  gradientTo: Offset(0, 1),
                  colors: [
                    AnthealthColors.secondary1.withOpacity(0.3),
                    AnthealthColors.secondary2.withOpacity(0.3),
                    Colors.white.withOpacity(0.3)
                  ]))
        ]);
  }

  double intervalLeft(List<FlSpot> data) {
    double max = data.last.y;
    double min = data.first.y;
    for (FlSpot i in data) {
      if (i.y > max) max = i.y;
      if (i.y < min) min = i.y;
    }
    return ((max - min + 20) ~/ 20) * 5;
  }

  double maxLeft(List<FlSpot> data) {
    double max = data.last.y;
    for (FlSpot i in data) {
      if (i.y > max) max = i.y;
    }
    return max;
  }

  double minLeft(List<FlSpot> data) {
    double min = data.first.y;
    for (FlSpot i in data) {
      if (i.y < min) min = i.y;
    }
    return min;
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
