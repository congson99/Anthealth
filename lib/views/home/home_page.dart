import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/medicine_logic.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/models/medic/medication_reminder_models.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/views/common_pages/error_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_dashboard_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/post_component.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/medic/medical_record/medical_record_page.dart';
import 'package:anthealth_mobile/views/medic/medication_reminder/medication_reminder_page.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.user, required this.review})
      : super(key: key);

  final User user;
  final bool review;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<DashboardCubit, CubitState>(builder: (context, state) {
        if (state is HomeState)
          return TemplateDashboardPage(
              title: S.of(context).Hi,
              name: user.name,
              content: buildContent(context, state));
        return ErrorPage();
      });

  Widget buildContent(BuildContext context, HomeState state) {
    return Column(children: [
      CustomDivider.common(),
      SizedBox(height: 16),
      buildUpcoming(context, state),
      if (review)
        Column(
          children: [
            SizedBox(height: 16),
            CustomDivider.common(),
            SizedBox(height: 16),
            buildPost(context, state),
          ],
        )
    ]);
  }

  Widget buildPost(BuildContext context, HomeState state) {
    if (state.posts.length == 0) return Container();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CommonText.section(S.of(context).Highlights, context),
      SizedBox(height: 16),
      ...state.posts.map((post) => Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: PostComponent(post: post),
          ))
    ]);
  }

  Widget buildUpcoming(BuildContext context, HomeState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CommonText.section(S.of(context).Upcoming_events, context),
      SizedBox(height: 16),
      ...state.events.map((event) => buildEvent(context, event))
    ]);
  }

  Widget buildEvent(BuildContext context, dynamic event) {
    if (event.runtimeType == MedicalAppointment)
      return buildEventComponent(context, medicalAppointment: event);
    else
      return buildEventComponent(context, reminderMask: event);
  }

  Widget buildEventComponent(BuildContext context,
      {MedicalAppointment? medicalAppointment, ReminderMask? reminderMask}) {
    DateTime nowDay =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    if (medicalAppointment != null) {
      int long = DateTime(
              medicalAppointment.dateTime.year,
              medicalAppointment.dateTime.month,
              medicalAppointment.dateTime.day)
          .difference(nowDay)
          .inDays;
      return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SectionComponent(
              title: S.of(context).Medical_appointment +
                  ((long == 0)
                      ? " (" + S.of(context).Today + ")"
                      : ((long == 1)
                          ? " (" + S.of(context).Tomorrow + ")"
                          : "")),
              subTitle: S.of(context).Content + ": " + medicalAppointment.name,
              subSubTitle:
                  DateFormat("dd.MM.yyyy").format(medicalAppointment.dateTime) +
                      ' - ' +
                      medicalAppointment.location,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) =>
                        MedicalRecordPage(dashboardContext: context)));
              },
              isDirection: false,
              colorID: 1));
    } else {
      int long = DateTime(reminderMask!.time.year, reminderMask.time.month,
              reminderMask.time.day)
          .difference(nowDay)
          .inDays;
      return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SectionComponent(
              title: S.of(context).Medication_reminder +
                  ((long == 0)
                      ? ""
                      : " (" +
                          ((long == 1)
                              ? S.of(context).Tomorrow
                              : DateFormat("dd.MM.yyyy")
                                  .format(reminderMask.time)) +
                          ")"),
              subTitle: DateFormat("HH:mm").format(reminderMask.time) +
                  " - " +
                  MedicineLogic.getUsage(
                      context, reminderMask.medicine.getUsage()) +
                  " " +
                  MedicineLogic.handleQuantity(reminderMask.quantity) +
                  " " +
                  MedicineLogic.getUnit(
                      context, reminderMask.medicine.getUnit()) +
                  " " +
                  reminderMask.medicine.getName(),
              isDirection: false,
              colorID: 0,
              onTap: () {
                BlocProvider.of<DashboardCubit>(context).medic();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) =>
                        MedicationReminderPage(dashboardContext: context)));
              }));
    }
  }
}
