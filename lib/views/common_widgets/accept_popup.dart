import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class AcceptPopup extends StatelessWidget {
  const AcceptPopup(
      {Key? key,
      required this.title,
      required this.reject,
      required this.accept})
      : super(key: key);

  final String title;
  final VoidCallback reject;
  final VoidCallback accept;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: AnthealthColors.primary1, height: 1.4)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              child: Text(S.of(context).btn_reject,
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: AnthealthColors.warning1)),
              onPressed: reject),
          Container(width: 1, height: 16, color: AnthealthColors.black3),
          TextButton(
              child: Text(S.of(context).btn_accept,
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: AnthealthColors.primary1)),
              onPressed: accept)
        ]);
  }
}
