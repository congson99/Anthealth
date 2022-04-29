import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/community/community_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/fill_popup.dart';
import 'package:anthealth_mobile/views/common_widgets/info_popup.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class CommunityDescriptionPage extends StatelessWidget {
  const CommunityDescriptionPage(
      {Key? key, required this.superContext, required this.community})
      : super(key: key);

  final BuildContext superContext;
  final CommunityData community;

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: S.of(context).Community_detail,
        back: () => back(context),
        content: buildContent(context));
  }

  // Content
  Widget buildContent(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(community.avatarPath,
                height: 120, width: 120, fit: BoxFit.cover)),
        SizedBox(width: 16),
        SizedBox(
            width: MediaQuery.of(context).size.width - 168,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(community.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.subtitle1),
                  SizedBox(height: 4),
                  Text(
                      community.members.toString() +
                          " " +
                          S.of(context).members,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2),
                  SizedBox(height: 8),
                  Row(children: [
                    if (community.join)
                      CommonButton.small(context, () {},
                          S.of(context).Out_community, AnthealthColors.primary1,
                          imagePath:
                              "assets/app_icon/small_icons/out_bla5.png"),
                    if (!community.join)
                      CommonButton.small(
                          context,
                          () {},
                          S.of(context).Join_community,
                          AnthealthColors.primary1,
                          imagePath: "assets/app_icon/small_icons/in_bla5.png"),
                    Expanded(child: Container())
                  ])
                ]))
      ]),
      SizedBox(height: 16),
      Text(community.description, style: Theme.of(context).textTheme.bodyText1),
      SizedBox(height: 8),
      InkWell(
          onTap: () => feedback(context),
          child: Text(S.of(context).Feedback_community,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: AnthealthColors.warning1)))
    ]);
  }

  // Actions
  void back(BuildContext context) {
    Navigator.of(context).pop();
  }

  void feedback(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => FillPopup(
            title: S.of(context).Feedback_community,
            fillBoxes: [S.of(context).Content],
            done: (result) {
              if (result[0] != "")
                showDialog(
                    context: context,
                    builder: (_) => InfoPopup(
                        title: S.of(context).Feedback_community_successful,
                        ok: () => Navigator.of(context).pop()));
            }));
  }
}
