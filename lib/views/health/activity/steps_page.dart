import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/health/steps_cubit.dart';
import 'package:anthealth_mobile/blocs/health/steps_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/number_logic.dart';
import 'package:anthealth_mobile/logics/step_logic.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/views/common_pages/error_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_avatar_form_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/health/activity/steps_detail_page.dart';
import 'package:anthealth_mobile/views/health/activity/widgets/activity_add_data_bottom_sheet.dart';
import 'package:anthealth_mobile/views/health/activity/widgets/activity_circle_bar.dart';
import 'package:anthealth_mobile/views/health/activity/widgets/activity_today.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepsPage extends StatelessWidget {
  const StepsPage({Key? key, this.data}) : super(key: key);

  final FamilyMemberData? data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StepsCubit>(
        create: (context) => StepsCubit(),
        child: BlocBuilder<StepsCubit, CubitState>(builder: (context, state) {
          if (state is StepsState) {
            if (data == null)
              return TemplateFormPage(
                  title: S.of(context).Activity_steps,
                  back: () => back(context),
                  add: () => add(context),
                  settings: () => setting(),
                  content: buildContent(context, state));
            else
              return TemplateAvatarFormPage(
                  firstTitle: S.of(context).Activity_steps,
                  name: data!.name,
                  avatarPath: data!.avatarPath,
                  content: buildContent(context, state));
          }
          return ErrorPage();
        }));
  }

  Widget buildContent(BuildContext context, StepsState state) {
    return Column(children: [
      ActivityCircleBar(
          percent: state.data.getStepsValue() / state.data.getGoal(),
          iconPath: "assets/indicators/steps.png",
          colorID: 1,
          value: NumberLogic.formatIntMore3(state.data.getStepsValue()),
          subValue: NumberLogic.formatIntMore3(
              StepsLogic.distanceCalculator(state.data.getStepsValue())),
          title: S.of(context).steps,
          subTitle: 'm'),
      SizedBox(height: 32),
      ActivityToday(title: S.of(context).Today_achievement, colorID: 1, value: [
        (state.data.getStepsValue() * 100 / state.data.getGoal())
            .toStringAsFixed(0),
        NumberLogic.formatIntMore3(state.data.getStepsValue()),
        NumberLogic.formatIntMore3(
            StepsLogic.distanceCalculator(state.data.getStepsValue())),
        NumberLogic.formatIntMore3(
            StepsLogic.caloCalculator(state.data.getStepsValue()))
      ], unit: [
        "%",
        "",
        "m",
        "calo"
      ], content: [
        S.of(context).Goal,
        S.of(context).steps,
        S.of(context).Distance,
        S.of(context).Consumed
      ]),
      SizedBox(height: 32),
      SectionComponent(
          title: S.of(context).Detail,
          colorID: 1,
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) =>
                  StepsDetailPage(superContext: context, data: data))))
    ]);
  }

  /// Actions
  void back(BuildContext context) {
    Navigator.of(context).pop();
  }

  void add(BuildContext context) {
    showModalBottomSheet(
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        context: context,
        builder: (_) => ActivityAddDataBottomSheet(
            title: S.of(context).Add_steps,
            activity: S.of(context).Steps_count,
            dataPicker: StepsLogic.dataPicker(),
            subDataPicker: StepsLogic.subDataPicker(),
            indexPicker: 0,
            subIndexPicker: 50,
            dateTime: DateTime.now(),
            unit: S.of(context).steps,
            middleSymbol: '.',
            cancel: () => Navigator.pop(context),
            ok: (indexPicker, subIndexPicker, time) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(S.of(context).Add_steps +
                      ' ' +
                      S.of(context).successfully +
                      '!')));
              Navigator.pop(context);
            }));
  }

  void setting() {}
}
