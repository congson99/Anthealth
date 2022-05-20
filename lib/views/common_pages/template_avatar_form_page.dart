import 'package:anthealth_mobile/views/common_widgets/custom_appbar_with_avatar.dart';
import 'package:flutter/material.dart';

class TemplateAvatarFormPage extends StatelessWidget {
  const TemplateAvatarFormPage(
      {Key? key,
      required this.name,
      required this.avatarPath,
      this.firstTitle,
      this.secondTitle,
      this.favorite,
      this.add,
      required this.content,
      this.paddingHorizontal})
      : super(key: key);

  final String name;
  final String avatarPath;
  final String? firstTitle;
  final String? secondTitle;

  final bool? favorite;
  final VoidCallback? add;
  final Widget content;
  final bool? paddingHorizontal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      Container(
          margin: const EdgeInsets.only(top: 81),
          child: SingleChildScrollView(
              child: Container(
                  padding: (paddingHorizontal != false)
                      ? EdgeInsets.only(
                          left: 16, right: 16, top: 16, bottom: 32)
                      : EdgeInsets.only(top: 16, bottom: 64),
                  child: content))),
      CustomAppbarWithAvatar(
          context: context,
          name: name,
          firstTitle: firstTitle,
          secondTitle: secondTitle,
          favorite: favorite,
          avatarPath: avatarPath)
    ])));
  }
}
