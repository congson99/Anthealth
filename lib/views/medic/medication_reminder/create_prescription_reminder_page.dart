import 'package:anthealth_mobile/blocs/medic/medication_reminder_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/medicine_logic.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/models/medic/medication_reminder_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/avatar.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_snackbar.dart';
import 'package:anthealth_mobile/views/medic/medication_reminder/create_reminder_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CreatePrescriptionReminderPage extends StatefulWidget {
  const CreatePrescriptionReminderPage(
      {Key? key, required this.superContext, required this.prescription})
      : super(key: key);

  final BuildContext superContext;
  final Prescription prescription;

  @override
  State<CreatePrescriptionReminderPage> createState() =>
      _CreatePrescriptionReminderPageState();
}

class _CreatePrescriptionReminderPageState
    extends State<CreatePrescriptionReminderPage> {
  Prescription? prescription;
  List<MedicationReminder> reminders = [];

  @override
  void initState() {
    super.initState();
    prescription = widget.prescription;
    for (DigitalMedicine x in prescription!.medication)
      reminders.add(MedicationReminder.createBase(widget.superContext, x,
          prescription!.name, prescription!.description));
  }

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: S.of(context).Create_reminder,
        back: () => Navigator.of(context).pop(),
        content:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(S.of(context).Prescription + ": ",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: AnthealthColors.primary0)),
            Expanded(
              child: Text(
                  prescription!.name +
                      ((prescription!.description != "")
                          ? " " + prescription!.description
                          : ""),
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: AnthealthColors.primary0)),
            )
          ]),
          SizedBox(height: 24),
          ...reminders
              .map((reminder) => buildReminderComponent(
                  context, reminder, reminders.indexOf(reminder)))
              .toList(),
          CommonButton.round(context, () => done(), S.of(context).button_done,
              AnthealthColors.primary1)
        ]));
  }

  Widget buildReminderComponent(
      BuildContext context, MedicationReminder reminder, int index) {
    return Container(
        decoration: BoxDecoration(
            color: AnthealthColors.primary5,
            borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.only(bottom: 32),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(children: [
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AnthealthColors.primary1, width: 0.5)),
                          child: Avatar(
                              imagePath: reminder.medicine.getImagePath(),
                              size: 42)),
                      SizedBox(width: 8),
                      Expanded(
                          child: Text(reminder.medicine.getName(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: AnthealthColors.primary1)))
                    ]),
                    SizedBox(height: 12),
                    Text(
                        S.of(context).Quantity +
                            ": " +
                            MedicineLogic.handleQuantity(
                                MedicationReminder.getQuantity(reminder)) +
                            " " +
                            MedicineLogic.getUnit(
                                context, reminder.medicine.getUnit()),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: AnthealthColors.primary1)),
                    SizedBox(height: 8),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).Reminder_times + ": ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: AnthealthColors.primary1)),
                          Column(
                              children: reminder.dayReminder
                                  .map((dayReminder) => Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Text(
                                          DateFormat("HH:mm")
                                                  .format(dayReminder.time) +
                                              " - " +
                                              MedicineLogic.getUsage(
                                                  context,
                                                  reminder.medicine
                                                      .getUsage()) +
                                              " " +
                                              MedicineLogic.handleQuantity(
                                                  dayReminder.quantity) +
                                              " " +
                                              MedicineLogic.getUnit(context,
                                                  reminder.medicine.getUnit()),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: AnthealthColors
                                                      .primary1))))
                                  .toList())
                        ]),
                    SizedBox(height: 4),
                    Text(
                        S.of(context).Start +
                            ": " +
                            DateFormat("HH:mm dd.MM.yyyy")
                                .format(reminder.allReminder.first.time),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: AnthealthColors.primary1)),
                    SizedBox(height: 8),
                    Text(
                        S.of(context).End +
                            ": " +
                            DateFormat("HH:mm dd.MM.yyyy")
                                .format(reminder.allReminder.last.time),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: AnthealthColors.primary1)),
                    SizedBox(height: 8),
                    Text(
                        S.of(context).Prescription +
                            ": " +
                            reminder.prescription.name +
                            ((reminder.prescription.description != "")
                                ? " - " + reminder.prescription.description
                                : ""),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: AnthealthColors.primary1))
                  ])),
          Container(
              height: 42,
              width: MediaQuery.of(context).size.width - 32,
              decoration: BoxDecoration(
                  color: AnthealthColors.primary3,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(16))),
              alignment: Alignment.center,
              child: Row(children: [
                Expanded(
                    child: GestureDetector(
                        onTap: () => setState(() => reminders.removeAt(index)),
                        child: Container(
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: Text(S.of(context).button_delete,
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(
                                        color: AnthealthColors.primary0))))),
                Container(
                    height: 42, width: 1, color: AnthealthColors.primary5),
                Expanded(
                    child: GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => CreateReminderPage(
                                    reminder: reminder,
                                    done: (value) {
                                      Navigator.pop(context);
                                      setState(() => reminders[index] = value);
                                    }))),
                        child: Container(
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: Text(S.of(context).button_edit,
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(
                                        color: AnthealthColors.primary0)))))
              ]))
        ]));
  }

  void done() {
    if (reminders.length == 0) {
      Navigator.pop(context);
      return;
    }
    BlocProvider.of<MedicationReminderCubit>(widget.superContext)
        .addReminder(reminders)
        .then((value) {
      if (value) {
        Navigator.pop(context);
        Navigator.pop(context);
        BlocProvider.of<MedicationReminderCubit>(widget.superContext)
            .loadMedicationReminder();
        ShowSnackBar.showSuccessSnackBar(
            context,
            S.of(context).Create_reminder +
                ' ' +
                S.of(context).successfully +
                '!');
      }
    });
  }
}
