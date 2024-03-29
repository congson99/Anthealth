import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class YesNoPopup extends StatelessWidget {
  const YesNoPopup(
      {Key? key, required this.title, required this.no, required this.yes})
      : super(key: key);

  final String title;
  final VoidCallback no;
  final VoidCallback yes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: AnthealthColors.warning2, height: 1.4)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              child: Text(S.of(context).button_no,
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: AnthealthColors.warning1)),
              onPressed: no),
          Container(width: 1, height: 16, color: AnthealthColors.black3),
          TextButton(
              child: Text(S.of(context).button_yes,
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: AnthealthColors.primary1)),
              onPressed: yes)
        ]);
  }
}
