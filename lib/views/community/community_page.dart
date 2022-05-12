import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/community/community_models.dart';
import 'package:anthealth_mobile/views/common_pages/error_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_dashboard_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/fill_popup.dart';
import 'package:anthealth_mobile/views/common_widgets/info_popup.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/community/all_community_page.dart';
import 'package:anthealth_mobile/views/community/community_description_page.dart';
import 'package:anthealth_mobile/views/community/community_post_page.dart';
import 'package:anthealth_mobile/views/settings/setting_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, CubitState>(builder: (context, state) {
      if (state is CommunityState)
        return TemplateDashboardPage(
            title: S.of(context).Welcome,
            name: name,
            setting: () => setting(context),
            content: buildContent(context, state));
      else
        return ErrorPage();
    });
  }

  // Content
  Widget buildContent(BuildContext context, CommunityState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CustomDivider.common(),
      SizedBox(height: 16),
      buildAllCommunity(context, state),
      SizedBox(height: 32),
      CustomDivider.common(),
      SizedBox(height: 16),
      buildYourCommunity(context, state),
    ]);
  }

  // Content Component
  Widget buildAllCommunity(BuildContext context, CommunityState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CommonText.section(S.of(context).Community, context),
      SizedBox(height: 16),
      SectionComponent(
          title: S.of(context).All_communities,
          colorID: 0,
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) =>
                  AllCommunityPage(dashboardContext: context, state: state)))),
      SizedBox(height: 16),
      SectionComponent(
          title: S.of(context).Recommend_community,
          colorID: 1,
          onTap: () => newCommunityTap(context))
    ]);
  }

  Widget buildYourCommunity(BuildContext context, CommunityState state) {
    return Column(children: [
      Row(children: [
        Expanded(
            child: CommonText.section(S.of(context).Your_communities, context)),
        Text(
            state.yourCommunity.length.toString() +
                " " +
                S.of(context).communities,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: AnthealthColors.primary1))
      ]),
      SizedBox(height: 8),
      ...state.yourCommunity
          .map((community) => buildCommunityLabel(community, context))
          .toList()
    ]);
  }

  // Child Component
  Widget buildCommunityLabel(CommunityData community, BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => CommunityPostPage(
              dashboardContext: context,
              community: community,
              outCommunity: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                BlocProvider.of<DashboardCubit>(context)
                    .outCommunity(community.id)
                    .then((result) {
                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(S.of(context).Out_community +
                            ' ' +
                            S.of(context).successfully +
                            '!')));
                  }
                });
              }))),
      child: Container(
          height: 82,
          color: Colors.transparent,
          child: Column(children: [
            Expanded(
                child: Row(children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(community.avatarPath,
                      height: 56, width: 56, fit: BoxFit.cover)),
              SizedBox(width: 12),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(community.name,
                        style: Theme.of(context).textTheme.subtitle1),
                    SizedBox(height: 4),
                    Text(
                        community.members.toString() +
                            " " +
                            S.of(context).members,
                        style: Theme.of(context).textTheme.bodyText2)
                  ])
            ])),
            CustomDivider.common()
          ])),
    );
  }

  // Actions
  void setting(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => SettingsPage(appContext: context)));
  }

  void newCommunityTap(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => FillPopup(
            title: S.of(context).Recommend_community,
            fillBoxes: [
              S.of(context).Community_name,
              S.of(context).Community_description
            ],
            done: (result) {
              if (result[0] != "")
                showDialog(
                    context: context,
                    builder: (_) => InfoPopup(
                        title: S.of(context).Recommend_community_successful,
                        ok: () => Navigator.of(context).pop()));
            }));
  }
}
