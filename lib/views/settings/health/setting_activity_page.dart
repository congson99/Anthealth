import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/common_text_field.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/material.dart';

class SettingActivityPage extends StatelessWidget {
  const SettingActivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: S.of(context).Health_indicator,
        back: () => Navigator.pop(context),
        content:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          CommonText.section(S.of(context).Set_daily_goal, context),
          SizedBox(height: 16),
          buildCaloGoal(context),
          SizedBox(height: 16),
          buildWaterGoal(context),
          SizedBox(height: 16),
          buildStepGoal(context)
        ]));
  }

  Widget buildCaloGoal(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            color: AnthealthColors.warning5,
            borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          Text(S.of(context).Calo_in,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: AnthealthColors.warning0)),
          Expanded(child: Container()),
          SizedBox(
              width: 100,
              child: CommonTextField.box(
                  context: context,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  initialValue: "2000",
                  maxLines: 1,
                  textAlign: TextAlign.end,
                  onChanged: (value) {},
                  textInputType: TextInputType.number)),
          Container(
            width: 100,
            alignment: Alignment.centerRight,
            child: Text("calo / " + S.of(context).day,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: AnthealthColors.warning0)),
          )
        ]));
  }

  Widget buildWaterGoal(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            color: AnthealthColors.primary5,
            borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          Text(S.of(context).Water_count,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: AnthealthColors.primary0)),
          Expanded(child: Container()),
          SizedBox(
              width: 100,
              child: CommonTextField.box(
                  context: context,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  initialValue: "2000",
                  maxLines: 1,
                  textAlign: TextAlign.end,
                  onChanged: (value) {},
                  textInputType: TextInputType.number)),
          Container(
            width: 100,
            alignment: Alignment.centerRight,
            child: Text("ml / " + S.of(context).day,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: AnthealthColors.primary0)),
          )
        ]));
  }

  Widget buildStepGoal(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            color: AnthealthColors.secondary5,
            borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          Text(S.of(context).Steps_count,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: AnthealthColors.secondary0)),
          Expanded(child: Container()),
          SizedBox(
              width: 100,
              child: CommonTextField.box(
                  context: context,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  initialValue: "2000",
                  maxLines: 1,
                  textAlign: TextAlign.end,
                  onChanged: (value) {},
                  textInputType: TextInputType.number)),
          Container(
            width: 100,
            alignment: Alignment.centerRight,
            child: Text(S.of(context).steps + " / " + S.of(context).day,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: AnthealthColors.secondary0)),
          )
        ]));
  }
}
