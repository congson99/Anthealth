import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/community/all_communities_cubit.dart';
import 'package:anthealth_mobile/blocs/community/all_communities_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/community/community_models.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/community/community_description_page.dart';
import 'package:anthealth_mobile/views/community/community_post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCommunityPage extends StatelessWidget {
  const AllCommunityPage(
      {Key? key,
      required this.user,
      required this.dashboardContext,
      required this.state})
      : super(key: key);

  final User user;
  final BuildContext dashboardContext;
  final CommunityState state;

  @override
  Widget build(BuildContext context) => BlocProvider<AllCommunitiesCubit>(
      create: (context) => AllCommunitiesCubit(),
      child: BlocBuilder<AllCommunitiesCubit, CubitState>(
          builder: (context, state) {
        if (state is AllCommunitiesState)
          return TemplateFormPage(
              title: S.of(context).All_communities,
              back: () => back(context),
              content: buildContent(context, state));
        else
          return LoadingPage();
      }));

  // Content
  Widget buildContent(BuildContext context, AllCommunitiesState state) {
    return Column(
        children: state.allCommunities
            .map((group) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                          onTap: () =>
                              BlocProvider.of<AllCommunitiesCubit>(context)
                                  .updateOpening(state,
                                      state.allCommunities.indexOf(group)),
                          child: Container(
                              height: 40,
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
                                community, context, group.groupName != ""))
                            .toList(),
                      CustomDivider.common()
                    ]))
            .toList());
  }

  // Child Component
  Widget buildCommunityLabel(
      CommunityData community, BuildContext context, bool showJoin) {
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
            padding: const EdgeInsets.only(left: 16),
            child: Column(children: [
              CustomDivider.common(),
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

  // Actions
  void back(BuildContext context) {
    Navigator.of(context).pop();
  }

  void outCommunity(BuildContext context, CommunityData community) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    BlocProvider.of<DashboardCubit>(dashboardContext)
        .outCommunity(community.id)
        .then((result) {
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(S.of(context).Out_community +
                ' ' +
                S.of(context).successfully +
                '!')));
        BlocProvider.of<AllCommunitiesCubit>(context).loadData();
      }
    });
  }

  void joinCommunity(BuildContext context, CommunityData community) {
    BlocProvider.of<DashboardCubit>(dashboardContext)
        .joinCommunity(community.id)
        .then((result) {
      if (result) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(S.of(context).Join_community +
                ' ' +
                S.of(context).successfully +
                '!')));
        BlocProvider.of<AllCommunitiesCubit>(context).loadData();
        CommunityData newData = community;
        newData.join = true;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => CommunityPostPage(
                user: user,
                community: newData,
                outCommunity: () => outCommunity(context, community))));
      }
    });
  }
}
