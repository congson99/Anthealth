import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ReminderEditStartBottomSheet extends StatefulWidget {
  const ReminderEditStartBottomSheet({
    Key? key,
    required this.dataPicker,
    required this.indexPicker,
    required this.time,
    required this.cancel,
    required this.ok,
  }) : super(key: key);

  final List<DateTime> dataPicker;
  final int indexPicker;
  final DateTime time;
  final VoidCallback cancel;
  final Function(DateTime) ok;

  @override
  _ReminderEditStartBottomSheetState createState() =>
      _ReminderEditStartBottomSheetState();
}

class _ReminderEditStartBottomSheetState
    extends State<ReminderEditStartBottomSheet> {
  int indexPickerData = 0;
  DateTime time = DateTime.now();

  @override
  void initState() {
    indexPickerData = widget.indexPicker;
    time = widget.time;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16),
                  buildSelectValue(context),
                  SizedBox(height: 32),
                  buildButton(),
                ])));
  }

  Widget buildButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      CommonButton.cancel(context, widget.cancel),
      CommonButton.ok(
          context,
          () => widget.ok(DateTime(
              time.year,
              time.month,
              time.day,
              widget.dataPicker[indexPickerData].hour,
              widget.dataPicker[indexPickerData].year)))
    ]);
  }

  Widget buildSelectValue(BuildContext context) {
    return Row(children: [
      Expanded(
          flex: 1,
          child: SizedBox(
              height: 120,
              child: CupertinoPicker(
                  scrollController:
                      FixedExtentScrollController(initialItem: indexPickerData),
                  itemExtent: 30,
                  onSelectedItemChanged: (int value) => setState(() {
                        indexPickerData = value;
                      }),
                  children: widget.dataPicker
                      .map((mData) => Center(
                          child: Text(DateFormat("HH:mm").format(mData))))
                      .toList()))),
      SizedBox(width: 16),
      Expanded(
          flex: 3,
          child: SizedBox(
              height: 120,
              child: CupertinoDatePicker(
                  initialDateTime: time,
                  onDateTimeChanged: (DateTime value) =>
                      setState(() => time = value),
                  mode: CupertinoDatePickerMode.date)))
    ]);
  }
}
