import 'package:anthealth_mobile/views/common_widgets/custom_appbar_with_small_avatar.dart';
import 'package:flutter/material.dart';

class TemplateSmallAvatarFormPage extends StatelessWidget {
  const TemplateSmallAvatarFormPage(
      {Key? key,
      required this.name,
      required this.avatarPath,
      this.add,
      required this.content,
      this.padding})
      : super(key: key);

  final String name;
  final String avatarPath;
  final VoidCallback? add;
  final Widget content;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      Container(
          margin: const EdgeInsets.only(top: 57),
          child: SingleChildScrollView(
              child: Container(
                  padding: (padding == null)
                      ? EdgeInsets.only(
                          left: 16, right: 16, top: 16, bottom: 64)
                      : padding,
                  child: content))),
      CustomAppbarWithSmallAvatar(
          context: context, name: name, add: add, avatarPath: avatarPath)
    ])));
  }
}
