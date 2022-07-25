import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/community/community_models.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/views/common_pages/error_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_dashboard_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/fill_popup.dart';
import 'package:anthealth_mobile/views/common_widgets/info_popup.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/community/community_pages/community_description_page.dart';
import 'package:anthealth_mobile/views/community/community_pages/community_post_page.dart';
import 'package:anthealth_mobile/views/settings/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({Key? key, required this.user})
      : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, CubitState>(builder: (context, state) {
      if (state is CommunityState)
        return TemplateDashboardPage(
            title: S.of(context).Welcome,
            name: user.name,
            setting: () => setting(context),
            content: buildContent(context, state));
      else
        return ErrorPage();
    });
  }

  Widget buildContent(BuildContext context, CommunityState state) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CustomDivider.common(),
      buildCommunities(context, state),
      SizedBox(height: 16),
      SectionComponent(
          iconPath: "assets/app_icon/common/idea_sec0.png",
          title: S.of(context).Recommend_community,
          isDirection: false,
          colorID: 1,
          onTap: () => newCommunityTap(context))
    ]);
  }

  /// Main Component
  Widget buildCommunities(BuildContext context, CommunityState state) {
    return Column(
        children: state.communities
            .map((group) => (group.listCommunity.length == 0)
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                        if (group.isOpening) SizedBox(height: 12),
                        GestureDetector(
                            onTap: () =>
                                BlocProvider.of<DashboardCubit>(context)
                                    .updateCommunityGroupOpening(state,
                                        state.communities.indexOf(group)),
                            child: Container(
                                height: group.isOpening ? 24 : 48,
                                color: Colors.transparent,
                                child: Row(children: [
                                  Expanded(
                                      child: Text(
                                          (group.groupName == "")
                                              ? S.of(context).Your_communities
                                              : group.groupName,
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
                          ...group.listCommunity
                              .map((community) => buildCommunityLabel(
                                  community,
                                  context,
                                  group.groupName != "",
                                  group.listCommunity.indexOf(community) == 0))
                              .toList(),
                        if (group.isOpening) SizedBox(height: 8),
                        if (state.communities.indexOf(group) !=
                            state.communities.length - 1)
                          CustomDivider.common()
                      ]))
            .toList());
  }

  /// Sub Component
  Widget buildCommunityLabel(CommunityData community, BuildContext context,
      bool showJoin, bool isFirst) {
    return GestureDetector(
        onTap: () {
          if (community.join) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => CommunityPostPage(
                    user: user,
                    community: community,
                    outCommunity: () => outCommunity(context, community))));
          } else
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => CommunityDescriptionPage(
                    community: community,
                    joinCommunity: () => joinCommunity(context, community))));
        },
        child: Container(
            height: 82,
            color: Colors.transparent,
            child: Column(children: [
              if (!isFirst) CustomDivider.common(),
              Expanded(
                  child: Row(children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(community.avatarPath,
                        height: 56, width: 56, fit: BoxFit.cover)),
                SizedBox(width: 12),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 116,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(community.name,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.subtitle1),
                          SizedBox(height: 4),
                          Text(
                              community.members.toString() +
                                  " " +
                                  S.of(context).members +
                                  ((showJoin && community.join)
                                      ? " • " + S.of(context).Joined
                                      : ""),
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText2)
                        ]))
              ]))
            ])));
  }

  /// Actions
  void setting(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SettingsPage(
            appContext: context, user: user)));
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

  void outCommunity(BuildContext context, CommunityData community) {
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
        BlocProvider.of<DashboardCubit>(context).community();
      }
    });
  }

  void joinCommunity(BuildContext context, CommunityData community) {
    BlocProvider.of<DashboardCubit>(context)
        .joinCommunity(community.id)
        .then((result) {
      if (result) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(S.of(context).Join_community +
                ' ' +
                S.of(context).successfully +
                '!')));
        BlocProvider.of<DashboardCubit>(context).community();
        CommunityData newData = community;
        newData.join = true;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => CommunityPostPage(
                user: user,
                community: newData,
                outCommunity: () => outCommunity(context, newData))));
      }
    });
  }
}
