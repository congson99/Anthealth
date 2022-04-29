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

  static Widget small(BuildContext context, VoidCallback onTap, String content,
      Color backgroundColor,
      {String? imagePath}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Row(
              children: [
                if (imagePath != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Image.asset(imagePath, height: 16, fit: BoxFit.fitHeight),
                  ),
                Text(content,
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Colors.white)),
              ],
            )));
  }

  static Widget photo(BuildContext context, VoidCallback onTap, String content,
      String imagePath, Color backgroundColor) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Row(
              children: [
                Image.asset(imagePath, height: 16, fit: BoxFit.fitHeight),
                SizedBox(width: 8),
                Text(content,
                    style: Theme.of(context).textTheme.button!.copyWith(
                        color: Colors.white, fontSize: 14, letterSpacing: 1)),
              ],
            )));
  }

  static Widget checkBox(
      {required bool value,
      required ValueChanged<bool?> onChanged,
      double? scale = 1}) {
    return Transform.scale(
        scale: scale,
        child: Checkbox(
          checkColor: Colors.white,
          value: value,
          onChanged: (value) => onChanged(value),
        ));
  }
}
