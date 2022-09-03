import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:flutter/material.dart';

class SinglePost extends StatelessWidget {
  const SinglePost(
      {Key? key,
      required this.highlight,
      required this.title,
      required this.content})
      : super(key: key);

  final String highlight;
  final String title;
  final List<String> content;

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: highlight,
        back: () => Navigator.pop(context),
        content: buildContent(context));
  }

  Widget buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 8),
        Text(title, style: Theme.of(context).textTheme.headline2),
        SizedBox(height: 16),
        ...content.map((e) => buildElement(context, e)).toList()
      ],
    );
  }

  Widget buildElement(BuildContext context, String e) {
    if (Uri.tryParse(e)?.hasAbsolutePath ?? false) return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Image.network(e),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(e,
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.left),
    );
  }
}
