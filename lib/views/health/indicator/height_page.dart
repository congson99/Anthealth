import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/indicator.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_detail_popup.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_detail_records.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_edit_bottom_sheet.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_latest_record.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_line_chart.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_appbar.dart';
import 'package:anthealth_mobile/views/common_widgets/next_previous_bar.dart';
import 'package:anthealth_mobile/views/common_widgets/switch_bar.dart';
import 'package:anthealth_mobile/views/common_widgets/warning_popup.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeightPage extends StatefulWidget {
  const HeightPage({Key? key}) : super(key: key);

  final String unit = 'm';

  @override
  _HeightPageState createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  int _filterIndex = 0;
  int _dataIndex = 0;
  List<String> _dataPicker = [];

  //temp data
  List<List<Indicator>> detailData = [
    [
      Indicator(170, DateTime(2021, 12, 27), "Son"),
      Indicator(169, DateTime(2021, 10, 19), "Son"),
      Indicator(168, DateTime(2021, 9, 16), "Son"),
      Indicator(166, DateTime(2021, 5, 23), ""),
      Indicator(165, DateTime(2021, 5, 3), ""),
      Indicator(165, DateTime(2021, 4, 8), "Son"),
      Indicator(164, DateTime(2021, 2, 1), ""),
      Indicator(160, DateTime(2021, 1, 12), ""),
    ],
    [
      Indicator(170, DateTime(2021), ""),
      Indicator(147, DateTime(2020), ""),
      Indicator(143, DateTime(2019), ""),
      Indicator(142, DateTime(2018), ""),
      Indicator(140, DateTime(2017), ""),
    ]
  ];

  @override
  Widget build(BuildContext context) {
    for (int i = 250; i >= 10; i--)
      _dataPicker.add((i ~/ 100).toString() + '.' + (i % 100).toString());
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      Container(
          margin: const EdgeInsets.only(top: 65),
          child: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: buildContent(context)))),
      CustomAppBar(
          title: S.of(context).Height,
          back: () => Navigator.pop(context),
          add: () {
            showModalBottomSheet(
                enableDrag: false,
                isDismissible: true,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16))),
                context: context,
                builder: (_) => IndicatorEditBottomSheet(
                    title: S.of(context).Add_height,
                    indicator: S.of(context).Height,
                    dataPicker: _dataPicker,
                    indexPicker: 250 - detailData[0][0].value.toInt(),
                    dateTime: DateTime.now(),
                    isDate: true,
                    unit: widget.unit,
                    cancel: () => Navigator.pop(context),
                    ok: (indexPicker, time) {
                      setState(() => detailData[0].insert(
                          0,
                          Indicator(250 - indexPicker, time,
                              detailData[0][0].recordID)));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(S.of(context).Add_height +
                              ' ' +
                              S.of(context).successfully +
                              '!')));
                    }));
          },
          settings: () {})
    ])));
  }

  Widget buildContent(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IndicatorLatestRecord(
              unit: widget.unit,
              value: (detailData[0][0].value ~/ 100).toString() +
                  '.' +
                  (detailData[0][0].value % 100).toString(),
              time: DateFormat('dd.MM.yyyy').format(detailData[0][0].dateTime),
              information:
                  'Theo kết quả Tổng điều tra dinh dưỡng năm 2019-2020, chiều cao trung bình nam thanh niên Việt Nam là 168,1 cm và chiều cao trung bình nữ thanh niên Việt Nam là 156,2 cm.',
              informationURL:
                  'https://vnexpress.net/chieu-cao-nguoi-viet-tang-nhanh-nhat-tu-truoc-den-nay-4263410.html'),
          buildDetailContainer(context),
          SizedBox(height: 32)
        ]);
  }

  Widget buildDetailContainer(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AnthealthColors.primary5,
            borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SwitchBar(
                content: [S.of(context).Year, S.of(context).All_time],
                index: _filterIndex,
                onIndexChange: (index) => setState(() => _filterIndex = index),
                colorID: 0,
              ),
              if (_filterIndex == 0) SizedBox(height: 24),
              if (_filterIndex == 0)
                NextPreviousBar(
                    content: convertToYearSwitchData(detailData[1]),
                    index: _dataIndex,
                    increse: (index) => setState(() => _dataIndex = index),
                    decrese: (index) => setState(() => _dataIndex = index)),
              SizedBox(height: 24),
              IndicatorLineChart(
                  filterIndex: _filterIndex,
                  indicatorIndex: 0,
                  data: _filterIndex == 0
                      ? convertToMonthChartData(detailData[0])
                      : convertToYearChartData(detailData[1])),
              SizedBox(height: 24),
              IndicatorDetailRecords(
                  unit: widget.unit,
                  data: _filterIndex == 0
                      ? convertToMonthDetailData(detailData[0])
                      : convertToYearDetailData(detailData[1]),
                  onTap: (index) => onDetailTap(index))
            ]));
  }

  void onDetailTap(int index) {
    if (_filterIndex == 1)
      setState(() {
        _filterIndex = 0;
        _dataIndex = index;
      });
    else
      showPopup(index);
  }

  void showPopup(int index) {
    showDialog(
        context: context,
        builder: (_) => IndicatorDetailPopup(
            title: S.of(context).Height,
            value: detailData[0][index].value.toString(),
            unit: widget.unit,
            time: DateFormat('hh:mm dd.MM.yyyy')
                .format(detailData[0][index].dateTime),
            recordID: detailData[0][index].recordID,
            delete: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (_) => WarningPopup(
                      title: S.of(context).Warning_delete_data,
                      cancel: () => Navigator.pop(context),
                      delete: () {
                        setState(() => detailData[0].removeAt(index));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(S.of(context).Delete_height +
                                ' ' +
                                S.of(context).successfully +
                                '!')));
                      }));
            },
            edit: () {
              Navigator.pop(context);
              showModalBottomSheet(
                  enableDrag: false,
                  isDismissible: true,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16))),
                  context: context,
                  builder: (_) => IndicatorEditBottomSheet(
                      title: S.of(context).Edit_height,
                      indicator: S.of(context).Height,
                      dataPicker: _dataPicker,
                      indexPicker: 250 - detailData[0][index].value,
                      dateTime: detailData[0][index].dateTime,
                      isDate: true,
                      unit: widget.unit,
                      cancel: () => Navigator.pop(context),
                      ok: (indexPicker, time) {
                        setState(() => detailData[0][index] = Indicator(
                            250 - indexPicker,
                            time,
                            detailData[0][index].recordID));
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(S.of(context).Edit_height +
                                ' ' +
                                S.of(context).successfully +
                                '!')));
                      }));
            },
            close: () => Navigator.pop(context)));
  }

  List<String> convertToYearSwitchData(List<Indicator> heights) {
    List<String> result = [];
    for (Indicator x in heights) result.add(x.dateTime.year.toString());
    return result;
  }

  List<FlSpot> convertToMonthChartData(List<Indicator> heights) {
    List<int> temp = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
    for (Indicator x in heights) temp[x.dateTime.month] = x.value;
    List<FlSpot> result = [];
    for (int i = 1; i <= 12; i++)
      if (temp[i] != -1) result.add(FlSpot(i.toDouble(), temp[i].toDouble()));
    return result;
  }

  List<FlSpot> convertToYearChartData(List<Indicator> heights) {
    List<FlSpot> result = [];
    for (Indicator x in heights)
      result.insert(0, FlSpot(x.dateTime.year.toDouble(), x.value.toDouble()));
    return result;
  }

  List<IndicatorDetailRecord> convertToMonthDetailData(
      List<Indicator> heights) {
    List<IndicatorDetailRecord> result = [];
    for (Indicator x in heights)
      result.add(IndicatorDetailRecord(DateFormat('dd.MM').format(x.dateTime),
          (x.value ~/ 100).toString() + '.' + (x.value % 100).toString()));
    return result;
  }

  List<IndicatorDetailRecord> convertToYearDetailData(List<Indicator> heights) {
    List<IndicatorDetailRecord> result = [];
    for (Indicator x in heights)
      result.add(IndicatorDetailRecord(x.dateTime.year.toString(),
          (x.value ~/ 100).toString() + '.' + (x.value % 100).toString()));
    return result;
  }
}
