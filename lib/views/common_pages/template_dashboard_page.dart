import 'package:anthealth_mobile/views/common_widgets/header.dart';
import 'package:flutter/material.dart';

class TemplateDashboardPage extends StatelessWidget {
  const TemplateDashboardPage(
      {Key? key,
      required this.title,
      required this.name,
      required this.setting,
      required this.content})
      : super(key: key);

  final String title;
  final String name;
  final VoidCallback setting;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Header(
                      title: title,
                      content: name,
                      isNotification: false,
                      isMessage: false,
                      onSettingsTap: setting),
                  content,
                  SizedBox(height: 124)
                ])));
  }
}
