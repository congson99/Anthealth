import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class IndicatorDetailPopup extends StatelessWidget {
  const IndicatorDetailPopup({
    Key? key,
    required this.title,
    required this.value,
    required this.unit,
    required this.time,
    this.recordID,
    required this.delete,
    required this.edit,
    required this.close,
  }) : super(key: key);

  final String title;
  final String value;
  final String unit;
  final String time;
  final String? recordID;
  final VoidCallback delete;
  final VoidCallback edit;
  final VoidCallback close;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: RichText(
            text: TextSpan(
                text: title + ': ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: AnthealthColors.black2),
                children: [
              TextSpan(
                  text: value,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: AnthealthColors.primary1)),
              TextSpan(
                  text: unit,
                  style:
                      TextStyle(color: AnthealthColors.primary1)),
              TextSpan(text: '\n' + S.of(context).Record_time + ': ' + time, style: TextStyle(height: 1.4)),
              if (recordID != null && recordID != '')
                TextSpan(
                    text: '\n' + S.of(context).Add_by + ': ' + recordID!,
                    style: TextStyle(height: 1.4))
            ])),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              child: Text(S.of(context).button_delete,
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: AnthealthColors.warning1)),
              onPressed: delete),
          Container(width: 1, height: 16, color: AnthealthColors.black3),
          TextButton(
              child: Text(S.of(context).button_edit,
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: AnthealthColors.secondary1)),
              onPressed: edit),
          Container(width: 1, height: 16, color: AnthealthColors.black3),
          TextButton(
              child: Text(S.of(context).button_close,
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: AnthealthColors.primary1)),
              onPressed: close)
        ]);
  }
}
