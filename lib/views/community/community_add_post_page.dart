import 'dart:io';

import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/community/community_models.dart';
import 'package:anthealth_mobile/models/community/post_models.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/attach_bottom_sheet.dart';
import 'package:anthealth_mobile/views/common_widgets/attach_component.dart';
import 'package:anthealth_mobile/views/common_widgets/avatar.dart';
import 'package:anthealth_mobile/views/common_widgets/common_button.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CommunityAddPostPage extends StatefulWidget {
  const CommunityAddPostPage(
      {Key? key,
      required this.superContext,
      required this.user,
      this.community,
      required this.result})
      : super(key: key);

  final BuildContext superContext;
  final User user;
  final CommunityData? community;
  final Function(Post) result;

  @override
  State<CommunityAddPostPage> createState() => _CommunityAddPostPageState();
}

class _CommunityAddPostPageState extends State<CommunityAddPostPage> {
  Post post = Post(
      "", PostAuthor("", "", "", DateTime.now()), [], [], false, "", [], "");
  File? image;

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: S.of(context).New_post,
        back: () => Navigator.of(context).pop(),
        content: buildContent(context));
  }

  Widget buildContent(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      buildLabel(context),
      buildContentFillBox(context),
      buildAttach(context),
      buildButton(context)
    ]);
  }

  Widget buildLabel(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Avatar(imagePath: widget.user.avatarPath, size: 40),
        SizedBox(width: 8),
        Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              Text(widget.user.name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: AnthealthColors.black0)),
              Text(
                  S.of(context).Post_to +
                      " " +
                      ((widget.community != null)
                          ? widget.community!.name
                          : S.of(context).Family_sharing_space),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: AnthealthColors.black2))
            ]))
      ])),
      SizedBox(width: 8),
      CommonButton.small(
          context,
          () => widget.result(Post(
              "",
              PostAuthor(widget.user.id, widget.user.name,
                  widget.user.avatarPath, DateTime.now()),
              [],
              [],
              false,
              post.content,
              post.attach,
              "")),
          S.of(context).Post,
          AnthealthColors.secondary1,
          imagePath: "assets/app_icon/common/post_white.png")
    ]);
  }

  Widget buildContentFillBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: CommonTextField.box(
          context: context,
          hintText: S.of(context).Content,
          onChanged: (value) => setState(() => post.content = value)),
    );
  }

  Widget buildAttach(BuildContext context) {
    return Column(children: [
      ...post.attach.map((attach) => Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(children: [
            GestureDetector(
                onTap: () => setState(
                    () => post.attach.removeAt(post.attach.indexOf(attach))),
                child: Image.asset(
                  "assets/app_icon/common/delete_war1.png",
                  height: 24,
                  width: 24,
                  fit: BoxFit.contain,
                )),
            SizedBox(width: 8),
            Expanded(child: AttachComponent(attach: attach))
          ]))),
      if (image != null)
        Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(children: [
              GestureDetector(
                  onTap: () => setState(() => image = null),
                  child: Image.asset(
                    "assets/app_icon/common/delete_war1.png",
                    height: 24,
                    width: 24,
                    fit: BoxFit.contain,
                  )),
              SizedBox(width: 8),
              Image.file(image!,
                  width: MediaQuery.of(context).size.width * 0.5,
                  fit: BoxFit.cover),
              Expanded(child: Container())
            ]))
    ]);
  }

  Widget buildButton(BuildContext context) {
    return Column(children: [
      SizedBox(height: 32),
      CustomDivider.common(),
      if (image == null)
        Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SectionComponent(
                onTap: () => onAddPhotoTap(),
                title: S.of(context).Add_photo,
                colorID: 0,
                isDirection: false,
                iconPath: "assets/app_icon/small_icons/add_photo_pri1.png")),
      SizedBox(height: 16),
      SectionComponent(
          onTap: () => addAttach(),
          title: S.of(context).Attach,
          colorID: 1,
          isDirection: false,
          iconPath: "assets/app_icon/common/attach_sec1.png")
    ]);
  }

  /// Actions
  Future<dynamic> addAttach() async {
    FocusScope.of(context).unfocus();
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => AttachBottomSheet(
            medicalRecord: true,
            family: true,
            result: (attach) {
              Navigator.pop(context);
              if (attach.type >= 1 && attach.type <= 10)
                setState(() => post.attach.add(Attach(
                    widget.user.id,
                    widget.user.name,
                    (attach.ownerAvatar != "")
                        ? attach.ownerAvatar
                        : widget.user.avatarPath,
                    attach.type,
                    attach.dataID,
                    attach.dataDescription)));
              if (attach.type == 11) setState(() => post.attach.add(attach));
            }));
  }

  Future<dynamic> onAddPhotoTap() {
    FocusScope.of(context).unfocus();
    return showModalBottomSheet(
        context: context,
        builder: (_) => SafeArea(
            child: SizedBox(
                height: 150,
                child: Column(children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        pickImage(ImageSource.camera);
                      },
                      child: Container(
                          height: 64,
                          color: Colors.transparent,
                          padding: const EdgeInsets.all(16),
                          child: Row(children: [
                            Image.asset(
                                "assets/app_icon/small_icons/camera_bla2.png"),
                            SizedBox(width: 8),
                            Text(S.of(context).Pick_camera,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: AnthealthColors.black2))
                          ]))),
                  CustomDivider.common(),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        pickImage(ImageSource.gallery);
                      },
                      child: Container(
                          height: 64,
                          color: Colors.transparent,
                          padding: const EdgeInsets.all(16),
                          child: Row(children: [
                            Image.asset(
                                "assets/app_icon/small_icons/photo_bla2.png"),
                            SizedBox(width: 8),
                            Text(S.of(context).Pick_gallery,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: AnthealthColors.black2))
                          ])))
                ]))));
  }

  Future pickImage(ImageSource imageSource) async {
    try {
      final mImage = await ImagePicker().pickImage(source: imageSource);
      if (mImage == null) return;
      setState(() {
        image = File(mImage.path);
      });
    } on PlatformException catch (e) {
      print("Failed to pick Image: $e");
    }
  }
}
