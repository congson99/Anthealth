import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/health/calo_cubit.dart';
import 'package:anthealth_mobile/blocs/health/calo_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/number_logic.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/views/common_pages/error_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_avatar_form_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_snackbar.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/health/activity/calo_detail_page.dart';
import 'package:anthealth_mobile/views/health/activity/widgets/activity_circle_bar.dart';
import 'package:anthealth_mobile/views/health/activity/widgets/activity_today.dart';
import 'package:anthealth_mobile/views/health/activity/widgets/add_caloin_bottom_sheet.dart';
import 'package:anthealth_mobile/views/health/activity/widgets/add_caloout_bottom_sheet.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaloPage extends StatelessWidget {
  const CaloPage({Key? key, this.data}) : super(key: key);

  final FamilyMemberData? data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CaloCubit>(
        create: (context) => CaloCubit(),
        child: BlocBuilder<CaloCubit, CubitState>(builder: (context, state) {
          if (state is CaloState) {
            if (data == null)
              return TemplateFormPage(
                  title: S.of(context).Activity_calo,
                  back: () => back(context),
                  add: () => add(context),
                  settings: () => setting(),
                  content: buildContent(context, state));
            else
              return TemplateAvatarFormPage(
                  firstTitle: S.of(context).Activity_calo,
                  name: data!.name,
                  avatarPath: data!.avatarPath,
                  content: buildContent(context, state));
          }
          return ErrorPage();
        }));
  }

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
              builder: (_) =>
                  CaloDetailPage(superContext: context, data: data))))
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
        builder: (_) => SafeArea(
            child: Container(
                height: 120,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () => addCaloIn(context),
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(S.of(context).Calo_in,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                            color: AnthealthColors.secondary1)),
                                SizedBox(height: 4),
                                Text("(" + S.of(context).Food + ")",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color: AnthealthColors.secondary1))
                              ]),
                        ),
                      )),
                      Container(
                          height: 90, width: 1, color: AnthealthColors.black3),
                      Expanded(
                          child: GestureDetector(
                        onTap: () => addCaloOut(context),
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(S.of(context).Calo_out,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                            color: AnthealthColors.warning1)),
                                SizedBox(height: 4),
                                Text("(" + S.of(context).Exercise + ")",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color: AnthealthColors.warning1))
                              ]),
                        ),
                      ))
                    ]))));
  }

  void addCaloIn(BuildContext context) {
    Navigator.of(context).pop();
    showModalBottomSheet(
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        context: context,
        builder: (_) => AddCaloInBottomSheet(
            superContext: context,
            ok: (value) {
              ShowSnackBar.showSuccessSnackBar(
                  context,
                  S.of(context).Add_calo_in +
                      ' ' +
                      S.of(context).successfully +
                      '!');
            }));
  }

  void addCaloOut(BuildContext context) {
    Navigator.of(context).pop();
    showModalBottomSheet(
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        context: context,
        builder: (_) => AddCaloOutBottomSheet(
            superContext: context,
            ok: (value) {
              ShowSnackBar.showSuccessSnackBar(
                  context,
                  S.of(context).Add_calo_out +
                      ' ' +
                      S.of(context).successfully +
                      '!');
            }));
  }

  void setting() {}
}
