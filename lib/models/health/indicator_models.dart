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

  static List<FlSpot> convertToMonthChartData(List<IndicatorData> data) {
    List<int> temp = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
    for (IndicatorData x in data) temp[x.getDateTime().month] = x.getValue();
    List<FlSpot> result = [];
    for (int i = 1; i <= 12; i++)
      if (temp[i] != -1) result.add(FlSpot(i.toDouble(), temp[i].toDouble()));
    return result;
  }

  static List<FlSpot> convertToYearChartData(List<IndicatorData> data) {
    List<FlSpot> result = [];
    for (IndicatorData x in data)
      result.insert(0, FlSpot(x.getDateTime().year.toDouble(), x.getValue().toDouble()));
    return result;
  }
}

class IndicatorData {
  IndicatorData(this._value, this._dateTime, this._recordID);

  final int _value;
  final DateTime _dateTime;
  final String _recordID;

  int getValue() => _value;

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
    for (int i = 1; i < 250; i++) {
      list.add((i ~/ 100).toString() + '.' + (i % 100).toString());
    }
    return list;
  }
}
