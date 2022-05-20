import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/user/doctor_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/avatar.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/fill_popup.dart';
import 'package:anthealth_mobile/views/common_widgets/info_popup.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/user/doctor_profile_page.dart';
import 'package:flutter/material.dart';

class DoctorConnectionPage extends StatefulWidget {
  const DoctorConnectionPage(
      {Key? key, required this.dashboardContext, required this.doctorGroup})
      : super(key: key);

  final BuildContext dashboardContext;
  final List<DoctorGroup> doctorGroup;

  @override
  State<DoctorConnectionPage> createState() => _DoctorConnectionPageState();
}

class _DoctorConnectionPageState extends State<DoctorConnectionPage> {
  List<DoctorGroup> doctorGroup = [];

  @override
  void initState() {
    super.initState();
    doctorGroup.addAll(widget.doctorGroup);
  }

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: S.of(context).Connect_doctor,
        back: () => Navigator.pop(context),
        content: buildContent(context));
  }

  Widget buildContent(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      buildCommunities(context),
      SizedBox(height: 16),
      SectionComponent(
          iconPath: "assets/app_icon/common/report_war0.png",
          title: S.of(context).Report,
          isDirection: false,
          colorID: 2,
          onTap: () => report(context))
    ]);
  }

  /// Main Component
  Widget buildCommunities(BuildContext context) {
    return Column(
        children: doctorGroup
            .map((group) => (group.doctors.length == 0)
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                        if (group.isOpening) SizedBox(height: 12),
                        GestureDetector(
                            onTap: () => setState(() {
                                  for (DoctorGroup x in doctorGroup) {
                                    if (doctorGroup[doctorGroup.indexOf(x)] ==
                                        doctorGroup[doctorGroup.indexOf(group)])
                                      x.isOpening = !x.isOpening;
                                    else
                                      x.isOpening = false;
                                  }
                                }),
                            child: Container(
                                height: group.isOpening ? 24 : 48,
                                color: Colors.transparent,
                                child: Row(children: [
                                  Expanded(
                                      child: Text(
                                          (group.name == "")
                                              ? S.of(context).Favorite_doctor
                                              : group.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1)),
                                  Image.asset(
                                      group.isOpening
                                          ? "assets/app_icon/direction/down_bla2.png"
                                          : "assets/app_icon/direction/right_bla2.png",
                                      height: 16,
                                      width: 16)
                                ]))),
                        if (group.isOpening)
                          ...group.doctors
                              .map((doctor) => buildDoctorLabel(doctor, context,
                                  group.doctors.indexOf(doctor) == 0))
                              .toList(),
                        if (group.isOpening) SizedBox(height: 8),
                        if (doctorGroup.indexOf(group) !=
                            doctorGroup.length - 1)
                          CustomDivider.common()
                      ]))
            .toList());
  }

  /// Sub Component
  Widget buildDoctorLabel(Doctor doctor, BuildContext context, bool isFirst) {
    return GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => DoctorProfilePage(doctor: doctor))),
        child: Container(
            height: 82,
            color: Colors.transparent,
            child: Column(children: [
              if (!isFirst) CustomDivider.common(),
              Expanded(
                  child: Row(children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: AnthealthColors.black3)),
                    child: Avatar(imagePath: doctor.avatarPath, size: 48)),
                SizedBox(width: 12),
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(S.of(context).Dr + " " + doctor.name,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1),
                      SizedBox(height: 4),
                      Text(doctor.highlight.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText2)
                    ]))
              ])),
            ])));
  }

  void report(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => FillPopup(
            title: S.of(context).Report,
            fillBoxes: [S.of(context).Issues, S.of(context).Detail],
            done: (result) {
              if (result[0] != "")
                showDialog(
                    context: context,
                    builder: (_) => InfoPopup(
                        title: S.of(context).Report_successful,
                        ok: () => Navigator.of(context).pop()));
            }));
  }
}
