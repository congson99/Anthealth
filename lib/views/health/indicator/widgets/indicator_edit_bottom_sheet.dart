import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndicatorEditBottomSheet extends StatefulWidget {
  const IndicatorEditBottomSheet({
    Key? key,
    required this.title,
    required this.indicator,
    required this.dataPicker,
    required this.subDataPicker,
    required this.indexPicker,
    required this.subIndexPicker,
    required this.dateTime,
    this.isTime,
    this.isDate,
    required this.unit,
    this.middleSymbol,
    required this.cancel,
    required this.ok,
  }) : super(key: key);

  final String title;
  final String indicator;
  final List<String> dataPicker;
  final List<String> subDataPicker;
  final int indexPicker;
  final int subIndexPicker;
  final DateTime dateTime;
  final bool? isTime;
  final bool? isDate;
  final String unit;
  final String? middleSymbol;
  final VoidCallback cancel;
  final Function(int, int, DateTime) ok;

  @override
  _IndicatorEditBottomSheetState createState() =>
      _IndicatorEditBottomSheetState();
}

class _IndicatorEditBottomSheetState extends State<IndicatorEditBottomSheet> {
  List<String> _dataPicker = [];
  int _indexPickerData = 0;
  List<String> _subDataPicker = [];
  int _subIndexPickerData = 0;
  DateTime _date = DateTime.now();
  DateTime _time = DateTime.now();
  String symbol = '.';

  @override
  void initState() {
    _dataPicker = widget.dataPicker;
    _indexPickerData = widget.indexPicker;
    _subDataPicker = widget.subDataPicker;
    _subIndexPickerData = widget.subIndexPicker;
    _date = widget.dateTime;
    _time = widget.dateTime;
    if (widget.middleSymbol != null) symbol = widget.middleSymbol!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          Padding(
              padding: const EdgeInsets.all(12),
              child: Text(widget.title,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: AnthealthColors.primary0))),
          Divider(height: 0.5, thickness: 0.5, color: AnthealthColors.black3),
          Padding(
              padding: const EdgeInsets.only(
                  top: 32, left: 16, right: 16, bottom: 16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildSelectValue(context),
                    SizedBox(height: 16),
                    if (widget.isTime != null) buildSelectTime(context),
                    SizedBox(height: 16),
                    if (widget.isDate != null) buildSelectDate(context),
                    SizedBox(height: 32),
                    buildButton(),
                  ]))
        ])));
  }

  Widget buildButton() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonButton.cancel(context, widget.cancel),
          CommonButton.ok(
              context,
              () => widget.ok(
                  _indexPickerData,
                  _subIndexPickerData,
                  DateTime(
                      (widget.isDate == true)
                          ? _date.year
                          : DateTime.now().year,
                      (widget.isDate == true)
                          ? _date.month
                          : DateTime.now().month,
                      (widget.isDate == true) ? _date.day : DateTime.now().day,
                      (widget.isTime == true)
                          ? _time.hour
                          : DateTime.now().hour,
                      (widget.isTime == true)
                          ? _time.minute
                          : DateTime.now().minute,
                      DateTime.now().second)))
        ]);
  }

  Widget buildSelectValue(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: Text(widget.indicator + ': ',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: AnthealthColors.black0))),
          Expanded(
              child: SizedBox(
                  height: 75,
                  child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                          initialItem: _indexPickerData),
                      looping: true,
                      itemExtent: 30,
                      onSelectedItemChanged: (int value) => setState(() {
                            _indexPickerData = value;
                          }),
                      children: _dataPicker
                          .map((mData) => Center(child: Text(mData)))
                          .toList()))),
          if (_subDataPicker.length > 0)
            SizedBox(
                width: 4,
                child: Text(symbol,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: AnthealthColors.black0))),
          if (_subDataPicker.length > 0)
            Expanded(
                child: SizedBox(
                    height: 75,
                    child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                            initialItem: _subIndexPickerData),
                        looping: true,
                        itemExtent: 30,
                        onSelectedItemChanged: (int value) => setState(() {
                              _subIndexPickerData = value;
                            }),
                        children: _subDataPicker
                            .map((mData) => Center(child: Text(mData)))
                            .toList()))),
          SizedBox(
              width: (widget.middleSymbol != null) ? 60 : MediaQuery.of(context).size.width / 8,
              child: Text(' ' + widget.unit,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: AnthealthColors.black0)))
        ]);
  }

  Widget buildSelectTime(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: Text(S.of(context).Record_hour + ': ',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: AnthealthColors.black0))),
          Expanded(
              child: SizedBox(
                  height: 75,
                  child: CupertinoDatePicker(
                      initialDateTime: _time,
                      minimumDate: DateTime(1900),
                      maximumDate: DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day + 1),
                      onDateTimeChanged: (DateTime value) =>
                          setState(() => _time = value),
                      mode: CupertinoDatePickerMode.time)))
        ]);
  }

  Widget buildSelectDate(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: Text(S.of(context).Record_date + ': ',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: AnthealthColors.black0))),
          Expanded(
              child: SizedBox(
                  height: 75,
                  child: CupertinoDatePicker(
                      initialDateTime: _date,
                      minimumDate: DateTime(1900),
                      maximumDate: DateTime.now(),
                      onDateTimeChanged: (DateTime value) =>
                          setState(() => _date = value),
                      mode: CupertinoDatePickerMode.date)))
        ]);
  }
}
