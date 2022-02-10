import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/indicator.dart';
import 'package:anthealth_mobile/theme/colors.dart';
import 'package:anthealth_mobile/widgets/common_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndicatorEditBottomSheet extends StatefulWidget {
  const IndicatorEditBottomSheet({
    Key? key,
    required this.title,
    required this.indicator,
    required this.dataPicker,
    required this.indexPicker,
    required this.dateTime,
    this.isTime,
    this.isDate,
    required this.unit,
    required this.cancel,
    required this.ok,
  }) : super(key: key);

  final String title;
  final String indicator;
  final List<String> dataPicker;
  final int indexPicker;
  final DateTime dateTime;
  final bool? isTime;
  final bool? isDate;
  final String unit;
  final VoidCallback cancel;
  final Function(int, DateTime) ok;

  @override
  _IndicatorEditBottomSheetState createState() =>
      _IndicatorEditBottomSheetState();
}

class _IndicatorEditBottomSheetState extends State<IndicatorEditBottomSheet> {
  List<String> _dataPicker = [];
  int _indexPickerData = 0;
  DateTime _time = DateTime.now();

  @override
  void initState() {
    _dataPicker = widget.dataPicker;
    _indexPickerData = widget.indexPicker;
    _time = widget.dateTime;
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
          CommonButton.ok(context, () => widget.ok(_indexPickerData, _time))
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
          SizedBox(
              width: MediaQuery.of(context).size.width / 8,
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
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (DateTime value) =>
                        setState(() => _time = value),
                    mode: CupertinoDatePickerMode.time,
                  )))
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
                      initialDateTime: _time,
                      minimumDate: DateTime(1900),
                      maximumDate: DateTime.now(),
                      onDateTimeChanged: (DateTime value) =>
                          setState(() => _time = value),
                      mode: CupertinoDatePickerMode.date)))
        ]);
  }
}
