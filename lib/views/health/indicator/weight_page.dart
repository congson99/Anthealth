import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/health/indicator_cubit.dart';
import 'package:anthealth_mobile/blocs/health/indicator_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/dateTime_logic.dart';
import 'package:anthealth_mobile/logics/indicator_logic.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/models/health/indicator_models.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_avatar_form_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/next_previous_bar.dart';
import 'package:anthealth_mobile/views/common_widgets/switch_bar.dart';
import 'package:anthealth_mobile/views/common_widgets/warning_popup.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicatorMoreInfo.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_detail_popup.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_detail_records.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_edit_bottom_sheet.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_latest_record.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_line_chart.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WeightPage extends StatelessWidget {
  const WeightPage(
      {Key? key, this.dashboardContext, this.latestHeight, this.data})
      : super(key: key);

  final BuildContext? dashboardContext;
  final String unit = 'kg';
  final double? latestHeight;

  final FamilyMemberData? data;

  @override
  Widget build(BuildContext context) => BlocProvider<IndicatorCubit>(
      create: (context) => IndicatorCubit(1, 0),
      child: BlocBuilder<IndicatorCubit, CubitState>(builder: (context, state) {
        if (state is IndicatorState || state is IndicatorLoadingState) {
          IndicatorPageData pageData = IndicatorPageData(
              0,
              "",
              0,
              IndicatorData(0, DateTime.now(), ""),
              MoreInfo("", ""),
              IndicatorFilter(0, DateTime.now()), []);
          if (state is IndicatorState) pageData = state.data;
          if (state is IndicatorLoadingState) pageData = state.data;
          if (data == null)
            return TemplateFormPage(
                title: S.of(context).Weight,
                back: () => back(context),
                add: (state is IndicatorState)
                    ? (() => add(context, state))
                    : null,
                settings: () => setting(),
                content: buildContent(
                    context, pageData, state is IndicatorLoadingState));
          else
            return TemplateAvatarFormPage(
                firstTitle: S.of(context).Weight,
                name: data!.name,
                add: (state is IndicatorState && data!.permission[1] == 1)
                    ? (() => add(context, state))
                    : null,
                avatarPath: data!.avatarPath,
                content: buildContent(
                    context, pageData, state is IndicatorLoadingState));
        } else
          return LoadingPage();
      }));

  // Content
  Widget buildContent(
      BuildContext context, IndicatorPageData pageData, bool loading) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if ((pageData.getLatestRecord().getValue() != 0))
            IndicatorLatestRecord(
                unit: unit,
                value: pageData.getLatestRecord().getValue().toStringAsFixed(1),
                time: DateFormat('dd.MM.yyyy')
                    .format(pageData.getLatestRecord().getDateTime())),
          if (latestHeight != null &&
              latestHeight != 0 &&
              pageData.getLatestRecord().getValue() != 0)
            IndicatorMoreInfo(
                information: MoreInfo.buildWeightMoreInfo(
                    context,
                    latestHeight!,
                    pageData.getLatestRecord().getValue(),
                    pageData.getMoreInfo().getUrl())),
          buildDetailContainer(context, pageData, loading)
        ]);
  }

  // Content Component
  Widget buildDetailContainer(
      BuildContext context, IndicatorPageData data, bool loading) {
    return Container(
        decoration: BoxDecoration(
            color: AnthealthColors.primary5,
            borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(children: [
          SwitchBar(
            content: [
              S.of(context).Month,
              S.of(context).Year,
              S.of(context).All_time
            ],
            index: data.getFilter().getFilterIndex(),
            onIndexChange: (index) => BlocProvider.of<IndicatorCubit>(context)
                .updateData(data, IndicatorFilter(index, DateTime.now())),
            colorID: 0,
          ),
          if (data.getFilter().getFilterIndex() == 0)
            buildMonthNextPreviousBar(data, context),
          if (data.getFilter().getFilterIndex() == 1)
            buildYearNextPreviousBar(data, context),
          SizedBox(height: 24),
          if (loading) Center(child: CircularProgressIndicator()),
          if (!loading) buildDetailContent(data, context)
        ]));
  }

  Widget buildMonthNextPreviousBar(
      IndicatorPageData data, BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 24),
        child: NextPreviousBar(
            content: DateTimeLogic.formatMonthYear(
                context, data.getFilter().getTime()),
            increase: () {
              if ((data.getFilter().getTime().year < DateTime.now().year) ||
                  (data.getFilter().getTime().year == DateTime.now().year &&
                      data.getFilter().getTime().month < DateTime.now().month))
                BlocProvider.of<IndicatorCubit>(context).updateData(
                    data,
                    IndicatorFilter(
                        0,
                        IndicatorLogic.addMonth(
                            data.getFilter().getTime(), 1)));
            },
            decrease: () {
              if (data.getFilter().getTime().year > 2000)
                BlocProvider.of<IndicatorCubit>(context).updateData(
                    data,
                    IndicatorFilter(
                        0,
                        IndicatorLogic.addMonth(
                            data.getFilter().getTime(), -1)));
            }));
  }

  Widget buildYearNextPreviousBar(
      IndicatorPageData data, BuildContext context) {
    return Column(children: [
      SizedBox(height: 24),
      NextPreviousBar(
          content: data.getFilter().getTime().year.toString(),
          increase: () {
            if (data.getFilter().getTime().year < DateTime.now().year)
              BlocProvider.of<IndicatorCubit>(context).updateData(
                  data,
                  IndicatorFilter(1,
                      IndicatorLogic.addYear(data.getFilter().getTime(), 1)));
          },
          decrease: () {
            if (data.getFilter().getTime().year > 1900)
              BlocProvider.of<IndicatorCubit>(context).updateData(
                  data,
                  IndicatorFilter(1,
                      IndicatorLogic.addYear(data.getFilter().getTime(), -1)));
          })
    ]);
  }

  Widget buildDetailContent(IndicatorPageData data, BuildContext context) {
    return Column(children: [
      if (data.getData().length == 0)
        Text(S.of(context).no_indicator_record,
            style: Theme.of(context).textTheme.bodyText2),
      if (data.getData().length > 1)
        IndicatorLineChart(
            filterIndex: data.getFilter().getFilterIndex(),
            indicatorIndex: 1,
            data: (data.getFilter().getFilterIndex() == 0)
                ? IndicatorLogic.convertToDayChartAvgData(data.getData())
                : (data.getFilter().getFilterIndex() == 1)
                    ? IndicatorLogic.convertToMonthChartAvgData(data.getData())
                    : IndicatorLogic.convertToYearChartData(data.getData())),
      if (data.getData().length > 1) SizedBox(height: 24),
      if (data.getData().length != 0)
        IndicatorDetailRecords(
            unit: unit,
            dateTimeFormat: (data.getFilter().getFilterIndex() == 0)
                ? 'dd.MM'
                : (data.getFilter().getFilterIndex() == 1)
                    ? 'MM'
                    : 'yyyy',
            data: data.getData(),
            fixed: 1,
            onTap: (index) => onDetailTap(context, index, data),
            isDirection: (data.getFilter().getFilterIndex() != 0))
    ]);
  }

  // Hepper function
  void onDetailTap(BuildContext context, int index, IndicatorPageData data) {
    if (data.getFilter().getFilterIndex() == 0) {
      showPopup(context, index, data);
      return;
    }
    if (data.getFilter().getFilterIndex() == 1) {
      BlocProvider.of<IndicatorCubit>(context).updateData(
          data, IndicatorFilter(0, data.getData()[index].getDateTime()));
    } else {
      BlocProvider.of<IndicatorCubit>(context).updateData(
          data, IndicatorFilter(1, data.getData()[index].getDateTime()));
    }
  }

  void showPopup(BuildContext context, int index, IndicatorPageData pageData) {
    showDialog(
        context: context,
        builder: (_) => IndicatorDetailPopup(
            title: S.of(context).Weight,
            value: pageData.getData()[index].getValue().toStringAsFixed(1),
            unit: unit,
            time: DateFormat('hh:mm dd.MM.yyyy')
                .format(pageData.getData()[index].getDateTime()),
            recordID: pageData.getData()[index].getRecordID(),
            delete: (data != null)
                ? null
                : () => popupDelete(context, index, pageData),
            edit: (data != null)
                ? null
                : () => popupEdit(context, index, pageData),
            close: () => Navigator.pop(context)));
  }

  void popupDelete(BuildContext context, int index, IndicatorPageData data) {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (_) => WarningPopup(
            title: S.of(context).Warning_delete_data,
            cancel: () => Navigator.pop(context),
            delete: () {
              BlocProvider.of<IndicatorCubit>(context)
                  .deleteIndicator(
                      data.getType(), data.getData()[index], data.getOwnerID())
                  .then((value) {
                if (value)
                  BlocProvider.of<IndicatorCubit>(context)
                      .updateData(data, data.getFilter());
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(S.of(context).Delete_weight +
                        ' ' +
                        S.of(context).successfully +
                        '!')));
              });
              Navigator.pop(context);
            }));
  }

  void popupEdit(BuildContext context, int index, IndicatorPageData data) {
    Navigator.pop(context);
    showModalBottomSheet(
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        context: context,
        builder: (_) => IndicatorEditBottomSheet(
            title: S.of(context).Edit_weight,
            indicator: S.of(context).Weight,
            dataPicker: IndicatorDataPicker.weight(),
            subDataPicker: IndicatorDataPicker.sub9(),
            indexPicker: (data.getData()[index].getValue() ~/ 1).toInt(),
            subIndexPicker:
                ((data.getData()[index].getValue() * 10) % 10).toInt(),
            dateTime: data.getData()[index].getDateTime(),
            isDate: true,
            unit: unit,
            cancel: () => Navigator.pop(context),
            ok: (indexPicker, subIndexPicker, time) {
              BlocProvider.of<IndicatorCubit>(context)
                  .editIndicator(
                      data.getType(),
                      data.getData()[index],
                      IndicatorData(
                          indexPicker + subIndexPicker / 10, time, ''),
                      data.getOwnerID())
                  .then((value) {
                BlocProvider.of<IndicatorCubit>(context)
                    .updateData(data, data.getFilter());
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(S.of(context).Edit_weight +
                        ' ' +
                        S.of(context).successfully +
                        '!')));
              });
              Navigator.pop(context);
            }));
  }

  // Appbar Actions
  void back(BuildContext context) {
    if (dashboardContext != null)
      BlocProvider.of<DashboardCubit>(dashboardContext!).health();
    Navigator.pop(context);
  }

  void add(BuildContext context, IndicatorState state) {
    buildAddIndicatorBottomSheet(context, state);
  }

  void setting() {}

  Future<dynamic> buildAddIndicatorBottomSheet(
      BuildContext context, IndicatorState state) {
    int formatLatest = 50;
    int subFormatLatest = 0;
    if (state.data.getLatestRecord().getValue() != 0) {
      formatLatest = (state.data.getLatestRecord().getValue() ~/ 1).toInt();
      subFormatLatest =
          ((state.data.getLatestRecord().getValue() * 10) % 10).toInt();
    }
    return showModalBottomSheet(
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        context: context,
        builder: (_) => IndicatorEditBottomSheet(
            title: S.of(context).Add_weight,
            indicator: S.of(context).Weight,
            dataPicker: IndicatorDataPicker.weight(),
            subDataPicker: IndicatorDataPicker.sub9(),
            indexPicker: formatLatest,
            subIndexPicker: subFormatLatest,
            dateTime: DateTime.now(),
            isDate: true,
            unit: unit,
            cancel: () => Navigator.pop(context),
            ok: (indexPicker, subIndexPicker, time) => addRecord(
                context, indexPicker + subIndexPicker / 10, time, state)));
  }

  void addRecord(BuildContext context, double indexPicker, DateTime time,
      IndicatorState state) {
    BlocProvider.of<IndicatorCubit>(context)
        .addIndicator(1, IndicatorData(indexPicker, time, ""))
        .then((value) {
      if (value)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(S.of(context).Add_weight +
                ' ' +
                S.of(context).successfully +
                '!')));

      BlocProvider.of<IndicatorCubit>(context)
          .updateData(state.data, state.data.getFilter());
    });
    Navigator.pop(context);
  }
}
