import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class CommonText {
  static Widget section(String content, BuildContext context) {
    return Text(content,
        style: Theme.of(context)
            .textTheme
            .headline4!
            .copyWith(color: AnthealthColors.black1));
  }

  static Widget subSection(String content, BuildContext context) {
    return Text(content,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: AnthealthColors.black1));
  }
}
