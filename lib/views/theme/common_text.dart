import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonText {
  CommonText._();

  static Widget section(String content, BuildContext context) {
    return Text(content,
        style: Theme.of(context)
            .textTheme
            .headline4!
            .copyWith(color: AnthealthColors.black1));
  }
}
