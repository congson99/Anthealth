import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndicatorDetailRecord {
  IndicatorDetailRecord(this.dateTime, this.value);

  final String dateTime;
  final String value;
}

class IndicatorDetailRecords extends StatelessWidget {
  const IndicatorDetailRecords(
      {Key? key, required this.unit, required this.data, required this.onTap})
      : super(key: key);

  final String unit;
  final List<IndicatorDetailRecord> data;
  final Function(int) onTap;

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
                        Divider(thickness: 0.5, height: 0.5, color: AnthealthColors.primary1),
                        GestureDetector(
                          onTap: () => onTap(data.indexOf(mData)),
                          child: Container(
                              height: 35,
                              color: Colors.transparent,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(mData.dateTime,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color:
                                                    AnthealthColors.primary1)),
                                    Text(mData.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color:
                                                    AnthealthColors.primary1))
                                  ])),
                        )
                      ]))
              .toList()
        ]));
  }
}
