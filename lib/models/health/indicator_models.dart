import 'package:anthealth_mobile/blocs/common_logic/server_logic.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';

class IndicatorPageData {
  IndicatorPageData(this._ownerID, this._ownerName, this._type,
      this._latestRecord, this._moreInfo, this._filter, this._data);

  final int _ownerID;
  final String _ownerName;
  final int _type;
  final IndicatorData _latestRecord;
  final MoreInfo _moreInfo;
  final IndicatorFilter _filter;
  final List<IndicatorData> _data;

  int getOwnerID() => _ownerID;

  String getOwnerName() => _ownerName;

  int getType() => _type;

  IndicatorData getLatestRecord() => _latestRecord;

  MoreInfo getMoreInfo() => _moreInfo;

  IndicatorFilter getFilter() => _filter;

  List<IndicatorData> getData() => _data;

  static String formatToSendLoadData(int type, IndicatorFilter filter) {
    DateTime start = DateTime.now();
    DateTime end = DateTime.now();
    // 10 Year
    if ((type == 0 && filter.getFilterIndex() == 1) ||
        (type == 1 && filter.getFilterIndex() == 2)) {
      start = DateTime(filter.getTime().year - 10);
    }
    // In year
    if ((type == 0 && filter.getFilterIndex() == 0) ||
        (type == 1 && filter.getFilterIndex() == 1)) {
      start = DateTime(filter.getTime().year);
      end = DateTime(filter.getTime().year + 1);
    }
    // In month
    if (type == 1 && filter.getFilterIndex() == 0) {
      start = DateTime(filter.getTime().year, filter.getTime().month);
      end = DateTime(filter.getTime().year, filter.getTime().month + 1);
    }
    // 10 Day
    if (type > 1 && filter.getFilterIndex() == 2) {
      start = DateTime(filter.getTime().year, filter.getTime().month,
          filter.getTime().day - 10);
    }
    // In day
    if (type > 1 && filter.getFilterIndex() == 1) {
      start = DateTime(
          filter.getTime().year, filter.getTime().month, filter.getTime().day);
      end = DateTime(filter.getTime().year, filter.getTime().month,
          filter.getTime().day + 1);
    }
    // In 3 hour
    if (type > 1 && filter.getFilterIndex() == 0) {
      start = DateTime(filter.getTime().year, filter.getTime().month,
          filter.getTime().day, filter.getTime().hour);
      end = DateTime(filter.getTime().year, filter.getTime().month,
          filter.getTime().day, filter.getTime().hour + 1);
    }
    var result = {
      "type": type,
      "filterID": filter.getFilterIndex(),
      "start_time": (start.millisecondsSinceEpoch) ~/ 1000,
      "end_time": (end.millisecondsSinceEpoch) ~/ 1000
    };
    return result.toString();
  }

  static IndicatorPageData getPageData(
      int type, IndicatorFilter filter, dynamic value) {
    IndicatorData latest = IndicatorData(0, DateTime.now(), '');
    var latestData = ServerLogic.getData(value)["latest"];
    if (latestData != '')
      latest = IndicatorData(
          0.0 + jsonDecode(latestData)["value"],
          DateTime.fromMillisecondsSinceEpoch(
              jsonDecode(latestData)["time"] * 1000),
          '');
    MoreInfo moreInfo = MoreInfo(ServerLogic.getData(value)["info"],
        ServerLogic.getData(value)["infoUrl"]);
    List<IndicatorData> list = IndicatorPageData.formatList(
        type, filter, ServerLogic.getData(value)["data"]);
    return IndicatorPageData(
        ServerLogic.getData(value)["owner"],
        ServerLogic.getData(value)["name"],
        type,
        latest,
        moreInfo,
        filter,
        list);
  }

  static List<IndicatorData> formatList(
      int type, IndicatorFilter filter, List<dynamic> data) {
    int filterIndex = filter.getFilterIndex();
    List<IndicatorData> temp = [];
    // Detail
    if (filterIndex == 0) {
      for (dynamic i in data)
        temp.insert(
            0,
            IndicatorData(
                0.0 + i["value"],
                DateTime.fromMillisecondsSinceEpoch(i["time"] * 1000),
                i["creator"].toString()));
    }
    // Hour
    if (type > 1 && filterIndex == 1) {
      for (dynamic i in data)
        temp.insert(
            0,
            IndicatorData(0.0 + i["value"],
                DateTime.fromMillisecondsSinceEpoch(i["hour"] * 1000), ""));
    }
    // Day
    if (type > 1 && filterIndex == 2) {
      for (dynamic i in data)
        temp.insert(
            0,
            IndicatorData(0.0 + i["value"],
                DateTime.fromMillisecondsSinceEpoch(i["day"] * 1000), ""));
    }
    // Month
    if (type == 1 && filterIndex == 1) {
      for (dynamic i in data)
        temp.insert(
            0,
            IndicatorData(0.0 + i["value"],
                DateTime(filter.getTime().year, i["month"]), ""));
    }
    // Year
    if ((type == 0 && filterIndex == 1) || (type == 1 && filterIndex == 2)) {
      for (dynamic i in data)
        temp.insert(
            0, IndicatorData(0.0 + i["value"], DateTime(i["year"]), ""));
    }

    return temp;
  }

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

  static List<FlSpot> convertToDayChartAvgData(List<IndicatorData> data) {
    List<IndicatorData> rData = avgDay(data).reversed.toList();
    List<FlSpot> result = [];
    for (IndicatorData x in rData) {
      result.insert(0, FlSpot(x.getDateTime().day.toDouble(), x.getValue()));
      if (result.length == 10) break;
    }
    return result.reversed.toList();
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
}

class IndicatorData {
  IndicatorData(this._value, this._dateTime, this._recordID);

  final double _value;
  final DateTime _dateTime;
  final String _recordID;

  double getValue() => _value;

  DateTime getDateTime() => _dateTime;

  String getRecordID() => _recordID;
}

class IndicatorFilter {
  IndicatorFilter(this._filterIndex, this._time);

  final int _filterIndex;
  final DateTime _time;

  int getFilterIndex() => _filterIndex;

  DateTime getTime() => _time;

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

class MoreInfo {
  MoreInfo(this._content, this._url);

  final String _content;
  final String? _url;

  String getContent() => _content;

  String getUrl() => _url!;
}

class IndicatorDataPicker {
  static List<String> height() {
    List<String> list = [];
    for (int i = 0; i < 3; i++) list.add((i).toString());
    return list;
  }

  static List<String> weight() {
    List<String> list = [];
    for (int i = 0; i < 300; i++) list.add((i).toString());
    return list;
  }

  static List<String> heartRace() {
    List<String> list = [];
    for (int i = 0; i < 300; i++) list.add((i).toString());
    return list;
  }

  static List<String> temperature() {
    List<String> list = [];
    for (int i = 30; i < 46; i++) list.add((i).toString());
    return list;
  }

  static List<String> bloodPressure() {
    List<String> list = [];
    for (int i = 0; i < 200; i++) list.add((i).toString());
    return list;
  }

  static List<String> spo2() {
    List<String> list = [];
    for (int i = 0; i <= 100; i++) list.add((i).toString());
    return list;
  }

  static List<String> sub9() {
    List<String> list = [];
    for (int i = 0; i < 10; i++) list.add((i).toString());
    return list;
  }

  static List<String> sub99() {
    List<String> list = [];
    for (int i = 0; i < 100; i++) list.add((i).toString());
    return list;
  }
}
