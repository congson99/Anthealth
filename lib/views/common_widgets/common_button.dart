import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class CommonButton {
  static Widget buildTemplate(BuildContext context, String content,
      Color backgroundColor, VoidCallback onTap) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(content,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: Colors.white, fontSize: 18))));
  }

  static Widget cancel(BuildContext context, VoidCallback onTap) {
    return buildTemplate(
        context, S.of(context).button_cancel, AnthealthColors.warning1, onTap);
  }

  static Widget ok(BuildContext context, VoidCallback onTap) {
    return buildTemplate(
        context, S.of(context).button_ok, AnthealthColors.primary1, onTap);
  }

  static Widget round(BuildContext context, VoidCallback onTap, String content,
      Color backgroundColor) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Text(content,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: Colors.white, fontSize: 18))));
  }
}
