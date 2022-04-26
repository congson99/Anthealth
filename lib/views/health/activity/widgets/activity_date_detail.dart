import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/dateTime_logic.dart';
import 'package:anthealth_mobile/logics/number_logic.dart';
import 'package:anthealth_mobile/logics/step_logic.dart';
import 'package:anthealth_mobile/logics/water_logic.dart';
import 'package:anthealth_mobile/models/health/steps_models.dart';
import 'package:anthealth_mobile/models/health/water_models.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class ActivityDateDetail extends StatelessWidget {
  const ActivityDateDetail(
      {Key? key, required this.type, required this.unit, required this.data})
      : super(key: key);

  final int type;
  final String unit;
  final List<dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
          height: 30,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(S.of(context).Detail,
                style: Theme.of(context).textTheme.subtitle2),
            Text(S.of(context).Unit + ": " + unit,
                style: Theme.of(context).textTheme.bodyText1)
          ])),
      Divider(thickness: 0.5, height: 0.5, color: AnthealthColors.black0),
      if(type == 2)...StepsLogic.mergeStepsInHour(data)
          .map((mData) => buildStepComponent(mData, context))
          .toList(),
      if(type == 1)...WaterLogic.mergeWaterInHour(data)
          .map((mData) => buildWaterComponent(mData, context))
          .toList()
    ]);
  }

  Widget buildStepComponent(Steps mData, BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Divider(thickness: 0.5, height: 0.5, color: AnthealthColors.black1),
      Container(
          height: 36,
          color: Colors.transparent,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(DateTimeLogic.formatHourToHour(mData.time),
                    style: Theme.of(context).textTheme.bodyText1),
                Expanded(child: Container()),
                Text(NumberLogic.formatIntMore3(mData.value),
                    style: Theme.of(context).textTheme.bodyText1)
              ]))
    ]);
  }

  Widget buildWaterComponent(Water mData, BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Divider(thickness: 0.5, height: 0.5, color: AnthealthColors.black1),
      Container(
          height: 36,
          color: Colors.transparent,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(DateTimeLogic.formatHourToHour(mData.time),
                    style: Theme.of(context).textTheme.bodyText1),
                Expanded(child: Container()),
                Text(NumberLogic.formatIntMore3(mData.value),
                    style: Theme.of(context).textTheme.bodyText1)
              ]))
    ]);
  }
}
