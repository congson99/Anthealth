import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/medicine_logic.dart';
import 'package:anthealth_mobile/models/medic/medication_reminder_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/avatar.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:anthealth_mobile/views/common_widgets/datetime_picker_bottom_sheet.dart';
import 'package:anthealth_mobile/views/medic/medication_reminder/widgets/reminder_edit_start_bottom_sheet.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateReminderPage extends StatefulWidget {
  const CreateReminderPage(
      {Key? key, required this.reminder, required this.done})
      : super(key: key);

  final MedicationReminder reminder;
  final Function(MedicationReminder) done;

  @override
  State<CreateReminderPage> createState() => _CreateReminderPageState();
}

class _CreateReminderPageState extends State<CreateReminderPage> {
  double quantity = 0;
  MedicationReminder? reminder;
  DateTime startTime = DateTime.now();
  TextEditingController startController = TextEditingController();
  List<TextEditingController> reminderController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  @override
  void initState() {
    super.initState();
    reminder = widget.reminder;
    quantity = MedicationReminder.getQuantity(reminder!);
    while (reminder!.dayReminder.length < 4)
      reminder!.dayReminder.add(Reminder(DateTime(-1), 0, ""));
    for (int i = 0; i < 4; i++)
      if (reminder!.dayReminder[i].time.year != -1) {
        reminderController[i].text =
            DateFormat("HH:mm").format(reminder!.dayReminder[i].time);
      }
    startTime = reminder!.allReminder.first.time;
    startController.text = DateFormat("HH:mm dd.MM.yyyy").format(startTime);
  }

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: S.of(context).Create_reminder,
        back: () => Navigator.pop(context),
        content: (reminder == null)
            ? Center(child: CircularProgressIndicator())
            : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                buildMedicine(context),
                SizedBox(height: 16),
                buildEditingArea(context),
                SizedBox(height: 16),
                CommonButton.round(context, () => done(),
                    S.of(context).button_done, AnthealthColors.primary1)
              ]));
  }

  Widget buildMedicine(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AnthealthColors.primary3, width: 1)),
          child:
              Avatar(imagePath: reminder!.medicine.getImagePath(), size: 64)),
      SizedBox(width: 16),
      Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(reminder!.medicine.getName(),
                style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 6),
            Text(
                S.of(context).Unit +
                    ": " +
                    MedicineLogic.getUnit(
                        context, reminder!.medicine.getUnit()),
                style: Theme.of(context).textTheme.bodyText2),
            SizedBox(height: 4),
            Text(
                S.of(context).Usage +
                    ": " +
                    MedicineLogic.getUsage(
                        context, reminder!.medicine.getUsage()),
                style: Theme.of(context).textTheme.bodyText2)
          ]))
    ]);
  }

  Container buildEditingArea(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AnthealthColors.primary5,
            borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(16),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(children: [
            Text(S.of(context).Quantity + "  ",
                style: Theme.of(context).textTheme.subtitle1),
            SizedBox(
                width: 70,
                child: CommonTextField.box(
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    initialValue: MedicineLogic.handleQuantity(quantity),
                    textInputType:
                        TextInputType.numberWithOptions(decimal: true),
                    context: context,
                    onChanged: (value) => updateQuantity(value))),
            Text(
                "  " +
                    MedicineLogic.getUnit(
                        context, reminder!.medicine.getUnit()),
                style: Theme.of(context).textTheme.subtitle1),
            Expanded(child: Container()),
          ]),
          SizedBox(height: 24),
          Row(children: [
            Text(S.of(context).Start + "  ",
                style: Theme.of(context).textTheme.subtitle1),
            Expanded(
                child: CommonTextField.box(
                    onTap: () => updateStartTime(context),
                    textEditingController: startController,
                    readOnly: true,
                    hintText: S.of(context).Time,
                    context: context,
                    onChanged: (value) {})),
          ]),
          SizedBox(height: 24),
          buildReminderTimes(context),
        ]));
  }

  Widget buildReminderTimes(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(S.of(context).Reminder_times,
          style: Theme.of(context).textTheme.subtitle1),
      SizedBox(height: 16),
      SizedBox(width: 16),
      ...[0, 1, 2, 3]
          .map((index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(children: [
                Expanded(
                    child: CommonTextField.box(
                        onTap: () => updateReminderTime(context, index),
                        textEditingController: reminderController[index],
                        readOnly: true,
                        hintText: S.of(context).Time,
                        context: context,
                        onChanged: (value) {})),
                SizedBox(width: 12),
                SizedBox(
                  width: 100,
                  child: CommonTextField.box(
                      textInputType:
                          TextInputType.numberWithOptions(decimal: true),
                      initialValue: MedicineLogic.handleQuantity(
                          reminder!.dayReminder[index].quantity),
                      hintText: S.of(context).Quantity,
                      context: context,
                      onChanged: (value) =>
                          updateReminderQuantity(value, index)),
                )
              ])))
          .toList()
    ]);
  }

  /// Actions
  void updateQuantity(String value) {
    setState(() {
      if (value == "") {
        quantity = 0;
        return;
      }
      quantity = double.parse(value);
    });
  }

  void updateStartTime(BuildContext context) {
    List<DateTime> indexData = [];
    int startIndex = 0;
    for (int i = 0; i < 4; i++)
      if (reminder!.dayReminder[i].time.year != -1)
        indexData.add(reminder!.dayReminder[i].time);
    for (int i = 0; i < indexData.length; i++)
      if (startTime.hour == indexData[i].hour &&
          startTime.minute == indexData[i].minute) startIndex = i;
    showModalBottomSheet(
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        context: context,
        builder: (_) => ReminderEditStartBottomSheet(
            dataPicker: indexData,
            indexPicker: startIndex,
            time: startTime,
            cancel: () => Navigator.pop(context),
            ok: (time) {
              setState(() {
                startTime = time;
                startController.text =
                    DateFormat("HH:mm dd.MM.yyyy").format(startTime);
              });
            }));
  }

  void updateReminderTime(BuildContext context, int index) {
    showModalBottomSheet(
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        context: context,
        builder: (_) => DateTimePickerBottomSheet(
            dateTime: reminder!.dayReminder[index].time,
            isDate: false,
            isFuture: true,
            cancel: () => Navigator.pop(context),
            ok: (value) {
              setState(() => reminder!.dayReminder[index].time =
                  DateTime(1, 1, 1, value.hour, value.minute));
              reminderController[index].text =
                  DateFormat("HH:mm").format(value);
              Navigator.pop(context);
            }));
  }

  void updateReminderQuantity(String value, int index) {
    setState(() {
      if (value == "") {
        reminder!.dayReminder[index].quantity = 0;
        return;
      }
      reminder!.dayReminder[index].quantity = double.parse(value);
    });
  }

  void done() {
    if (checkFill()) {
      List<Reminder> list = [];
      for (Reminder x in reminder!.dayReminder)
        if (x.time.year != -1) list.add(x);
      setState(() => reminder!.dayReminder = list);
      widget.done(MedicationReminder.createDone(quantity, reminder!));
    } else
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(S.of(context).required_fill)));
  }

  bool checkFill() {
    if (quantity == 0) return false;
    double count = 0;
    for (Reminder x in reminder!.dayReminder)
      if (x.time.year != -1) count += x.quantity;
    if (count == 0) return false;
    return true;
  }
}
