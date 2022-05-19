import 'package:anthealth_mobile/blocs/medic/medication_reminder_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/medicine_logic.dart';
import 'package:anthealth_mobile/models/medic/medication_reminder_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/avatar.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/medic/medication_reminder/create_reminder_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AllReminderPage extends StatefulWidget {
  const AllReminderPage({Key? key, required this.superContext})
      : super(key: key);

  final BuildContext superContext;

  @override
  State<AllReminderPage> createState() => _AllReminderPageState();
}

class _AllReminderPageState extends State<AllReminderPage> {
  List<MedicationReminder> activeReminders = [];
  List<MedicationReminder> doneReminders = [];

  @override
  void initState() {
    super.initState();
    activeReminders =
        BlocProvider.of<MedicationReminderCubit>(widget.superContext)
            .getAllReminders()[0];
    doneReminders =
        BlocProvider.of<MedicationReminderCubit>(widget.superContext)
            .getAllReminders()[1];
  }

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: S.of(context).All_reminder,
        back: () => Navigator.of(context).pop(),
        content:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          CommonText.section(S.of(context).Active_reminders, context),
          SizedBox(height: 16),
          if (activeReminders.length == 0)
            Text(S.of(context).no_active_reminders),
          if (activeReminders.length != 0)
            ...activeReminders
                .map((reminder) =>
                    buildReminderComponent(reminder, context, true))
                .toList(),
          SizedBox(height: 16),
          CustomDivider.common(),
          SizedBox(height: 16),
          CommonText.section(S.of(context).Done_reminders, context),
          SizedBox(height: 16),
          if (doneReminders.length == 0) Text(S.of(context).no_done_reminders),
          if (doneReminders.length != 0)
            ...activeReminders.map(
                (reminder) => buildReminderComponent(reminder, context, false)),
          SizedBox(height: 16),
          InkWell(
              onTap: () {},
              child: Text(S.of(context).Create_new_reminders,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AnthealthColors.primary1,
                      decoration: TextDecoration.underline))),
        ]));
  }

  Widget buildReminderComponent(
      MedicationReminder reminder, BuildContext context, bool isActive) {
    Color color0 =
        isActive ? AnthealthColors.secondary0 : AnthealthColors.primary0;
    Color color1 =
        isActive ? AnthealthColors.secondary1 : AnthealthColors.primary1;
    Color color3 =
        isActive ? AnthealthColors.secondary3 : AnthealthColors.primary3;
    Color color5 =
        isActive ? AnthealthColors.secondary5 : AnthealthColors.primary5;
    return Container(
        decoration: BoxDecoration(
            color: color5, borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.only(bottom: 16),
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
                              border: Border.all(color: color1, width: 0.5)),
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
                                  .copyWith(color: color1)))
                    ]),
                    SizedBox(height: 12),
                    Text(
                        S.of(context).Quantity +
                            ": " +
                            MedicineLogic.handleQuantity(
                                MedicationReminder.getQuantity(reminder)) +
                            " " +
                            MedicineLogic.getUnit(
                                context, reminder.medicine.getUnit()) +
                            (isActive
                                ? (" (" +
                                    S.of(context).Remaining +
                                    ": " +
                                    MedicineLogic.handleQuantity(
                                        MedicationReminder.getRemainingQuantity(
                                            reminder)) +
                                    " " +
                                    MedicineLogic.getUnit(
                                        context, reminder.medicine.getUnit()) +
                                    ")")
                                : ""),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: color1)),
                    SizedBox(height: 8),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).Reminder_times + ": ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: color1)),
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
                                              .copyWith(color: color1))))
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
                            .copyWith(color: color1)),
                    SizedBox(height: 8),
                    Text(
                        S.of(context).End +
                            ": " +
                            DateFormat("HH:mm dd.MM.yyyy")
                                .format(reminder.allReminder.last.time),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: color1)),
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
                            .copyWith(color: color1))
                  ])),
          GestureDetector(
              onTap: () => isActive ? stop(reminder) : reuse(reminder),
              child: Container(
                  height: 42,
                  decoration: BoxDecoration(
                      color: color3,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(16))),
                  alignment: Alignment.center,
                  child: Text(
                      isActive
                          ? S.of(context).button_stop_reminder
                          : S.of(context).button_reuse_reminder,
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(color: color0))))
        ]));
  }

  void stop(MedicationReminder reminder) {
    BlocProvider.of<MedicationReminderCubit>(widget.superContext)
        .stopReminder(reminder)
        .then((value) {
      if (value) {
        setState(() {
          activeReminders =
              BlocProvider.of<MedicationReminderCubit>(widget.superContext)
                  .getAllReminders()[0];
          doneReminders =
              BlocProvider.of<MedicationReminderCubit>(widget.superContext)
                  .getAllReminders()[1];
        });
      }
    });
  }

  void reuse(MedicationReminder reminder) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => CreateReminderPage(
            reminder: reminder,
            done: (reminder) {
              BlocProvider.of<MedicationReminderCubit>(widget.superContext)
                  .addReminder([reminder]).then((value) {
                if (value) {
                  BlocProvider.of<MedicationReminderCubit>(widget.superContext)
                      .loadMedicationReminder();
                  Navigator.pop(context);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(S.of(context).Create_reminder +
                          ' ' +
                          S.of(context).successfully +
                          '!')));
                }
              });
            })));
  }
}
