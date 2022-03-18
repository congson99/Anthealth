import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BloodPressureLineChart extends StatelessWidget {
  const BloodPressureLineChart(
      {Key? key, required this.filterIndex, required this.data})
      : super(key: key);

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
                interval: intervalLeft(data, secondData(data)),
                reservedSize: 32,
                margin: 8,
                getTextStyles: (context, value) => Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: AnthealthColors.black1),
                getTitles: (value) {
                  return value.toStringAsFixed(0);
                })),
        borderData: FlBorderData(
            show: true,
            border: Border(
                bottom: BorderSide(width: 1, color: AnthealthColors.black1))),
        minX: data.first.x - 1,
        maxX: data.last.x + 1,
        minY: minLeft(data, secondData(data)) - 20,
        maxY: maxLeft(data, secondData(data)) + 20,
        lineBarsData: [
          LineChartBarData(
              spots: data,
              isCurved: false,
              colors: [AnthealthColors.secondary2],
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,

              ),belowBarData: BarAreaData(
              show: true,
              gradientFrom: Offset(0, 0),
              gradientTo: Offset(0, 1),
              colors: [
                AnthealthColors.secondary1.withOpacity(0.3),
                AnthealthColors.secondary2.withOpacity(0.3),
                Colors.white.withOpacity(0.3)
              ])),
          LineChartBarData(
              spots: secondData(data),
              isCurved: false,
              colors: [AnthealthColors.primary2],
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
              ),belowBarData: BarAreaData(
              show: true,
              gradientFrom: Offset(0, 0),
              gradientTo: Offset(0, 1),
              colors: [
                AnthealthColors.primary1.withOpacity(0.3),
                AnthealthColors.primary2.withOpacity(0.3),
                Colors.white.withOpacity(0.3)
              ]))
        ]);
  }

  List<FlSpot> secondData(List<FlSpot> data) {
    List<FlSpot> result = [];
    for (FlSpot i in data) result.add(FlSpot(i.x, (i.y * 1000) % 1000));
    return result;
  }

  double intervalLeft(List<FlSpot> data, List<FlSpot> sData) {
    double max = data.last.y;
    double min = data.first.y;
    for (FlSpot i in data) {
      if (i.y > max) max = i.y;
      if (i.y < min) min = i.y;
    }
    for (FlSpot i in sData) {
      if (i.y > max) max = i.y;
      if (i.y < min) min = i.y;
    }
    return ((max - min + 20) ~/ 20) * 5;
  }

  double maxLeft(List<FlSpot> data, List<FlSpot> sData) {
    double max = data.last.y;
    for (FlSpot i in data) {
      if (i.y > max) max = i.y;
    }
    for (FlSpot i in sData) {
      if (i.y > max) max = i.y;
    }
    return max;
  }

  double minLeft(List<FlSpot> data, List<FlSpot> sData) {
    double min = data.first.y;
    for (FlSpot i in data) {
      if (i.y < min) min = i.y;
    }
    for (FlSpot i in sData) {
      if (i.y < min) min = i.y;
    }
    return min;
  }
}
