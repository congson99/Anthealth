import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/models/notification/warning.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/views/common_pages/error_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_dashboard_page.dart';
import 'package:anthealth_mobile/views/common_widgets/accept_popup.dart';
import 'package:anthealth_mobile/views/common_widgets/avatar.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_snackbar.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/common_widgets/yes_no_popup.dart';
import 'package:anthealth_mobile/views/family/family_member/family_member_page.dart';
import 'package:anthealth_mobile/views/family/widgets/add_family_member_popup.dart';
import 'package:anthealth_mobile/views/health/indicator/blood_pressure_page.dart';
import 'package:anthealth_mobile/views/health/indicator/heart_rate_page.dart';
import 'package:anthealth_mobile/views/health/indicator/spo2_page.dart';
import 'package:anthealth_mobile/views/health/indicator/temperature_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FamilyPage extends StatelessWidget {
  const FamilyPage({Key? key, required this.user, required this.warning})
      : super(key: key);

  final User user;
  final List<Warning> warning;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, CubitState>(builder: (context, state) {
      if (state is FamilyState)
        return TemplateDashboardPage(
            title: S.of(context).Family_of,
            name: user.name,
            content: buildContent(context, state));
      else
        return ErrorPage();
    });
  }

  // Content
  Widget buildContent(BuildContext context, FamilyState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (warning.isNotEmpty) buildWarning(context),
      CustomDivider.common(),
      SizedBox(height: 24),
      if (state.members.isNotEmpty) buildMembers(context, state),
      if (state.members.isEmpty)
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...state.invitations.map((invitation) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SectionComponent(
                      onTap: () => invitationTap(
                          context,
                          invitation.inviter + S.of(context).invitation,
                          invitation.familyID),
                      title: invitation.inviter + S.of(context).invitation,
                      colorID: 1),
                )),
            Text(S.of(context).no_family_yet,
                style: Theme.of(context).textTheme.bodyText2),
            SizedBox(height: 16),
            SectionComponent(
                onTap: () => createFamily(context),
                title: S.of(context).create_a_family,
                colorID: 0,
                isDirection: false)
          ],
        )
    ]);
  }

  Widget buildWarning(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CustomDivider.common(),
      SizedBox(height: 16),
      CommonText.section(S.of(context).Warning, context),
      SizedBox(height: 16),
      ...warning.map((w) => buildGestureDetector(context, w)),
      SizedBox(height: 16),
    ]);
  }

  Widget buildGestureDetector(BuildContext context, Warning w) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        if (w.type == 2)
          return HeartRatePage(
            dashboardContext: context,
            mem: FamilyMemberData(
                w.uid,
                w.name,
                w.avatar,
                "",
                "",
                false,
                [
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                ],
                -1,
                -1),
            user: User("id", "name", "avatarPath", "phoneNumber", "email",
                false, -1, 0),
          );
        if (w.type == 3)
          return TemperaturePage(
            dashboardContext: context,
            mem: FamilyMemberData(
                w.uid,
                w.name,
                w.avatar,
                "",
                "",
                false,
                [
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                ],
                -1,
                -1),
            user: User("id", "name", "avatarPath", "phoneNumber", "email",
                false, -1, 0),
          );
        if (w.type == 4)
          return BloodPressurePage(
            dashboardContext: context,
            mem: FamilyMemberData(
                w.uid,
                w.name,
                w.avatar,
                "",
                "",
                false,
                [
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                ],
                -1,
                -1),
            user: User("id", "name", "avatarPath", "phoneNumber", "email",
                false, -1, 0),
          );
        return SPO2Page(
          dashboardContext: context,
          mem: FamilyMemberData(
              w.uid,
              w.name,
              w.avatar,
              "",
              "",
              false,
              [
                true,
                true,
                true,
                true,
                true,
                true,
                true,
                true,
                true,
              ],
              -1,
              -1),
          user: User(
              "id", "name", "avatarPath", "phoneNumber", "email", false, -1, 0),
        );
      })),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            color: AnthealthColors.warning4,
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AnthealthColors.warning0),
                  borderRadius: BorderRadius.circular(24)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.network(
                    (w.avatar == "")
                        ? "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"
                        : w.avatar,
                    height: 48.0,
                    width: 48.0,
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
                child: Text(
              w.notice,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: AnthealthColors.warning0),
            )),
            SizedBox(width: 8),
            Image.asset("assets/app_icon/direction/right_war1.png",
                height: 16.0, width: 16.0, fit: BoxFit.cover)
          ],
        ),
      ),
    );
  }

  // Content Component
  Widget buildMembers(BuildContext context, FamilyState state) {
    final double width = MediaQuery.of(context).size.width - 32;
    final int count = width ~/ 90;
    final double size = (width - (count - 1) * 16) / count;
    bool isAdmin = false;
    for (FamilyMemberData x in state.members)
      if (x.id == user.id) isAdmin = x.admin;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CommonText.section(S.of(context).Family_member, context),
        SizedBox(height: 16),
        Wrap(runSpacing: 16, spacing: 16, children: [
          ...state.members
              .map((member) =>
                  buildMemberComponent(context, member, isAdmin, size))
              .toList(),
          if (isAdmin) buildAddMemberComponent(size, context, state.members)
        ]),
      ],
    );
  }

  // Child Component
  Widget buildMemberComponent(BuildContext context, FamilyMemberData member,
      bool isAdmin, double size) {
    return GestureDetector(
        onTap: () => onFamilyMemberTap(context, member, isAdmin),
        child: Container(
            width: size,
            child: Column(children: [
              Avatar(imagePath: member.avatarPath, size: size * 0.7),
              SizedBox(height: 8),
              Text((member.id == user.id) ? S.of(context).You : member.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption),
              if (member.admin)
                Text(S.of(context).Admin,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .overline!
                        .copyWith(color: AnthealthColors.primary1))
            ])));
  }

  Widget buildAddMemberComponent(
      double size, BuildContext context, List<FamilyMemberData> members) {
    return GestureDetector(
        onTap: () => newMemberTap(context, members),
        child: Container(
            width: size,
            child: Column(children: [
              Container(
                width: size * 0.7,
                height: size * 0.7,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AnthealthColors.primary4,
                    borderRadius: BorderRadius.circular(size)),
                child: Image.asset(
                    "assets/app_icon/small_icons/add_member_pri1.png",
                    width: size * 0.3,
                    height: size * 0.3,
                    fit: BoxFit.cover),
              ),
              SizedBox(height: 8),
              Text("+" + S.of(context).Member,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: AnthealthColors.primary1))
            ])));
  }

  void onFamilyMemberTap(
      BuildContext context, FamilyMemberData member, bool isAdmin) {
    if (member.id != user.id)
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => FamilyMemberPage(
              dashboardContext: context, member: member, isAdmin: isAdmin)));
  }

  void newMemberTap(BuildContext context, List<FamilyMemberData> members) {
    showDialog(
        context: context,
        builder: (_) => AddFamilyMemberPopup(
            dashboardContext: context,
            done: (result) {
              Navigator.of(context).pop();
              for (FamilyMemberData mem in members)
                if (mem.email == result) {
                  ShowSnackBar.showErrorSnackBar(
                      context, S.of(context).member_joined);
                  return;
                }
              BlocProvider.of<DashboardCubit>(context)
                  .addMember(result)
                  .then((value) {
                if (value)
                  ShowSnackBar.showSuccessSnackBar(context,
                      "${S.of(context).invite} ${S.of(context).successfully}!");
              });
            }));
  }

  void createFamily(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => YesNoPopup(
            title: S.of(context).create_a_family,
            no: () => Navigator.pop(context),
            yes: () {
              BlocProvider.of<DashboardCubit>(context).createFamily();
              Navigator.pop(context);
            }));
  }

  void invitationTap(BuildContext context, String title, String id) {
    showDialog(
        context: context,
        builder: (_) => AcceptPopup(
            title: title,
            reject: () {
              Navigator.pop(context);
              BlocProvider.of<DashboardCubit>(context)
                  .handleInvitation(context, id, false);
            },
            accept: () {
              Navigator.pop(context);
              BlocProvider.of<DashboardCubit>(context)
                  .handleInvitation(context, id, true);
            }));
  }
}
