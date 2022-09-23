import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/health/indicator_cubit.dart';
import 'package:anthealth_mobile/blocs/health/indicator_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/indicator_logic.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/models/health/indicator_models.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_avatar_form_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_snackbar.dart';
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

class HeightPage extends StatelessWidget {
  const HeightPage(
      {Key? key, this.dashboardContext, this.mem, required this.user})
      : super(key: key);

  final BuildContext? dashboardContext;
  final String unit = 'm';
  final FamilyMemberData? mem;
  final User user;

  @override
  Widget build(BuildContext context) => BlocProvider<IndicatorCubit>(
      create: (context) =>
          IndicatorCubit(0, 0, id: (mem == null) ? null : mem?.id),
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
          if (mem == null)
            return TemplateFormPage(
                title: S.of(context).Height,
                back: () => back(context),
                add: (state is IndicatorState)
                    ? (() => add(context, state))
                    : null,
                content: buildContent(
                    context, pageData, state is IndicatorLoadingState));
          else
            return TemplateAvatarFormPage(
                firstTitle: S.of(context).Height,
                name: mem!.name,
                avatarPath: mem!.avatarPath,
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
                value: pageData.getLatestRecord().getValue().toStringAsFixed(2),
                time: DateFormat('dd.MM.yyyy')
                    .format(pageData.getLatestRecord().getDateTime())),
          if (pageData.getMoreInfo().getContent() != "")
            IndicatorMoreInfo(information: customMoreInfo()),
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
            content: [S.of(context).Year, S.of(context).All_time],
            index: data.getFilter().getFilterIndex(),
            onIndexChange: (index) => BlocProvider.of<IndicatorCubit>(context)
                .updateData(data, IndicatorFilter(index, DateTime.now()),
                    id: mem?.id),
            colorID: 0,
          ),
          if (data.getFilter().getFilterIndex() == 0)
            buildNextPreviousBar(data, context),
          SizedBox(height: 24),
          if (loading) Center(child: CircularProgressIndicator()),
          if (!loading) buildDetailContent(data, context)
        ]));
  }

  // Child Component
  Widget buildNextPreviousBar(IndicatorPageData data, BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 24),
        child: NextPreviousBar(
            content: data.getFilter().getTime().year.toString(),
            increase: () {
              if (data.getFilter().getTime().year < DateTime.now().year)
                BlocProvider.of<IndicatorCubit>(context).updateData(
                    data,
                    IndicatorFilter(0,
                        IndicatorLogic.addYear(data.getFilter().getTime(), 1)),
                    id: mem?.id);
            },
            decrease: () {
              if (data.getFilter().getTime().year > 1900)
                BlocProvider.of<IndicatorCubit>(context).updateData(
                    data,
                    IndicatorFilter(0,
                        IndicatorLogic.addYear(data.getFilter().getTime(), -1)),
                    id: mem?.id);
            }));
  }

  Widget buildDetailContent(IndicatorPageData data, BuildContext context) {
    return Column(children: [
      if (data.getData().length == 0)
        Text(S.of(context).no_indicator_record,
            style: Theme.of(context).textTheme.bodyText2),
      if (data.getData().length > 1)
        IndicatorLineChart(
            filterIndex: data.getFilter().getFilterIndex(),
            indicatorIndex: 0,
            data: data.getFilter().getFilterIndex() == 0
                ? IndicatorLogic.convertToMonthChartLatestData(data.getData())
                : IndicatorLogic.convertToYearChartHeightData(data.getData())),
      if (data.getData().length > 1) SizedBox(height: 24),
      if (data.getData().length != 0)
        IndicatorDetailRecords(
            unit: unit,
            dateTimeFormat:
                (data.getFilter().getFilterIndex() == 0) ? 'dd.MM' : 'yyyy',
            data: data.getData(),
            fixed: 2,
            onTap: (index) => onDetailTap(context, index, data),
            isDirection: (data.getFilter().getFilterIndex() == 1))
    ]);
  }

  // Hepper function
  void onDetailTap(BuildContext context, int index, IndicatorPageData data) {
    if (data.getFilter().getFilterIndex() == 0) {
      showPopup(context, index, data);
      return;
    }
    BlocProvider.of<IndicatorCubit>(context).updateData(
        data, IndicatorFilter(0, data.getData()[index].getDateTime()),
        id: mem?.id);
  }

  void showPopup(BuildContext context, int index, IndicatorPageData pageData) {
    showDialog(
        context: context,
        builder: (_) => IndicatorDetailPopup(
            title: S.of(context).Height,
            value: pageData.getData()[index].getValue().toStringAsFixed(2),
            unit: unit,
            time: DateFormat('hh:mm dd.MM.yyyy')
                .format(pageData.getData()[index].getDateTime()),
            recordID: pageData.getData()[index].getRecordID(),
            delete: (mem != null)
                ? null
                : () => popupDelete(context, index, pageData),
            edit: (mem != null)
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
                      .updateData(data, data.getFilter(), id: mem?.id);
                ShowSnackBar.showSuccessSnackBar(context,
                    "${S.of(context).Delete_height} ${S.of(context).successfully}");
              });
              Navigator.pop(context);
            }));
  }

  void popupEdit(BuildContext context, int index, IndicatorPageData data) {
    {
      Navigator.pop(context);
      showModalBottomSheet(
          enableDrag: false,
          isDismissible: true,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          context: context,
          builder: (_) => IndicatorEditBottomSheet(
              title: S.of(context).Edit_height,
              indicator: S.of(context).Height,
              dataPicker: IndicatorDataPicker.height(),
              subDataPicker: IndicatorDataPicker.sub99(),
              indexPicker: (data.getData()[index].getValue() ~/ 1).toInt(),
              subIndexPicker:
                  ((data.getData()[index].getValue() * 100) % 100).toInt(),
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
                            indexPicker + subIndexPicker / 100, time, ''),
                        data.getOwnerID())
                    .then((value) {
                  BlocProvider.of<IndicatorCubit>(context)
                      .updateData(data, data.getFilter(), id: mem?.id);
                  ShowSnackBar.showSuccessSnackBar(
                      context,
                      S.of(context).Edit_height +
                          ' ' +
                          S.of(context).successfully +
                          '!');
                });
                Navigator.pop(context);
              }));
    }
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
    int formatLatest = 1;
    int subFormatLatest = 60;
    if (state.data.getLatestRecord().getValue() != 0) {
      formatLatest = (state.data.getLatestRecord().getValue() ~/ 1).toInt();
      subFormatLatest =
          ((state.data.getLatestRecord().getValue() * 100) % 100).toInt();
    }
    return showModalBottomSheet(
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        context: context,
        builder: (_) => IndicatorEditBottomSheet(
            title: S.of(context).Add_height,
            indicator: S.of(context).Height,
            dataPicker: IndicatorDataPicker.height(),
            subDataPicker: IndicatorDataPicker.sub99(),
            indexPicker: formatLatest,
            subIndexPicker: subFormatLatest,
            dateTime: DateTime.now(),
            isDate: true,
            unit: unit,
            cancel: () => Navigator.pop(context),
            ok: (indexPicker, subIndexPicker, time) => addRecord(
                context, indexPicker + subIndexPicker / 100, time, state)));
  }

  void addRecord(BuildContext context, double indexPicker, DateTime time,
      IndicatorState state) {
    BlocProvider.of<IndicatorCubit>(context)
        .addIndicator(0, IndicatorData(indexPicker, time, ""))
        .then((value) {
      if (value)
        ShowSnackBar.showSuccessSnackBar(context,
            S.of(context).Add_height + ' ' + S.of(context).successfully + '!');
      BlocProvider.of<IndicatorCubit>(context)
          .updateData(state.data, state.data.getFilter(), id: mem?.id);
    });
    Navigator.pop(context);
  }

  MoreInfo customMoreInfo() {
    return MoreInfo(
        "Theo kết quả Tổng điều tra dinh dưỡng năm 2019-2020, chiều cao trung bình nam thanh niên là 168,1cm và nữ là 156,2 cm.",
        "");
    MoreInfo moreInfo = MoreInfo("", "");
    if (user.yOB == -1) {
      moreInfo.content = "todo";
      return moreInfo;
    }
    int age = DateTime.now().year - user.yOB;
    // Male
    if (user.sex == 1) {
      switch (age) {
        case (1):
          {
            moreInfo.content = "todo";
            break;
          }
        default:
          {
            moreInfo.content = "todo";
            break;
          }
      }
    }
    // Female
    if (user.sex == 1) {
      switch (age) {
        case (1):
          {
            moreInfo.content = "todo";
            break;
          }
        default:
          {
            moreInfo.content = "todo";
            break;
          }
      }
    }
    return moreInfo;
  }
}
