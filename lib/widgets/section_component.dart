import 'package:anthealth_mobile/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SectionComponent extends StatelessWidget {
  const SectionComponent({
    Key? key,
    required this.title,
    this.subTitle,
    this.subSubTitle,
    this.directionContent,
    this.isDirection,
    required this.colorID,
    this.isWarning,
  }) : super(key: key);

  final String title;
  final String? subTitle;
  final String? subSubTitle;
  final String? directionContent;
  final bool? isDirection;
  final int colorID;
  final bool? isWarning;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: colorID == 0
                ? AnthealthColors.primary5
                : colorID == 1
                    ? AnthealthColors.secondary5
                    : AnthealthColors.warning5,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isWarning == true
                ? [
                    BoxShadow(
                        color: colorID == 0
                            ? AnthealthColors.primary1
                            : colorID == 1
                                ? AnthealthColors.secondary1
                                : AnthealthColors.warning1,
                        spreadRadius: 2)
                  ]
                : []),
        padding: const EdgeInsets.all(16),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: colorID == 0
                                ? AnthealthColors.primary0
                                : colorID == 1
                                    ? AnthealthColors.secondary0
                                    : AnthealthColors.warning0)),
                    SizedBox(height: 4),
                    subTitle == null
                        ? Container()
                        : Text(subTitle ?? "",
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                    color: colorID == 0
                                        ? AnthealthColors.primary1
                                        : colorID == 1
                                            ? AnthealthColors.secondary1
                                            : AnthealthColors.warning1)),
                    subSubTitle == null
                        ? Container()
                        : Text(subSubTitle ?? "",
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                    color: colorID == 0
                                        ? AnthealthColors.primary1
                                        : colorID == 1
                                            ? AnthealthColors.secondary1
                                            : AnthealthColors.warning1))
                  ]),
              if (isDirection == null || isDirection == true)
                Image.asset(
                    colorID == 0
                        ? "assets/app_icon/direction/right_pri1.png"
                        : colorID == 1
                            ? "assets/app_icon/direction/right_sec1.png"
                            : "assets/app_icon/direction/right_war1.png",
                    height: 16.0,
                    width: 16.0,
                    fit: BoxFit.cover)
            ]));
  }
}
