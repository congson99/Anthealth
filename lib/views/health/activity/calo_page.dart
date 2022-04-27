import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/health/calo_cubit.dart';
import 'package:anthealth_mobile/blocs/health/calo_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/number_logic.dart';
import 'package:anthealth_mobile/logics/water_logic.dart';
import 'package:anthealth_mobile/views/common_pages/error_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/health/activity/calo_detail_page.dart';
import 'package:anthealth_mobile/views/health/activity/widgets/activity_add_data_bottom_sheet.dart';
import 'package:anthealth_mobile/views/health/activity/widgets/activity_circle_bar.dart';
import 'package:anthealth_mobile/views/health/activity/widgets/activity_today.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaloPage extends StatelessWidget {
  const CaloPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CaloCubit>(
        create: (context) => CaloCubit(),
        child: BlocBuilder<CaloCubit, CubitState>(builder: (context, state) {
          if (state is CaloState)
            return TemplateFormPage(
                title: S.of(context).Calo,
                back: () => back(context),
                add: () => add(context),
                settings: () => setting(),
                content: buildContent(context, state));
          return ErrorPage();
        }));
  }

  // Content
  Widget buildContent(BuildContext context, CaloState state) {
    return Column(children: [
      ActivityCircleBar(
          percent: state.data.getCaloIn() /
              (state.data.getGoal() + state.data.getCaloOut()),
          iconPath: "assets/indicators/calo.png",
          colorID: 2,
          value: NumberLogic.formatIntMore3(state.data.getCaloIn()),
          subValue: NumberLogic.formatIntMore3(state.data.getGoal() +
              state.data.getCaloOut() -
              state.data.getCaloIn()),
          title: S.of(context).calo_in,
          subTitle: S.of(context).calo_remaining),
      SizedBox(height: 32),
      ActivityToday(title: S.of(context).Stats_today, colorID: 2, value: [
        NumberLogic.formatIntMore3(state.data.getCaloIn()),
        NumberLogic.formatIntMore3(state.data.getCaloOut()),
        ((state.data.getCaloIn() * 100) /
                (state.data.getGoal() + state.data.getCaloOut()))
            .toStringAsFixed(0),
        NumberLogic.formatIntMore3(state.data.getGoal() +
            state.data.getCaloOut() -
            state.data.getCaloIn()),
      ], unit: [
        "",
        "",
        "%",
        ""
      ], content: [
        S.of(context).calo_in,
        S.of(context).calo_out,
        S.of(context).Goal,
        S.of(context).calo_remaining
      ]),
      SizedBox(height: 32),
      SectionComponent(
          title: S.of(context).Detail,
          colorID: 2,
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => CaloDetailPage(superContext: context))))
    ]);
  }

  // Content Component

  // Child Component

  // Actions
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
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(S.of(context).Add_water +
                      ' ' +
                      S.of(context).successfully +
                      '!')));
              Navigator.pop(context);
            }));
  }

  void setting() {}
}
