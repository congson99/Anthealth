import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomDivider {
  static Widget common() => Divider(height: 0.5, color: AnthealthColors.black3);

  static Widget dash({double? height, double? weight}) => Row(
      children: List.generate(
          (weight == null) ? 100 : (weight ~/ 5),
          (index) => Expanded(
              child: Container(
                  color: index % 2 == 0
                      ? Colors.transparent
                      : AnthealthColors.black3,
                  height: (height == null) ? 1 : height))));

  static Widget cutLine(double width) => Container(
      color: Colors.white,
      child: Row(children: [
        Image.asset("assets/support_component/half_circle_right_bla3.png",
            height: 24, width: 8),
        ...List.generate(
            width ~/ 5,
            (index) => Expanded(
                child: Container(
                    color: index % 2 == 0
                        ? Colors.transparent
                        : AnthealthColors.black4,
                    height: 2))),
        Image.asset("assets/support_component/half_circle_left_bla3.png",
            height: 24, width: 8)
      ]));

  static Widget timeLine(double height, bool pass, bool upcoming,
      DateTime before, DateTime after) {
    if (pass)
      return Container(
          height: height,
          width: 24,
          alignment: Alignment.center,
          child: Container(
              height: height, width: 4, color: AnthealthColors.secondary1));
    if (upcoming)
      return Container(
          height: height,
          width: 24,
          alignment: Alignment.center,
          child: Container(
              height: height, width: 4, color: AnthealthColors.black4));
    int longTime =
        after.hour * 60 + after.minute - before.hour * 60 - before.minute;
    int passTime = DateTime.now().hour * 60 +
        DateTime.now().minute -
        before.hour * 60 -
        before.minute;
    return Container(
        height: height,
        width: 24,
        alignment: Alignment.centerRight,
        child: Column(children: [
          Expanded(
              flex: (passTime > 120) ? passTime * 2 : passTime,
              child: Container(width: 4, color: AnthealthColors.secondary1)),
          Image.asset("assets/app_icon/common/reminder_sec0.png",
              width: 24, fit: BoxFit.fitWidth),
          Expanded(
              flex: longTime - passTime,
              child: Container(width: 4, color: AnthealthColors.black4))
        ]));
  }
}
