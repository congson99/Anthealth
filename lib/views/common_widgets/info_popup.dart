import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class InfoPopup extends StatelessWidget {
  const InfoPopup(
      {Key? key, required this.title, required this.ok, this.cancel})
      : super(key: key);

  final String title;
  final VoidCallback ok;
  final VoidCallback? cancel;

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
          if (cancel != null)
            TextButton(
                child: Text(S.of(context).button_cancel,
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: AnthealthColors.warning1)),
                onPressed: cancel!),
          TextButton(
              child: Text(S.of(context).button_ok,
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: AnthealthColors.primary1)),
              onPressed: ok)
        ]);
  }
}
