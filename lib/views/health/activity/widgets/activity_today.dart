import 'dart:math';

import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class ActivityToday extends StatelessWidget {
  const ActivityToday(
      {Key? key,
      required this.title,
      required this.colorID,
      required this.value,
      required this.unit,
      required this.content})
      : super(key: key);

  final String title;
  final int colorID;
  final List<String> value;
  final List<String> unit;
  final List<String> content;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(title, style: Theme.of(context).textTheme.subtitle1),
      buildContent(context)
    ]);
  }

  Container buildContent(BuildContext context) {
    double size = MediaQuery.of(context).size.width - 64;
    return Container(
        width: size,
        child: Column(children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    height: size / 3,
                    width: size / 2 - 1,
                    child:
                        buildComponent(context, value[0], unit[0], content[0])),
                Container(
                  height: size * 0.25,
                  width: 1,
                  color: AnthealthColors.black4,
                ),
                Container(
                    height: size / 3,
                    width: size / 2 - 1,
                    child:
                        buildComponent(context, value[1], unit[1], content[1])),
              ]),
          Container(
            height: 1,
            width: size * 0.8,
            color: AnthealthColors.black4,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: size / 3,
                    width: size / 2 - 1,
                    child:
                        buildComponent(context, value[2], unit[2], content[2])),
                Container(
                  height: size * 0.25,
                  width: 1,
                  color: AnthealthColors.black4,
                ),
                Container(
                    height: size / 3,
                    width: size / 2 - 1,
                    child:
                        buildComponent(context, value[3], unit[3], content[3]))
              ])
        ]));
  }

  Column buildComponent(
      BuildContext context, String value, String unit, String content) {
    List<Color> color1 = [
      AnthealthColors.primary1,
      AnthealthColors.secondary1,
      AnthealthColors.warning1
    ];
    double size = MediaQuery.of(context).size.width / 2 - 36;
    double valueSize = value.length * 15;
    double unitSize = unit.length * 11.5;
    valueSize = min(valueSize, size - unitSize);
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                width: valueSize,
                alignment: Alignment.center,
                child: Text(value,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: color1[colorID]))),
            Container(
                width: unitSize,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(bottom: 1),
                child: Text(unit,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: color1[colorID])))
          ]),
      SizedBox(height: 8),
      Text(content,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle1),
    ]);
  }
}
