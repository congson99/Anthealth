import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/common_widgets/info_popup.dart';
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
    required this.width,
    this.isVisible,
  }) : super(key: key);

  final int colorID;
  final String iconPath;
  final String? value;
  final String? unit;
  final String title;
  final bool? isWarning;
  final VoidCallback? onTap;
  final double width;
  final bool? isVisible;

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
    return SizedBox(
        width: width,
        child: Stack(children: [
          GestureDetector(
              onTap: onTap,
              child: Container(
                  width: width,
                  height: 136,
                  decoration: BoxDecoration(
                      color: color5,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: (isWarning == true && isVisible != true)
                          ? [
                              BoxShadow(
                                  color: AnthealthColors.warning1,
                                  spreadRadius: 5)
                            ]
                          : null),
                  margin: (isWarning == true && isVisible != true)
                      ? EdgeInsets.symmetric(vertical: 15)
                      : null,
                  child: Column(children: [
                    SizedBox(height: 16),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Image.asset(iconPath,
                            height: 44.0, width: 44.0, fit: BoxFit.cover)),
                    SizedBox(height: 12),
                    RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: AnthealthColors.black1),
                            children: <TextSpan>[
                              TextSpan(text: (value == null) ? "_" : value!),
                              TextSpan(
                                  text: (unit == null) ? "" : unit!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(fontSize: 10))
                            ])),
                    SizedBox(height: 4),
                    Text(title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: color0))
                  ]))),
          (isWarning == true && isVisible != true)
              ? Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                      "assets/app_icon/common/warning_border_war2.png",
                      height: 22.0,
                      fit: BoxFit.cover))
              : Container(),
          if (isVisible == true)
            GestureDetector(
                onTap: () => showPopup(context),
                child: Container(
                    width: width,
                    height: 136,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8))))
        ]));
  }

  // Show popup
  void showPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => InfoPopup(
              title: S.of(context).not_permission_view_data,
              ok: () => Navigator.pop(context),
            ));
  }
}
