import 'dart:convert';

import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/health/indicator_models.dart';
import 'package:anthealth_mobile/models/post/post_models.dart';
import 'package:anthealth_mobile/views/post/post_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IndicatorMoreInfo extends StatelessWidget {
  const IndicatorMoreInfo({Key? key, required this.information})
      : super(key: key);

  final MoreInfo information;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 32),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('* ',
              style: Theme.of(context).textTheme.overline!.copyWith(
                  color: AnthealthColors.black1, fontFamily: 'RobotoRegular')),
          Expanded(
              child: RichText(
                  text: TextSpan(
                      text: information.getContent(),
                      style: Theme.of(context).textTheme.overline!.copyWith(
                          color: AnthealthColors.black1,
                          fontFamily: 'RobotoRegular',
                          letterSpacing: 0.2),
                      children: [
                if (information.file != "")
                  TextSpan(
                      text: ' ' + S.of(context).Learn_more,
                      style: TextStyle(
                          color: AnthealthColors.primary1,
                          fontFamily: 'RobotoMedium'),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () async {
                          var jsonText = await rootBundle.loadString(
                              information.file ??
                                  "assets/hardData/template.json");
                          Map<String, dynamic> data = json.decode(jsonText);
                          List<String> content = [];
                          for (String x in data["content"]) {
                            content.add(x);
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PostPage(
                                        post: Post.generate(
                                            postKey: data["postKey"],
                                            title: data["title"],
                                            content: content),
                                      )));
                        })
              ])))
        ]));
  }
}
