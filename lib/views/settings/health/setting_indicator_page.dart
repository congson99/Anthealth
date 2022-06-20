import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/health/indicator_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingIndicatorPage extends StatelessWidget {
  const SettingIndicatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: S.of(context).Health_indicator,
        back: () => Navigator.pop(context),
        content:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          CommonText.section(S.of(context).Warning_threshold, context),
          SizedBox(height: 24),
          buildSelectBloodPressure(context),
          SizedBox(height: 24),
          buildSelectSpo2(context),
          SizedBox(height: 24),
          buildSelectTemperature(context)
        ]));
  }

  Widget buildSelectBloodPressure(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
            color: AnthealthColors.black5,
            borderRadius: BorderRadius.circular(16)),
        child: Column(children: [
          Text(S.of(context).High_blood_pressure,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: AnthealthColors.black2)),
          SizedBox(height: 24),
          Row(children: [
            Expanded(
                child: SizedBox(
                    height: 120,
                    child: CupertinoPicker(
                        scrollController:
                            FixedExtentScrollController(initialItem: 140),
                        looping: true,
                        itemExtent: 30,
                        onSelectedItemChanged: (int value) {},
                        children: IndicatorDataPicker.bloodPressure()
                            .map((mData) => Center(child: Text(mData)))
                            .toList()))),
            Text("/",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AnthealthColors.black0)),
            Expanded(
                child: SizedBox(
                    height: 120,
                    child: CupertinoPicker(
                        scrollController:
                            FixedExtentScrollController(initialItem: 90),
                        looping: true,
                        itemExtent: 30,
                        onSelectedItemChanged: (int value) {},
                        children: IndicatorDataPicker.bloodPressure()
                            .map((mData) => Center(child: Text(mData)))
                            .toList()))),
            Text("mmHg",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AnthealthColors.black0))
          ]),
          SizedBox(height: 8)
        ]));
  }

  Widget buildSelectSpo2(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
            color: AnthealthColors.black5,
            borderRadius: BorderRadius.circular(16)),
        child: Column(children: [
          Text(S.of(context).Setting_low_spo2,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: AnthealthColors.black2)),
          SizedBox(height: 24),
          Row(children: [
            Expanded(flex: 1, child: Container()),
            Expanded(
                flex: 2,
                child: SizedBox(
                    height: 120,
                    child: CupertinoPicker(
                        scrollController:
                            FixedExtentScrollController(initialItem: 94),
                        looping: true,
                        itemExtent: 30,
                        onSelectedItemChanged: (int value) {},
                        children: IndicatorDataPicker.spo2()
                            .map((mData) => Center(child: Text(mData)))
                            .toList()))),
            Text("%",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AnthealthColors.black0)),
            Expanded(flex: 1, child: Container())
          ]),
          SizedBox(height: 8)
        ]));
  }

  Widget buildSelectTemperature(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
            color: AnthealthColors.black5,
            borderRadius: BorderRadius.circular(16)),
        child: Column(children: [
          Text(S.of(context).High_temperature,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: AnthealthColors.black2)),
          SizedBox(height: 24),
          Row(children: [
            Expanded(
                child: SizedBox(
                    height: 120,
                    child: CupertinoPicker(
                        scrollController:
                            FixedExtentScrollController(initialItem: 8),
                        looping: true,
                        itemExtent: 30,
                        onSelectedItemChanged: (int value) {},
                        children: IndicatorDataPicker.temperature()
                            .map((mData) => Center(child: Text(mData)))
                            .toList()))),
            Text(".",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AnthealthColors.black0)),
            Expanded(
                child: SizedBox(
                    height: 120,
                    child: CupertinoPicker(
                        scrollController:
                            FixedExtentScrollController(initialItem: 0),
                        looping: true,
                        itemExtent: 30,
                        onSelectedItemChanged: (int value) {},
                        children: IndicatorDataPicker.sub9()
                            .map((mData) => Center(child: Text(mData)))
                            .toList()))),
            Text("°C",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AnthealthColors.black0))
          ]),
          SizedBox(height: 8)
        ]));
  }
}
