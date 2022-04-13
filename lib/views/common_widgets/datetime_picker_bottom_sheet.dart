import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimePickerBottomSheet extends StatefulWidget {
  const DateTimePickerBottomSheet({
    Key? key,
    this.timeTitle,
    this.dateTitle,
    required this.dateTime,
    this.isTime,
    this.isDate,
    required this.cancel,
    required this.ok,
    this.isFuture,
  }) : super(key: key);

  final String? timeTitle;
  final String? dateTitle;
  final DateTime dateTime;
  final bool? isTime;
  final bool? isDate;
  final VoidCallback cancel;
  final Function(DateTime) ok;
  final bool? isFuture;

  @override
  _DateTimePickerBottomSheetState createState() =>
      _DateTimePickerBottomSheetState();
}

class _DateTimePickerBottomSheetState extends State<DateTimePickerBottomSheet> {
  DateTime _date = DateTime.now();
  DateTime _time = DateTime.now();
  String symbol = '.';

  @override
  void initState() {
    _date = widget.dateTime;
    _time = widget.dateTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                if (widget.isTime != false) buildSelectTime(context),
                if (widget.isTime != false && widget.isDate != false)
                  SizedBox(height: 32),
                if (widget.isDate != false) buildSelectDate(context),
                SizedBox(height: 32),
                buildButton(),
              ])));

  Widget buildButton() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonButton.cancel(context, widget.cancel),
            CommonButton.ok(
                context,
                () => widget.ok(DateTime(
                    (widget.isDate != false) ? _date.year : DateTime.now().year,
                    (widget.isDate != false)
                        ? _date.month
                        : DateTime.now().month,
                    (widget.isDate != false) ? _date.day : DateTime.now().day,
                    (widget.isTime != false) ? _time.hour : DateTime.now().hour,
                    (widget.isTime != false)
                        ? _time.minute
                        : DateTime.now().minute,
                    DateTime.now().second)))
          ]);

  Widget buildSelectTime(BuildContext context) => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.timeTitle != null)
              SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text(widget.timeTitle! + ': ',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: AnthealthColors.black0))),
            Expanded(
                child: SizedBox(
                    height: 150,
                    child: CupertinoDatePicker(
                        initialDateTime: _time,
                        minimumDate: DateTime(1900),
                        maximumDate: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day + 1),
                        onDateTimeChanged: (DateTime value) =>
                            setState(() => _time = value),
                        mode: CupertinoDatePickerMode.time)))
          ]);

  Widget buildSelectDate(BuildContext context) => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.dateTitle != null)
              SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text(widget.dateTitle! + ': ',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: AnthealthColors.black0))),
            Expanded(
                child: SizedBox(
                    height: 150,
                    child: CupertinoDatePicker(
                        initialDateTime: _date,
                        minimumDate: DateTime(1900),
                        maximumDate: (widget.isFuture == true) ? DateTime(3000) :DateTime.now(),
                        onDateTimeChanged: (DateTime value) =>
                            setState(() => _date = value),
                        mode: CupertinoDatePickerMode.date)))
          ]);
}
