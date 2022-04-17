import 'package:anthealth_mobile/models/health/indicator_models.dart';
import 'package:fl_chart/fl_chart.dart';

class IndicatorLogic {
  // Convert for chart
  static List<FlSpot> convertToRecordChart10Data(List<IndicatorData> data) {
    List<IndicatorData> rData = data.reversed.toList();
    List<FlSpot> result = [];
    for (IndicatorData x in rData) {
      result.insert(
          0,
          FlSpot(
              x.getDateTime().hour.toDouble() * 60 +
                  x.getDateTime().minute.toDouble(),
              x.getValue()));
      if (result.length == 10) break;
    }
    return result.reversed.toList();
  }

  static List<FlSpot> convertToHourChartData(List<IndicatorData> data) {
    List<IndicatorData> rData = data.reversed.toList();
    List<FlSpot> result = [];
    for (IndicatorData x in rData) {
      result.insert(0, FlSpot(x.getDateTime().hour.toDouble(), x.getValue()));
      if (result.length == 10) break;
    }
    return result.reversed.toList();
  }

  static List<FlSpot> convertToDayChartData(List<IndicatorData> data) {
    List<IndicatorData> rData = data.reversed.toList();
    List<FlSpot> result = [];
    for (IndicatorData x in rData) {
      result.insert(0, FlSpot(x.getDateTime().day.toDouble(), x.getValue()));
      if (result.length == 10) break;
    }
    return result.reversed.toList();
  }

  static List<FlSpot> convertToMonthChartLatestData(List<IndicatorData> data) {
    List<double> temp = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
    for (IndicatorData x in data) {
      if (temp[x.getDateTime().month] == -1)
        temp[x.getDateTime().month] = x.getValue();
    }
    List<FlSpot> result = [];
    for (int i = 1; i <= 12; i++)
      if (temp[i] != -1)
        result.add(FlSpot(i.toDouble(), temp[i].toDouble() * 100));
    return result;
  }

  static List<FlSpot> convertToYearChartData(List<IndicatorData> data) {
    List<IndicatorData> rData = data.reversed.toList();
    List<FlSpot> result = [];
    for (IndicatorData x in rData) {
      result.insert(0, FlSpot(x.getDateTime().year.toDouble(), x.getValue()));
      if (result.length == 10) break;
    }
    return result.reversed.toList();
  }

  static List<FlSpot> convertToYearChartHeightData(List<IndicatorData> data) {
    List<IndicatorData> rData = data.reversed.toList();
    List<FlSpot> result = [];
    for (IndicatorData x in rData) {
      result.insert(
          0, FlSpot(x.getDateTime().year.toDouble(), x.getValue() * 100));
      if (result.length == 10) break;
    }
    return result.reversed.toList();
  }

  // avg
  static List<FlSpot> convertToDayChartAvgData(List<IndicatorData> data) {
    List<IndicatorData> rData = avgDay(data).reversed.toList();
    List<FlSpot> result = [];
    for (IndicatorData x in rData) {
      result.insert(0, FlSpot(x.getDateTime().day.toDouble(), x.getValue()));
      if (result.length == 10) break;
    }
    return result.reversed.toList();
  }

  static List<FlSpot> convertToMonthChartAvgData(List<IndicatorData> data) {
    List<double> temp = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
    for (IndicatorData x in data) {
      if (temp[x.getDateTime().month] == -1)
        temp[x.getDateTime().month] = x.getValue();
    }
    List<FlSpot> result = [];
    for (int i = 1; i <= 12; i++)
      if (temp[i] != -1) result.add(FlSpot(i.toDouble(), temp[i].toDouble()));
    return result;
  }

  static List<IndicatorData> avgDay(List<IndicatorData> data) {
    List<IndicatorData> result = [];
    int count = 1;
    for (int i = 0; i < data.length; i++) {
      if (i == data.length - 1 ||
          (i < data.length - 1 &&
              data[i].getDateTime().day != data[i + 1].getDateTime().day)) {
        if (count == 1) {
          result.add(data[i]);
          continue;
        }
        double sum = 0;
        for (int j = 0; j < count; j++) {
          sum += data[i - j].getValue();
        }
        result.add(IndicatorData(sum / count, data[i].getDateTime(), ""));
        count = 1;
        continue;
      }
      count += 1;
    }
    return result;
  }

  static List<IndicatorData> avgMonth(List<IndicatorData> data) {
    List<IndicatorData> result = [];
    int count = 1;
    for (int i = 0; i < data.length; i++) {
      if (i == data.length - 1 ||
          (i < data.length - 1 &&
              data[i].getDateTime().month != data[i + 1].getDateTime().month)) {
        if (count == 1) {
          result.add(data[i]);
          continue;
        }
        double sum = 0;
        for (int j = 0; j < count; j++) {
          sum += data[i - j].getValue();
        }
        result.add(IndicatorData(sum / count, data[i].getDateTime(), ""));
        count = 1;
        continue;
      }
      count += 1;
    }
    return result;
  }

  // Next Previous Switch Time handle
  static DateTime addYear(DateTime data, int value) => DateTime(
      data.year + value,
      data.month,
      data.day,
      data.hour,
      data.minute,
      data.second);

  static DateTime addMonth(DateTime data, int value) => DateTime(data.year,
      data.month + value, data.day, data.hour, data.minute, data.second);

  static DateTime addDay(DateTime data, int value) => DateTime(data.year,
      data.month, data.day + value, data.hour, data.minute, data.second);

  static DateTime addHour(DateTime data, int value) => DateTime(data.year,
      data.month, data.day, data.hour + value, data.minute, data.second);
}
