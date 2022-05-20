import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/user/doctor_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_dashboard_page.dart';
import 'package:anthealth_mobile/views/common_widgets/avatar.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/settings/doctor_setting_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorPage extends StatelessWidget {
  const DoctorPage(
      {Key? key, required this.dashboardContext, required this.doctorState})
      : super(key: key);

  final BuildContext dashboardContext;
  final DoctorState doctorState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: TemplateDashboardPage(
          title: S.of(context).Hi,
          name: doctorState.doctorUser.name,
          setting: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      DoctorSettingsPage(appContext: dashboardContext))),
          content: buildContent(context),
          endPadding: 32),
    ));
  }

  Widget buildContent(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CustomDivider.common(),
      SizedBox(height: 16),
      buildProfile(context),
      SizedBox(height: 32),
      CustomDivider.common(),
      SizedBox(height: 16),
      buildAppointment(context)
    ]);
  }

  Widget buildProfile(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CommonText.section(S.of(context).Your_doctor_profile, context),
      SizedBox(height: 16),
      Row(children: [
        Container(
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AnthealthColors.black2)),
            child:
                Avatar(imagePath: doctorState.doctorUser.avatarPath, size: 80)),
        SizedBox(width: 16),
        Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              Text(S.of(context).Dr + " " + doctorState.doctorUser.name,
                  style: Theme.of(context).textTheme.headline4),
              SizedBox(height: 4),
              Text(doctorState.doctorUser.highlight,
                  style: Theme.of(context).textTheme.bodyText1)
            ]))
      ]),
      SizedBox(height: 16),
      RichText(
        text: TextSpan(
            style: Theme.of(context).textTheme.bodyText1,
            children: <TextSpan>[
              TextSpan(
                  text: S.of(context).Phone_number + ": ",
                  style: Theme.of(context).textTheme.subtitle2),
              TextSpan(text: doctorState.doctorUser.phoneNumber + "\n"),
              TextSpan(text: " \n", style: TextStyle(fontSize: 6)),
              TextSpan(
                  text: S.of(context).Email + ": ",
                  style: Theme.of(context).textTheme.subtitle2),
              TextSpan(text: doctorState.doctorUser.email + "\n"),
              TextSpan(text: " \n", style: TextStyle(fontSize: 6)),
              TextSpan(
                  text: S.of(context).Doctor_description + ": \n",
                  style: Theme.of(context).textTheme.subtitle2),
              TextSpan(text: " \n", style: TextStyle(fontSize: 2)),
              TextSpan(text: doctorState.doctorUser.description),
            ]),
      )
    ]);
  }

  Widget buildAppointment(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CommonText.section(S.of(context).Appointment, context),
      SizedBox(height: 16),
      ...doctorState.appointments
          .map((appointment) => buildAppointmentComponent(context, appointment))
    ]);
  }

  Widget buildAppointmentComponent(
      BuildContext context, DoctorAppointment appointment) {
    return GestureDetector(
        onTap: () {},
        child: Container(
            decoration: BoxDecoration(
                color: AnthealthColors.primary5,
                borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: AnthealthColors.primary3)),
                        child: Avatar(
                            imagePath: appointment.patientImagePath, size: 32)),
                    SizedBox(width: 8),
                    Expanded(
                        child: Text(appointment.patientName,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: AnthealthColors.primary0)))
                  ]),
                  SizedBox(height: 8),
                  Text(appointment.content,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: AnthealthColors.primary1)),
                  SizedBox(height: 4),
                  Text(DateFormat("HH:mm dd.MM.yyyy").format(appointment.time),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: AnthealthColors.primary1)),
                  if (appointment.note != "")
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(appointment.note,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: AnthealthColors.primary1)),
                    ),
                ])));
  }
}
