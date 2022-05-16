import 'package:anthealth_mobile/views/common_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class TemplateFormPage extends StatelessWidget {
  const TemplateFormPage(
      {Key? key,
      required this.title,
      required this.back,
      this.add,
      this.share,
      this.edit,
      this.delete,
      this.settings,
      this.padding,
      this.marginTop,
      required this.content})
      : super(key: key);

  final String title;
  final VoidCallback back;
  final VoidCallback? add;
  final VoidCallback? share;
  final VoidCallback? edit;
  final VoidCallback? delete;
  final VoidCallback? settings;
  final EdgeInsets? padding;
  final double? marginTop;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      Container(
          margin: EdgeInsets.only(top: marginTop ?? 57),
          child: SingleChildScrollView(
              child: Container(
                  padding: (padding == null)
                      ? EdgeInsets.only(
                          left: 16, right: 16, top: 16, bottom: 32)
                      : padding,
                  child: content))),
      CustomAppBar(
          title: title,
          back: back,
          add: add,
          share: share,
          edit: edit,
          delete: delete,
          settings: settings)
    ])));
  }
}
