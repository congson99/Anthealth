import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/medic/medication_reminder_cubit.dart';
import 'package:anthealth_mobile/blocs/medic/medication_reminder_state.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/dateTime_logic.dart';
import 'package:anthealth_mobile/logics/medicine_logic.dart';
import 'package:anthealth_mobile/logics/number_logic.dart';
import 'package:anthealth_mobile/models/medic/medication_reminder_models.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/avatar.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/next_previous_bar.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/medic/medication_reminder/all_prescription_page.dart';
import 'package:anthealth_mobile/views/medic/medication_reminder/all_reminder_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MedicationReminderPage extends StatelessWidget {
  const MedicationReminderPage({Key? key, required this.dashboardContext})
      : super(key: key);

  final BuildContext dashboardContext;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MedicationReminderCubit>(
        create: (context) => MedicationReminderCubit(),
        child: BlocBuilder<MedicationReminderCubit, CubitState>(
            builder: (context, state) {
          if (state is MedicationReminderState)
            return TemplateFormPage(
                title: S.of(context).Medication_reminder,
                back: () => Navigator.pop(context),
                content: buildContent(context, state));
          else
            return LoadingPage();
        }));
  }

  Widget buildContent(BuildContext context, MedicationReminderState state) {
    DateTime now = DateTime.now();
    bool isToday = state.time.year == now.year &&
        state.time.month == now.month &&
        state.time.day == now.day;
    return Column(children: [
      SizedBox(height: 8),
      NextPreviousBar(
          content: DateTimeLogic.todayFormat(context, state.time, "dd.MM.yyyy"),
          increase: () => BlocProvider.of<MedicationReminderCubit>(context)
              .loadMedicationReminder(DateTimeLogic.increaseDay(state.time)),
          decrease: () => BlocProvider.of<MedicationReminderCubit>(context)
              .loadMedicationReminder(DateTimeLogic.decreaseDay(state.time))),
      SizedBox(height: 24),
      if (state.reminder.length != 0)
        buildReminderArea(context, state, isToday),
      if (state.reminder.length == 0) Text(S.of(context).no_reminder),
      SizedBox(height: 24),
      CustomDivider.common(),
      SizedBox(height: 16),
      SectionComponent(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => AllReminderPage(superContext: context))),
          title: S.of(context).All_reminder,
          colorID: 2),
      SizedBox(height: 16),
      SectionComponent(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => AllPrescriptionPage(
                  dashboardContext: dashboardContext, superContext: context))),
          title: S.of(context).All_prescription,
          colorID: isToday ? 0 : 1),
    ]);
  }

  Column buildReminderArea(
      BuildContext context, MedicationReminderState state, bool isToday) {
    List<List<ReminderMask>> list = [];
    for (ReminderMask x in state.reminder) {
      if (list.length == 0 ||
          (x.time.hour * 60) + x.time.minute !=
              (list.last.last.time.hour * 60) + list.last.last.time.minute)
        list.add([x]);
      else
        list.last.add(x);
    }
    if (isToday) list.insert(0, []);
    return Column(
        children: list
            .map((hourGroup) =>
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  if (isToday) buildTimeLine(hourGroup, list),
                  if (hourGroup.length == 0)
                    Container(
                        height: 32,
                        alignment: Alignment.topLeft,
                        child: Text(DateFormat("dd.MM.yyyy").format(state.time),
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: AnthealthColors.black2))),
                  if (hourGroup.length != 0)
                    Expanded(
                        child: buildReminderList(
                            hourGroup, context, isToday, list)),
                  if (isToday) SizedBox(width: 12)
                ]))
            .toList());
  }

  Widget buildTimeLine(
      List<ReminderMask> hourGroup, List<List<ReminderMask>> list) {
    DateTime now = DateTime.now();
    return Row(children: [
      CustomDivider.timeLine(
          (hourGroup.length == 0)
              ? 32
              : 60 +
                  hourGroup.length * 60 -
                  ((list.indexOf(hourGroup) + 1 == list.length) ? 36 : 0),
          (list.indexOf(hourGroup) + 1 < list.length &&
              list[list.indexOf(hourGroup) + 1].first.time.isBefore(now)),
          (hourGroup.length == 0) ? false : hourGroup.first.time.isAfter(now),
          (hourGroup.length == 0)
              ? DateTime(0, 0, 0, 0, 0)
              : hourGroup.first.time,
          ((list.indexOf(hourGroup) + 1 == list.length)
              ? DateTime(0, 0, 0, 23, 59)
              : list[list.indexOf(hourGroup) + 1].first.time)),
      SizedBox(width: 12)
    ]);
  }

  Widget buildReminderList(List<ReminderMask> hourGroup, BuildContext context,
      bool isToday, List<List<ReminderMask>> list) {
    DateTime now = DateTime.now();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(DateFormat("HH:mm").format(hourGroup.first.time),
          style: Theme.of(context).textTheme.headline4!.copyWith(
              color: (!isToday ||
                      hourGroup.first.time.hour * 60 +
                              hourGroup.first.time.minute +
                              120 <
                          now.hour * 60 + now.minute)
                  ? null
                  : AnthealthColors.secondary1)),
      SizedBox(height: 12),
      ...hourGroup
          .map((reminder) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SectionComponent(
                  onTap: () => showInfo(reminder, context),
                  title: reminder.medicine.getName(),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  directionContent:
                      NumberLogic.handleDoubleFix0(reminder.quantity) +
                          " " +
                          MedicineLogic.getUnit(
                              context, reminder.medicine.getUnit()),
                  isDirection: false,
                  colorID: !isToday
                      ? 0
                      : ((hourGroup.first.time.hour * 60 +
                                  hourGroup.first.time.minute +
                                  120 <
                              now.hour * 60 + now.minute)
                          ? 3
                          : 1))))
          .toList(),
      SizedBox(height: 8),
      if (list.indexOf(hourGroup) < list.length - 1) CustomDivider.common(),
      if (list.indexOf(hourGroup) < list.length - 1) SizedBox(height: 16)
    ]);
  }

  void showInfo(ReminderMask reminder, BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            insetPadding: EdgeInsets.symmetric(horizontal: 32),
            child: Container(
                height: 210,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AnthealthColors.primary1, width: 0.5)),
                          child: Avatar(
                              imagePath: reminder.medicine.getImagePath(),
                              size: 80)),
                      SizedBox(height: 8),
                      Text(reminder.medicine.getName(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline4),
                      SizedBox(height: 8),
                      Text(
                          DateFormat("HH:mm").format(reminder.time) +
                              " - " +
                              MedicineLogic.getUsage(
                                  context, reminder.medicine.getUsage()) +
                              " " +
                              MedicineLogic.handleQuantity(reminder.quantity) +
                              " " +
                              MedicineLogic.getUnit(
                                  context, reminder.medicine.getUnit()),
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: AnthealthColors.primary1))
                    ]))));
  }
}
