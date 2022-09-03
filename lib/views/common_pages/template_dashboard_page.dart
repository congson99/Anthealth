import 'package:anthealth_mobile/views/common_widgets/header.dart';
import 'package:flutter/material.dart';

class TemplateDashboardPage extends StatelessWidget {
  const TemplateDashboardPage(
      {Key? key,
      required this.title,
      required this.name,
      required this.content,
      this.isHeader,
      this.endPadding})
      : super(key: key);

  final String title;
  final String name;
  final Widget content;
  final bool? isHeader;
  final double? endPadding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (isHeader != false) Header(title: title, content: name),
                  content,
                  SizedBox(height: endPadding ?? 124)
                ])));
  }
}
