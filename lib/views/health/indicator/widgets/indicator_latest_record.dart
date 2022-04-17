import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndicatorLatestRecord extends StatelessWidget {
  const IndicatorLatestRecord(
      {Key? key, required this.unit, required this.value, required this.time})
      : super(key: key);

  final String unit;
  final String value;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(S.of(context).Latest_record,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: AnthealthColors.black1)),
              SizedBox(height: 8),
              RichText(
                  text: TextSpan(
                      text: value,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 48, color: AnthealthColors.primary1),
                      children: [
                    TextSpan(
                        text: unit,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: AnthealthColors.primary1))
                  ])),
              SizedBox(height: 8),
              Text(S.of(context).Record_time + ": " + time,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: AnthealthColors.black2))
            ]));
  }
}
