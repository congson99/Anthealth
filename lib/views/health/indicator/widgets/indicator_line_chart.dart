import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
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
                interval: indicatorIndex == 0
                    ? filterIndex == 0
                        ? ((data.last.x - data.first.x + 2) ~/ 6 + 1)
                        : ((data.last.x - data.first.x + 2) ~/ 5 + 1)
                    : 2,
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
                      return '';
                    case 2:
                      return '';
                    case 3:
                      return '';
                    case 4:
                      return '';
                    case 5:
                      return '';
                  }
                  return value.toString();
                }),
            leftTitles: SideTitles(
                showTitles: true,
                interval: indicatorIndex == 0
                    ? ((data.last.y - data.first.y + 40) ~/ 20) * 5 + 5
                    : 2,
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
                    case 1:
                      return '';
                    case 2:
                      return '';
                    case 3:
                      return '';
                    case 4:
                      return '';
                    case 5:
                      return '';
                  }
                  return value.toString();
                })),
        borderData: FlBorderData(
            show: true,
            border: Border(
                bottom: BorderSide(width: 1, color: AnthealthColors.black1))),
        minX: data.first.x - 1,
        maxX: data.last.x + 1,
        minY: (data.first.y - 20) ~/ 5 * 5,
        maxY: data.last.y + 20,
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
