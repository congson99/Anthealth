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
                    height: (height == null) ? 1 : height,
                  ),
                )),
      );

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
                      height: 2,
                    ),
                  )),
          Image.asset("assets/support_component/half_circle_left_bla3.png",
              height: 24, width: 8)
        ]),
  );
}
