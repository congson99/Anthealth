import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class CommonText {
  static Widget section(String content, BuildContext context) => Text(content,
      style: Theme.of(context)
          .textTheme
          .headline4!
          .copyWith(color: AnthealthColors.black1));

  static Widget subSection(String content, BuildContext context) =>
      Text(content,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: AnthealthColors.black1));

  static TextStyle fillLabelTextStyle() =>
      TextStyle(fontSize: 16, letterSpacing: 1, fontFamily: 'RobotoMedium');

  static Widget tapTextImage(BuildContext context, String imagePath,
          String content, Color color) =>
      Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imagePath,
                width: 20, height: 20, fit: BoxFit.fitHeight),
            SizedBox(width: 2),
            Text(content,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    fontStyle: FontStyle.italic,
                    color: color))
          ]);
}
