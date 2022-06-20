import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/community/community_post_page_cubit.dart';
import 'package:anthealth_mobile/blocs/community/community_post_page_state.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/dateTime_logic.dart';
import 'package:anthealth_mobile/models/community/community_models.dart';
import 'package:anthealth_mobile/models/community/post_models.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_small_avatar_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/attach_component.dart';
import 'package:anthealth_mobile/views/common_widgets/avatar.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/community/community_pages/community_add_post_page.dart';
import 'package:anthealth_mobile/views/community/community_pages/community_description_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityPostPage extends StatelessWidget {
  const CommunityPostPage(
      {Key? key,
      required this.user,
      required this.community,
      this.outCommunity})
      : super(key: key);

  final User user;
  final CommunityData community;
  final VoidCallback? outCommunity;

  @override
  Widget build(BuildContext context) => BlocProvider<CommunitiesPostPageCubit>(
      create: (context) => CommunitiesPostPageCubit(community.id),
      child: BlocBuilder<CommunitiesPostPageCubit, CubitState>(
          builder: (context, state) {
        if (state is CommunitiesPostPageState) {
          if (outCommunity != null)
            return TemplateSmallAvatarFormPage(
                name: community.name,
                avatarPath: community.avatarPath,
                avatarTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CommunityDescriptionPage(
                        community: community, outCommunity: outCommunity!))),
                add: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CommunityAddPostPage(
                        superContext: context,
                        user: user,
                        community: community,
                        result: (result) {
                          Navigator.pop(context);
                          BlocProvider.of<CommunitiesPostPageCubit>(context)
                              .post(community.id, result)
                              .then((value) {
                            if (value)
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(S.of(context).Post_to +
                                          " " +
                                          community.name +
                                          " " +
                                          S.of(context).successfully +
                                          '!')));
                          });
                        }))),
                padding: EdgeInsets.symmetric(horizontal: 16),
                content: PostView(
                    communityID: community.id,
                    superContext: context,
                    pagePadding: MediaQuery.of(context).padding.top +
                        MediaQuery.of(context).padding.bottom,
                    state: state));
          else
            return TemplateFormPage(
                title: S.of(context).Family_sharing_space,
                back: () => Navigator.pop(context),
                add: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CommunityAddPostPage(
                        superContext: context,
                        user: user,
                        result: (result) {
                          Navigator.pop(context);
                          BlocProvider.of<CommunitiesPostPageCubit>(context)
                              .post(community.id, result)
                              .then((value) {
                            if (value)
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(S.of(context).Post_to +
                                          " " +
                                          S.of(context).Family_sharing_space +
                                          " " +
                                          S.of(context).successfully +
                                          '!')));
                          });
                        }))),
                padding: EdgeInsets.symmetric(horizontal: 16),
                content: PostView(
                    communityID: community.id,
                    superContext: context,
                    pagePadding: MediaQuery.of(context).padding.top +
                        MediaQuery.of(context).padding.bottom,
                    state: state));
        } else
          return LoadingPage();
      }));
}

class PostView extends StatefulWidget {
  const PostView(
      {Key? key,
      required this.communityID,
      required this.superContext,
      required this.pagePadding,
      required this.state})
      : super(key: key);

  final String communityID;
  final BuildContext superContext;
  final double pagePadding;
  final CommunitiesPostPageState state;

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  List<Post> posts = [];
  ScrollController controller = ScrollController();
  bool loadedAll = false;

  @override
  void initState() {
    posts.addAll(widget.state.allPost);
    posts.addAll(BlocProvider.of<CommunitiesPostPageCubit>(widget.superContext)
        .loadMorePost(widget.communityID));
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent &&
          !loadedAll) {
        setState(() {
          List<Post> newPosts =
              BlocProvider.of<CommunitiesPostPageCubit>(widget.superContext)
                  .loadMorePost(widget.communityID,
                      (posts.length > 0) ? posts.last.id : null);
          if (newPosts.length > 0)
            posts.addAll(newPosts);
          else
            loadedAll = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildContent();
  }

  // Content
  Widget buildContent() {
    return Container(
        height: MediaQuery.of(context).size.height - widget.pagePadding - 57,
        child: ListView.builder(
            controller: controller,
            itemBuilder: (context, i) {
              if (i == posts.length) {
                if (!loadedAll)
                  return Container(
                      height: 80,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());
                else
                  return Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      child: Text(S.of(context).read_all_posts,
                          style: Theme.of(context).textTheme.bodyText1));
              }
              return Column(children: [
                SizedBox(height: 16),
                buildPost(posts[i], context),
                SizedBox(height: 16),
                CustomDivider.common()
              ]);
            },
            itemCount: posts.length + 1));
  }

  Widget buildPost(Post post, BuildContext context) {
    return Column(children: [
      buildLabel(post.owner, context),
      SizedBox(height: 16),
      Container(
          decoration: BoxDecoration(
              border: (post.source == null)
                  ? null
                  : Border.all(width: 1, color: AnthealthColors.black3)),
          padding: (post.source == null)
              ? null
              : EdgeInsets.only(left: 16, right: 16, top: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            if (post.source != null)
              Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: buildLabel(post.source!, context)),
            if (post.content != "")
              Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(post.content,
                      style: Theme.of(context).textTheme.bodyText1)),
            buildAttach(post)
          ])),
      if (post.source != null) SizedBox(height: 12),
      buildActionArea(post, context)
    ]);
  }

  Widget buildLabel(PostAuthor author, BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Avatar(imagePath: author.avatarPath, size: 40),
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
            Text(DateTimeLogic.formatPastDateTime(context, author.postTime),
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: AnthealthColors.black2))
          ]))
    ]);
  }

  Widget buildAttach(Post post) {
    return Column(children: [
      ...post.attach.map((attach) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AttachComponent(attach: attach)))
    ]);
  }

  Widget buildActionArea(Post post, BuildContext context) {
    return SizedBox(
        height: 38,
        child: Row(children: [
          GestureDetector(
              onTap: () =>
                  BlocProvider.of<CommunitiesPostPageCubit>(widget.superContext)
                      .likePost(widget.communityID, post.id)
                      .then((result) {
                    if (result) setState(() => post.isLike = !post.isLike);
                  }),
              child: Image.asset(
                  post.isLike
                      ? "assets/app_icon/small_icons/like_war1.png"
                      : "assets/app_icon/small_icons/unlike_bla1.png",
                  height: 22,
                  fit: BoxFit.fitHeight)),
          SizedBox(width: 12),
          Image.asset("assets/app_icon/small_icons/comment_bla1.png",
              height: 22, fit: BoxFit.fitHeight),
          SizedBox(width: 12),
          Text(post.like.length.toString() + " " + S.of(context).like + " • ",
              style: Theme.of(context).textTheme.bodyText2),
          Expanded(
              child: Text(
                  post.comment.length.toString() + " " + S.of(context).comment,
                  style: Theme.of(context).textTheme.bodyText2)),
          SizedBox(width: 12),
          Image.asset("assets/app_icon/common/share_sec1.png",
              height: 22, fit: BoxFit.fitHeight)
        ]));
  }
}