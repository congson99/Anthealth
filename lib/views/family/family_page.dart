import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/views/common_pages/error_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_dashboard_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/family/family_member_page.dart';
import 'package:anthealth_mobile/views/settings/setting_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FamilyPage extends StatelessWidget {
  const FamilyPage({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, CubitState>(builder: (context, state) {
      if (state is FamilyState)
        return TemplateDashboardPage(
            title: S.of(context).Family_of,
            name: name,
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
        SectionComponent(title: S.of(context).Family_sharing_space, colorID: 0),
        SizedBox(height: 16),
        SectionComponent(title: S.of(context).Family_group_chat, colorID: 1)
      ])
    ]);
  }

  // Content Component
  Column buildMembers(BuildContext context, FamilyState state) {
    final double width = MediaQuery.of(context).size.width - 32;
    final int count = width ~/ 90;
    final double size = (width - (count - 1) * 16) / count;
    return Column(children: [
      Row(children: [
        Expanded(child: CommonText.section(S.of(context).Member, context)),
        Text(state.members.length.toString() + " " + S.of(context).members,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: AnthealthColors.primary1))
      ]),
      SizedBox(height: 24),
      Wrap(
          runSpacing: 16,
          spacing: 16,
          children: state.members
                  .map((member) => buildMemberComponent(context, member, size))
                  .toList() +
              [buildAddMemberComponent(size, context)])
    ]);
  }

  // Child Component
  Widget buildMemberComponent(
      BuildContext context, FamilyMemberLabelData member, double size) {
    return GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => FamilyMemberPage(isAdmin: true, id: member.id))),
        child: Container(
            width: size,
            child: Column(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(size),
                child: Image.network(member.avatarPath,
                    width: size * 0.7, height: size * 0.7, fit: BoxFit.cover),
              ),
              SizedBox(height: 8),
              Text(member.name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption)
            ])));
  }

  Widget buildAddMemberComponent(double size, BuildContext context) {
    return GestureDetector(
        onTap: () {},
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
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => SettingsPage(appContext: context)));
  }
}
