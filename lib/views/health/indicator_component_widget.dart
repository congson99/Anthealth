import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class IndicatorComponent extends StatelessWidget {
  const IndicatorComponent({
    Key? key,
    required this.colorID,
    required this.iconPath,
    this.value,
    this.unit,
    required this.title,
    this.isWarning,
    this.onTap,
  }) : super(key: key);

  final int colorID;
  final String iconPath;
  final String? value;
  final String? unit;
  final String title;
  final bool? isWarning;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color color0 = colorID == 0
        ? AnthealthColors.primary0
        : colorID == 1
            ? AnthealthColors.secondary0
            : AnthealthColors.warning0;
    Color color5 = colorID == 0
        ? AnthealthColors.primary5
        : colorID == 1
            ? AnthealthColors.secondary5
            : AnthealthColors.warning5;
    return Expanded(
        child: Stack(children: [
      GestureDetector(
          onTap: onTap,
          child: Container(
              decoration: BoxDecoration(
                  color: color5,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: (isWarning == true)
                      ? [
                          BoxShadow(
                              color: AnthealthColors.warning1, spreadRadius: 5)
                        ]
                      : null),
              margin: (isWarning == true) ? EdgeInsets.only(top: 15) : null,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Image.asset(iconPath,
                            height: 44.0, width: 44.0, fit: BoxFit.cover)),
                    SizedBox(height: 12),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(color: AnthealthColors.black1),
                                  children: [
                                TextSpan(
                                    text: unit, style: TextStyle(fontSize: 8))
                              ]))
                        ]),
                    SizedBox(height: 4),
                    Text(title,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: color0))
                  ]))),
      isWarning == true
          ? Container(
              alignment: Alignment.center,
              child: Image.asset(
                  "assets/app_icon/common/warning_border_war2.png",
                  height: 22.0,
                  fit: BoxFit.cover))
          : Container()
    ]));
  }
}
