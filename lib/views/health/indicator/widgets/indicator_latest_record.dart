import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/health/indicator_models.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IndicatorLatestRecord extends StatelessWidget {
  const IndicatorLatestRecord({
    Key? key,
    required this.unit,
    required this.value,
    required this.time,
    this.information
  }) : super(key: key);

  final String unit;
  final String value;
  final String time;
  final MoreInfo? information;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(value != '') Text(S.of(context).Latest_record,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: AnthealthColors.black1)),
              if(value != '') SizedBox(height: 8),
              if(value != '')  RichText(
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
              if(value != '') SizedBox(height: 8),
              if(value != '')  Text(S.of(context).Record_time + ": " + time,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: AnthealthColors.black2)),
              if (information!.getContent() != '') SizedBox(height: 32),
              if (information!.getContent() != '')
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('* ',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      color: AnthealthColors.black1,
                                      fontFamily: 'RobotoRegular',
                                      letterSpacing: 0.2)),
                          Expanded(
                              child: RichText(
                                  text: TextSpan(
                                      text: information!.getContent(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              color: AnthealthColors.black1,
                                              fontFamily: 'RobotoRegular',
                                              letterSpacing: 0.2),
                                      children: [
                                if (information!.getUrl() != "")
                                  TextSpan(
                                      text: ' ' + S.of(context).Learn_more,
                                      style: TextStyle(
                                          color: AnthealthColors.primary1,
                                          fontFamily: 'RobotoMedium'),
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                          launch(information!.getUrl());
                                        })
                              ])))
                        ]))
            ]));
  }
}
