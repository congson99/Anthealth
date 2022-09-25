import 'dart:math';

import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/health/water_cubit.dart';
import 'package:anthealth_mobile/blocs/health/water_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/number_logic.dart';
import 'package:anthealth_mobile/logics/water_logic.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_avatar_form_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_snackbar.dart';
import 'package:anthealth_mobile/views/common_widgets/fill_popup.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/health/activity/water_detail_page.dart';
import 'package:anthealth_mobile/views/health/activity/widgets/activity_add_data_bottom_sheet.dart';
import 'package:anthealth_mobile/views/health/activity/widgets/activity_circle_bar.dart';
import 'package:anthealth_mobile/views/health/activity/widgets/activity_today.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WaterPage extends StatelessWidget {
  const WaterPage({Key? key, this.data}) : super(key: key);

  final FamilyMemberData? data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WaterCubit>(
        create: (context) => WaterCubit(),
        child: BlocBuilder<WaterCubit, CubitState>(builder: (context, state) {
          if (state is WaterState) {
            if (data == null)
              return TemplateFormPage(
                  title: S.of(context).Activity_water,
                  back: () => back(context),
                  add: () => add(context),
                  settings: () => setting(context),
                  content: buildContent(context, state));
            else
              return TemplateAvatarFormPage(
                  firstTitle: S.of(context).Activity_water,
                  name: data!.name,
                  avatarPath: data!.avatarPath,
                  content: buildContent(context, state));
          }
          return LoadingPage();
        }));
  }

  Widget buildContent(BuildContext context, WaterState state) {
    return Column(children: [
      ActivityCircleBar(
          percent: state.data.getWaterValue() / state.data.getGoal(),
          iconPath: "assets/indicators/water.png",
          colorID: 0,
          value: NumberLogic.formatIntMore3(state.data.getWaterValue()),
          subValue: NumberLogic.formatIntMore3(
              max(state.data.getGoal() - state.data.getWaterValue(), 0)),
          title: S.of(context).ml_drank,
          subTitle: S.of(context).ml_remaining),
      SizedBox(height: 32),
      ActivityToday(title: S.of(context).Stats_today, colorID: 0, value: [
        (state.data.getWaterValue() * 100 / state.data.getGoal())
            .toStringAsFixed(0),
        NumberLogic.formatIntMore3(state.data.getGoal()),
        NumberLogic.formatIntMore3(state.data.getWaterValue()),
        NumberLogic.formatIntMore3(
            max(state.data.getGoal() - state.data.getWaterValue(), 0)),
      ], unit: [
        "%",
        "",
        "",
        ""
      ], content: [
        S.of(context).Goal,
        S.of(context).ml_goal,
        S.of(context).ml_drank,
        S.of(context).ml_remaining
      ]),
      SizedBox(height: 32),
      SectionComponent(
          title: S.of(context).Detail,
          colorID: 0,
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) =>
                  WaterDetailPage(superContext: context, data: data))))
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
            title: S.of(context).Add_water,
            activity: S.of(context).Water_count,
            dataPicker: WaterLogic.dataPicker(),
            subDataPicker: WaterLogic.subDataPicker(),
            indexPicker: 0,
            subIndexPicker: 50,
            dateTime: DateTime.now(),
            unit: 'ml',
            middleSymbol: '.',
            cancel: () => Navigator.pop(context),
            ok: (indexPicker, subIndexPicker, time) {
              ShowSnackBar.showSuccessSnackBar(
                  context,
                  S.of(context).Add_water +
                      ' ' +
                      S.of(context).successfully +
                      '!');
              Navigator.pop(context);
            }));
  }

  void setting(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => FillPopup(
            title: S.of(context).Report,
            fillBoxes: [S.of(context).Goal],
            done: (result) {
              if (result[0] != "")
                try {
                  int goal = int.parse(result[0]);
                  print(goal);
                } catch (e) {
                  ShowSnackBar.showErrorSnackBar(
                      context, S.of(context).something_wrong);
                }
            }));
  }
}
