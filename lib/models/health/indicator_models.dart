import 'dart:convert';

import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:flutter/material.dart';

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

  static Map<String, dynamic> formatToSendLoadData(
      int type, IndicatorFilter filter) {
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
    return result;
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
}

class MoreInfo {
  MoreInfo(this._content, this._url);

  final String _content;
  final String? _url;

  String getContent() => _content;

  String getUrl() => _url!;

  static MoreInfo buildWeightMoreInfo(
      BuildContext context, double height, double weight, String url) {
    double bmi = weight / (height * height);
    String content = S.of(context).Your_bmi + bmi.toStringAsFixed(1) + ".";
    String result = "";
    if (bmi >= 15.5 && bmi < 25) return MoreInfo(content, url);
    if (bmi < 15.5) result = S.of(context).thinness;
    if (bmi >= 25) result = S.of(context).overweight;
    if (bmi >= 30) result = S.of(context).obese_class_I;
    if (bmi >= 35) result = S.of(context).obese_class_II;
    if (bmi >= 40) result = S.of(context).obese_class_III;
    content += " " + S.of(context).You_are + result + ".";
    return MoreInfo(content, url);
  }
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
