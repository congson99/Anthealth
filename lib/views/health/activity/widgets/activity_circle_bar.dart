import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ActivityCircleBar extends StatelessWidget {
  const ActivityCircleBar(
      {Key? key,
      required this.percent,
      required this.iconPath,
      required this.colorID,
      required this.value,
      required this.subValue,
      required this.title,
      required this.subTitle})
      : super(key: key);

  final double percent;
  final String iconPath;
  final int colorID;
  final String value;
  final String subValue;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    List<Color> color1 = [
      AnthealthColors.primary1,
      AnthealthColors.secondary1,
      AnthealthColors.warning1
    ];
    List<Color> color2 = [
      AnthealthColors.primary2,
      AnthealthColors.secondary2,
      AnthealthColors.warning2
    ];
    double size = MediaQuery.of(context).size.width - 32;
    return Container(
        height: size,
        width: size,
        child: Stack(children: [
          Image.asset("assets/circle_status_bar_background.png",
              height: size, fit: BoxFit.contain),
          Center(
              child: Container(
                  height: size * 0.75, child: buildCircleBar(color2))),
          Center(child: buildCircleBarContent(context, size * 0.6, color1))
        ]));
  }

  Widget buildCircleBar(List<Color> color2) {
    return SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(
          minimum: 0,
          maximum: 100,
          showLabels: false,
          showTicks: false,
          startAngle: 270,
          endAngle: 270,
          axisLineStyle: AxisLineStyle(
            thickness: 0.15,
            color: AnthealthColors.black4,
            thicknessUnit: GaugeSizeUnit.factor,
            cornerStyle: CornerStyle.bothFlat,
          ),
          pointers: <GaugePointer>[
            RangePointer(
                value: percent,
                width: 0.15,
                sizeUnit: GaugeSizeUnit.factor,
                color: color2[colorID],
                cornerStyle: CornerStyle.bothCurve)
          ])
    ]);
  }

  Container buildCircleBarContent(
      BuildContext context, double size, List<Color> color1) {
    return Container(
        height: size,
        width: size,
        padding: const EdgeInsets.all(8),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(iconPath, height: 28, fit: BoxFit.fitHeight),
          SizedBox(height: 16, width: size * 0.6, child: CustomDivider.dash()),
          Text(value,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontSize: 42, color: color1[colorID])),
          Text(title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText1),
          SizedBox(height: 16, width: size * 0.6, child: CustomDivider.dash()),
          Text(subValue,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline2),
          Text(subTitle,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText1)
        ]));
  }
}
