import 'package:anthealth_mobile/blocs/common_logic/dateTime_logic.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/health/indicator_models.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IndicatorDetailRecords extends StatelessWidget {
  const IndicatorDetailRecords(
      {Key? key,
      required this.unit,
      required this.dateTimeFormat,
      required this.data,
      required this.onTap,
      this.isDirection,
      required this.fixed})
      : super(key: key);

  final String unit;
  final String dateTimeFormat;
  final List<IndicatorData> data;
  final Function(int) onTap;
  final bool? isDirection;
  final int fixed;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          Container(
              height: 30,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(S.of(context).Detail,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: AnthealthColors.primary1)),
                    Text(S.of(context).Unit + ": " + unit,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: AnthealthColors.primary1))
                  ])),
          Divider(thickness: 0.5, height: 0.5, color: AnthealthColors.primary0),
          ...data
              .map((mData) => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Divider(
                            thickness: 0.5,
                            height: 0.5,
                            color: AnthealthColors.primary1),
                        GestureDetector(
                            onTap: () => onTap(data.indexOf(mData)),
                            child: Container(
                                height: 35,
                                color: Colors.transparent,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          (dateTimeFormat == 'hh-hh')
                                              ? (DateTimeLogic.formatHourToHour(
                                                  mData.getDateTime()))
                                              : ((dateTimeFormat == 'MM')
                                                  ? DateTimeLogic.formatMonth(
                                                      context,
                                                      mData.getDateTime())
                                                  : DateFormat(dateTimeFormat)
                                                      .format(
                                                          mData.getDateTime())),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: AnthealthColors
                                                      .primary1)),
                                      Expanded(child: Container()),
                                      Text(
                                          (fixed != 10)
                                              ? mData
                                                  .getValue()
                                                  .toStringAsFixed(fixed)
                                              : ((mData.getValue() ~/ 1)
                                                      .toString() +
                                                  '/' +
                                                  ((mData.getValue() * 1000) %
                                                          1000)
                                                      .toStringAsFixed(0)),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: AnthealthColors
                                                      .primary1)),
                                      if (isDirection == true)
                                        SizedBox(width: 8),
                                      if (isDirection == true)
                                        Image.asset(
                                            "assets/app_icon/direction/right_pri1.png",
                                            height: 12.0,
                                            width: 12.0,
                                            fit: BoxFit.cover)
                                    ])))
                      ]))
              .toList()
        ]));
  }
}
