import 'package:anthealth_mobile/models/post/post_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:flutter/material.dart';

class PostPage extends StatelessWidget {
  const PostPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: post.postKey,
        back: () => Navigator.pop(context),
        content: buildContent(context));
  }

  Widget buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 8),
        Text(post.title, style: Theme.of(context).textTheme.headline4),
        SizedBox(height: 16),
        ...post.content.map((e) => buildElement(context, e)).toList()
      ],
    );
  }

  Widget buildElement(BuildContext context, String e) {
    if (Uri.tryParse(e)?.hasAbsolutePath ?? false)
      return Padding(
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
