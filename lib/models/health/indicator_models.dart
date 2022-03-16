import 'package:fl_chart/fl_chart.dart';

class IndicatorPageData {
  IndicatorPageData(
      this._type, this._latestRecord, this._moreInfo, this._filter, this._data);

  final int _type;
  final IndicatorData _latestRecord;
  final MoreInfo _moreInfo;
  final IndicatorFilter _filter;
  final List<IndicatorData> _data;

  int getType() => _type;

  IndicatorData getLatestRecord() => _latestRecord;

  MoreInfo getMoreInfo() => _moreInfo;

  IndicatorFilter getFilter() => _filter;

  List<IndicatorData> getData() => _data;

  static List<IndicatorData> formatList(int type, List<dynamic> data) {
    List<IndicatorData> temp = [];
    // Detail
    if (type == 0)
      for (dynamic i in data)
        temp.insert(
            0,
            IndicatorData(
                0.0 + i["value"],
                DateTime.fromMillisecondsSinceEpoch(i["time"] * 1000),
                i["creator"].toString()));
    // Year
    if (type == 1)
      for (dynamic i in data)
        temp.insert(
            0, IndicatorData(0.0 + i["value"], DateTime(i["year"]), ""));

    return temp;
  }

  static List<FlSpot> convertToMonthChartLatestData(List<IndicatorData> data) {
    List<double> temp = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
    for (IndicatorData x in data) temp[x.getDateTime().month] = x.getValue();
    List<FlSpot> result = [];
    for (int i = 1; i <= 12; i++)
      if (temp[i] != -1) result.add(FlSpot(i.toDouble(), temp[i].toDouble()*100));
    return result;
  }

  static List<FlSpot> convertToYearChartData(List<IndicatorData> data) {
    List<FlSpot> result = [];
    for (IndicatorData x in data)
      result.insert(
          0, FlSpot(x.getDateTime().year.toDouble(), x.getValue()*100));
    return result;
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
  IndicatorFilter(this._filterIndex, this._filterValue);

  final int _filterIndex;
  final int _filterValue;

  int getFilterIndex() => _filterIndex;

  int getFilterValue() => _filterValue;
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
    for (int i = 0; i < 250; i++) {
      list.add((i ~/ 100).toString() +
          '.' +
          ((i % 100 < 10) ? '0' : '') +
          (i % 100).toString());
    }
    return list;
  }
}
