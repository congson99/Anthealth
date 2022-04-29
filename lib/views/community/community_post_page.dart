import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/community/community_post_page_cubit.dart';
import 'package:anthealth_mobile/blocs/community/community_post_page_state.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/community/community_models.dart';
import 'package:anthealth_mobile/models/community/post_models.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_small_avatar_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CommunityPostPage extends StatefulWidget {
  const CommunityPostPage(
      {Key? key, required this.dashboardContext, required this.community})
      : super(key: key);

  final BuildContext dashboardContext;
  final CommunityData community;

  @override
  State<CommunityPostPage> createState() => _CommunityPostPageState();
}

class _CommunityPostPageState extends State<CommunityPostPage> {
  List<Post> posts = [];
  ScrollController controller = ScrollController();

  @override
  void initState() {
    posts.addAll(BlocProvider.of<DashboardCubit>(widget.dashboardContext)
        .loadMorePost());
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        setState(() {
          posts.addAll(BlocProvider.of<DashboardCubit>(widget.dashboardContext)
              .loadMorePost());
        });
        print("Done");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocProvider<CommunitiesPostPageCubit>(
      create: (context) => CommunitiesPostPageCubit(widget.community.id),
      child: BlocBuilder<CommunitiesPostPageCubit, CubitState>(
          builder: (context, state) {
        if (state is CommunitiesPostPageState)
          return TemplateSmallAvatarFormPage(
              name: widget.community.name,
              avatarPath: widget.community.avatarPath,
              add: () {},
              padding: EdgeInsets.symmetric(horizontal: 16),
              content: buildContent(state));
        else
          return LoadingPage();
      }));

  // Content
  Widget buildContent(CommunitiesPostPageState state) {
    return Container(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top -
          MediaQuery.of(context).padding.top -
          47,
      child: ListView.builder(
          controller: controller,
          itemBuilder: (context, i) {
            if (i == posts.length)
              return Container(
                  height: 80,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            return Column(children: [
              SizedBox(height: 16),
              buildPost(i, context),
              SizedBox(height: 16),
              CustomDivider.common()
            ]);
          },
          itemCount: posts.length + 1),
    );
  }

  Widget buildPost(int i, BuildContext context) {
    return Column(children: [
      buildLabel(posts[i].owner, context),
      SizedBox(height: 16),
      Container(
          decoration: BoxDecoration(
              border: (posts[i].source == null)
                  ? null
                  : Border.all(width: 1, color: AnthealthColors.black3)),
          padding: (posts[i].source == null) ? null : EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            if (posts[i].source != null)
              Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: buildLabel(posts[i].source!, context)),
            Text("dsadn and as da snd a d a",
                style: Theme.of(context).textTheme.bodyText1)
          ])),
      SizedBox(height: 8),
      buildActionArea(i, context)
    ]);
  }

  Row buildLabel(PostAuthor author, BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Image.network(author.avatarPath,
              width: 40, height: 40, fit: BoxFit.cover)),
      SizedBox(width: 8),
      Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            Text(author.name,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AnthealthColors.black0)),
            Text(DateFormat("dd.MM").format(author.postTime),
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: AnthealthColors.black2))
          ]))
    ]);
  }

  SizedBox buildActionArea(int i, BuildContext context) {
    return SizedBox(
        height: 38,
        child: Row(children: [
          Image.asset("assets/app_icon/small_icons/unlike_bla1.png",
              height: 22, fit: BoxFit.fitHeight),
          SizedBox(width: 12),
          Image.asset("assets/app_icon/small_icons/comment_bla1.png",
              height: 22, fit: BoxFit.fitHeight),
          SizedBox(width: 12),
          Text(
              posts[i].like.length.toString() +
                  " " +
                  S.of(context).like +
                  " • ",
              style: Theme.of(context).textTheme.bodyText2),
          Expanded(
              child: Text(
                  posts[i].comment.length.toString() +
                      " " +
                      S.of(context).comment,
                  style: Theme.of(context).textTheme.bodyText2)),
          SizedBox(width: 12),
          Image.asset("assets/app_icon/common/share_sec1.png",
              height: 22, fit: BoxFit.fitHeight),
        ]));
  }
}
