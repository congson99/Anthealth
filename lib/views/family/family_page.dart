import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/community/community_models.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/views/common_pages/error_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_dashboard_page.dart';
import 'package:anthealth_mobile/views/common_widgets/avatar.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/community/community_pages/community_post_page.dart';
import 'package:anthealth_mobile/views/family/family_member/family_member_page.dart';
import 'package:anthealth_mobile/views/family/widgets/add_family_member_popup.dart';
import 'package:anthealth_mobile/views/settings/setting_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FamilyPage extends StatelessWidget {
  const FamilyPage({Key? key, required this.user, required this.languageID})
      : super(key: key);

  final User user;
  final String languageID;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, CubitState>(builder: (context, state) {
      if (state is FamilyState)
        return TemplateDashboardPage(
            title: S.of(context).Family_of,
            name: user.name,
            setting: () => setting(context),
            content: buildContent(context, state));
      else
        return ErrorPage();
    });
  }

  // Content
  Widget buildContent(BuildContext context, FamilyState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CustomDivider.common(),
      SizedBox(height: 16),
      buildMembers(context, state),
      SizedBox(height: 32),
      CustomDivider.common(),
      SizedBox(height: 16),
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        CommonText.section(S.of(context).Family_sharing, context),
        SizedBox(height: 16),
        SectionComponent(
            onTap: () => BlocProvider.of<DashboardCubit>(context)
                    .getFamilyID(user.id)
                    .then((result) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => CommunityPostPage(
                          user: user,
                          community: CommunityData(
                              result, "", "", "", 0, false, []))));
                }),
            title: S.of(context).Family_sharing_space,
            colorID: 1,
            iconPath: "assets/app_icon/common/family_space_sec0.png"),
        SizedBox(height: 16),
        SectionComponent(
            title: S.of(context).Family_group_chat,
            colorID: 0,
            iconPath: "assets/app_icon/common/null_message_pri0.png")
      ])
    ]);
  }

  // Content Component
  Widget buildMembers(BuildContext context, FamilyState state) {
    final double width = MediaQuery.of(context).size.width - 32;
    final int count = width ~/ 90;
    final double size = (width - (count - 1) * 16) / count;
    bool isAdmin = false;
    for (FamilyMemberData x in state.members)
      if (x.id == user.id) isAdmin = x.admin;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [
        Expanded(child: CommonText.section(S.of(context).Member, context)),
        Text(state.members.length.toString() + " " + S.of(context).members,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: AnthealthColors.primary1))
      ]),
      SizedBox(height: 24),
      Wrap(runSpacing: 16, spacing: 16, children: [
        ...state.members
            .map((member) =>
                buildMemberComponent(context, member, isAdmin, size))
            .toList(),
        if (isAdmin) buildAddMemberComponent(size, context)
      ])
    ]);
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

  Widget buildAddMemberComponent(double size, BuildContext context) {
    return GestureDetector(
        onTap: () => newMemberTap(context),
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

  // Actions
  void setting(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SettingsPage(
            appContext: context, languageID: languageID, user: user)));
  }

  void onFamilyMemberTap(
      BuildContext context, FamilyMemberData member, bool isAdmin) {
    if (member.id != user.id)
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => FamilyMemberPage(
              dashboardContext: context,
              member: member,
              isAdmin: isAdmin,
              grantAdmin: () {
                BlocProvider.of<DashboardCubit>(context)
                    .grantFamilyAdmin(user.id)
                    .then((result) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(S.of(context).Grant_admin_rights +
                          ' ' +
                          S.of(context).successfully +
                          '!')));
                  BlocProvider.of<DashboardCubit>(context).family();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  FamilyMemberData newData = member;
                  newData.admin = true;
                  onFamilyMemberTap(context, newData, false);
                });
              },
              remove: () {
                BlocProvider.of<DashboardCubit>(context)
                    .removeFamilyMember(user.id)
                    .then((result) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(S.of(context).Remove_family_member +
                          ' ' +
                          S.of(context).successfully +
                          '!')));
                  BlocProvider.of<DashboardCubit>(context).family();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                });
              })));
  }

  void newMemberTap(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AddFamilyMemberPopup(
            dashboardContext: context,
            done: (result) {
              Navigator.of(context).pop();
              BlocProvider.of<DashboardCubit>(context).family();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(S.of(context).Add_member +
                      ' ' +
                      S.of(context).successfully +
                      '!')));
            }));
  }
}
