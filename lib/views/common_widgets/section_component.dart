import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class SectionComponent extends StatelessWidget {
  const SectionComponent(
      {Key? key,
      required this.title,
      this.subTitle,
      this.subSubTitle,
      this.directionContent,
      this.isDirection,
      this.iconPath,
      required this.colorID,
      this.isWarning,
      this.onTap})
      : super(key: key);

  final String title;
  final String? subTitle;
  final String? subSubTitle;
  final String? directionContent;
  final bool? isDirection;
  final String? iconPath;
  final int colorID;
  final bool? isWarning;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color color0 = colorID == 0
        ? AnthealthColors.primary0
        : colorID == 1
            ? AnthealthColors.secondary0
            : AnthealthColors.warning0;
    Color color1 = colorID == 0
        ? AnthealthColors.primary1
        : colorID == 1
            ? AnthealthColors.secondary1
            : AnthealthColors.warning1;
    Color color5 = colorID == 0
        ? AnthealthColors.primary5
        : colorID == 1
            ? AnthealthColors.secondary5
            : AnthealthColors.warning5;
    return GestureDetector(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
                color: color5,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isWarning == true
                    ? [BoxShadow(color: color1, spreadRadius: 2)]
                    : []),
            padding: const EdgeInsets.all(16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (iconPath != null)
                          Image.asset(iconPath!,
                              height: 20.0, fit: BoxFit.cover),
                        if (iconPath != null) SizedBox(width: 8),
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              82 -
                              ((iconPath != null) ? 20 : 0) -
                              ((isDirection != false) ? 10 : 0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(color: color0)),
                                SizedBox(height: 4),
                                subTitle == null
                                    ? Container()
                                    : Text(subTitle ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(color: color1)),
                                subSubTitle == null
                                    ? Container()
                                    : Text(subSubTitle ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(color: color1))
                              ]),
                        )
                      ]),
                  if (isDirection != false)
                    Image.asset(
                        colorID == 0
                            ? "assets/app_icon/direction/right_pri1.png"
                            : colorID == 1
                                ? "assets/app_icon/direction/right_sec1.png"
                                : "assets/app_icon/direction/right_war1.png",
                        height: 16.0,
                        width: 16.0,
                        fit: BoxFit.cover)
                ])));
  }
}
