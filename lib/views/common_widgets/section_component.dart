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
            : colorID == 2
                ? AnthealthColors.warning0
                : AnthealthColors.black0;
    Color color1 = colorID == 0
        ? AnthealthColors.primary1
        : colorID == 1
            ? AnthealthColors.secondary1
            : colorID == 2
                ? AnthealthColors.warning1
                : AnthealthColors.black1;
    Color color5 = colorID == 0
        ? AnthealthColors.primary5
        : colorID == 1
            ? AnthealthColors.secondary5
            : colorID == 2
                ? AnthealthColors.warning5
                : AnthealthColors.black5;
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
            child: buildContent(context, color0, color1)));
  }

  Widget buildContent(BuildContext context, Color color0, Color color1) {
    return Row(children: [
      if (iconPath != null)
        SizedBox(
            width: 20,
            height: 20.0,
            child: Image.asset(iconPath!, fit: BoxFit.contain)),
      if (iconPath != null && title != "") SizedBox(width: 10),
      buildTitles(context, color0, color1),
      if (directionContent != null)
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 1),
          child: Text(directionContent!,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 18, color: color0)),
        ),
      if (isDirection != false)
        Image.asset(
            colorID == 0
                ? "assets/app_icon/direction/right_pri1.png"
                : colorID == 1
                    ? "assets/app_icon/direction/right_sec1.png"
                    : colorID == 2
                        ? "assets/app_icon/direction/right_war1.png"
                        : "assets/app_icon/direction/right_bla2.png",
            height: 16.0,
            width: 16.0,
            fit: BoxFit.cover)
    ]);
  }

  Widget buildTitles(BuildContext context, Color color0, Color color1) =>
      Expanded(
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
            if (subTitle != null) SizedBox(height: 4),
            if (subTitle != null)
              Text(subTitle ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: color1)),
            if (subSubTitle != null) SizedBox(height: 4),
            if (subSubTitle != null)
              Text(subSubTitle ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: color1))
          ]));
}
