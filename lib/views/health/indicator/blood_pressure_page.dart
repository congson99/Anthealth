import 'package:anthealth_mobile/blocs/app_states.dart';

import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/health/indicator_cubit.dart';
import 'package:anthealth_mobile/blocs/health/indicator_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/dateTime_logic.dart';
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
import 'package:anthealth_mobile/views/health/indicator/widgets/blood_pressure_line_chart.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicatorMoreInfo.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_detail_popup.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_detail_records.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_edit_bottom_sheet.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_latest_record.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BloodPressurePage extends StatelessWidget {
  const BloodPressurePage(
      {Key? key, this.dashboardContext, this.mem, required this.user})
      : super(key: key);

  final BuildContext? dashboardContext;
  final String unit = 'mmHg';
  final User user;
  final FamilyMemberData? mem;

  @override
  Widget build(BuildContext context) => BlocProvider<IndicatorCubit>(
      create: (context) =>
          IndicatorCubit(4, 0, id: (mem == null) ? null : mem?.id),
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
                title: S.of(context).Blood_pressure,
                back: () => back(context),
                add: (state is IndicatorState)
                    ? (() => add(context, state))
                    : null,
                content: buildContent(
                    context, pageData, state is IndicatorLoadingState));
          else
            return TemplateAvatarFormPage(
                firstTitle: S.of(context).Blood_pressure,
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
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if ((pageData.getLatestRecord().getValue() != 0))
        IndicatorLatestRecord(
            unit: unit,
            value: formatToShow(pageData.getLatestRecord().getValue()),
            time: DateFormat('HH:mm dd.MM.yyyy')
                .format(pageData.getLatestRecord().getDateTime())),
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
            content: [
              S.of(context).Hour,
              S.of(context).Day,
              S.of(context).All_time
            ],
            index: data.getFilter().getFilterIndex(),
            onIndexChange: (index) => BlocProvider.of<IndicatorCubit>(context)
                .updateData(data, IndicatorFilter(index, DateTime.now()),
                    id: mem?.id),
            colorID: 0,
          ),
          if (data.getFilter().getFilterIndex() == 0)
            buildHourNextPreviousBar(data, context),
          if (data.getFilter().getFilterIndex() == 1)
            buildDayNextPreviousBar(data, context),
          SizedBox(height: 24),
          if (loading) Center(child: CircularProgressIndicator()),
          if (!loading) buildDetailContent(data, context)
        ]));
  }

  Widget buildHourNextPreviousBar(
      IndicatorPageData data, BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 24),
        child: NextPreviousBar(
            content:
                DateTimeLogic.formatHourToHour(data.getFilter().getTime()) +
                    DateFormat(" (dd.MM)").format(data.getFilter().getTime()),
            increase: () {
              if (DateTimeLogic.compareHourWithNow(data.getFilter().getTime()))
                BlocProvider.of<IndicatorCubit>(context).updateData(
                    data,
                    IndicatorFilter(0,
                        IndicatorLogic.addHour(data.getFilter().getTime(), 1)),
                    id: mem?.id);
            },
            decrease: () {
              if (data.getFilter().getTime().year > 1900)
                BlocProvider.of<IndicatorCubit>(context).updateData(
                    data,
                    IndicatorFilter(0,
                        IndicatorLogic.addHour(data.getFilter().getTime(), -1)),
                    id: mem?.id);
            }));
  }

  Widget buildDayNextPreviousBar(IndicatorPageData data, BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 24),
        child: NextPreviousBar(
            content: DateTimeLogic.todayFormat(
                context, data.getFilter().getTime(), "dd.MM.yyyy"),
            increase: () {
              if (DateTimeLogic.compareDayWithNow(data.getFilter().getTime()))
                BlocProvider.of<IndicatorCubit>(context).updateData(
                    data,
                    IndicatorFilter(1,
                        IndicatorLogic.addDay(data.getFilter().getTime(), 1)),
                    id: mem?.id);
            },
            decrease: () {
              if (data.getFilter().getTime().year > 1900)
                BlocProvider.of<IndicatorCubit>(context).updateData(
                    data,
                    IndicatorFilter(1,
                        IndicatorLogic.addDay(data.getFilter().getTime(), -1)),
                    id: mem?.id);
            }));
  }

  Widget buildDetailContent(IndicatorPageData data, BuildContext context) {
    return Column(children: [
      if (data.getData().length == 0)
        Text(S.of(context).no_indicator_record,
            style: Theme.of(context).textTheme.bodyText2),
      if (data.getData().length > 1)
        BloodPressureLineChart(
          filterIndex: data.getFilter().getFilterIndex(),
          data: (data.getFilter().getFilterIndex() == 0)
              ? IndicatorLogic.convertToRecordChart10Data(data.getData())
              : (data.getFilter().getFilterIndex() == 1)
                  ? IndicatorLogic.convertToHourChartData(data.getData())
                  : IndicatorLogic.convertToDayChartData(data.getData()),
          max1: getMax1(),
          max2: getMax2(),
        ),
      if (data.getData().length > 1) buildNote(context),
      if (data.getData().length != 0)
        IndicatorDetailRecords(
            unit: unit,
            dateTimeFormat: (data.getFilter().getFilterIndex() == 0)
                ? 'HH:mm'
                : (data.getFilter().getFilterIndex() == 1)
                    ? 'hh-hh'
                    : 'dd.MM',
            data: data.getData(),
            fixed: 10,
            onTap: (index) => onDetailTap(context, index, data),
            isDirection: (data.getFilter().getFilterIndex() != 0))
    ]);
  }

  Widget buildNote(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 8, bottom: 32),
        decoration: BoxDecoration(
            color: AnthealthColors.primary4.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16)),
        child: Column(children: [
          Row(children: [
            Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: AnthealthColors.secondary2,
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(5))),
            Container(height: 2, width: 36, color: AnthealthColors.secondary2),
            Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: AnthealthColors.secondary2,
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(5))),
            SizedBox(width: 8),
            Text(S.of(context).Systolic_blood_pressure,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2)
          ]),
          SizedBox(height: 4),
          Row(children: [
            Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: AnthealthColors.primary2,
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(5))),
            Container(height: 2, width: 36, color: AnthealthColors.primary2),
            Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: AnthealthColors.primary2,
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(5))),
            SizedBox(width: 8),
            Text(S.of(context).Diastolic_blood_pressure,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2)
          ]),
          SizedBox(height: 4),
          Row(children: [
            SizedBox(width: 28, child: Text(getMax1().toStringAsFixed(0))),
            Container(height: 1.5, width: 28, color: AnthealthColors.warning2),
            SizedBox(width: 8),
            Text(S.of(context).High_systolic_blood_pressure,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2)
          ]),
          SizedBox(height: 4),
          Row(children: [
            SizedBox(width: 28, child: Text(getMax2().toStringAsFixed(0))),
            Container(height: 1.5, width: 28, color: AnthealthColors.warning2),
            SizedBox(width: 8),
            Text(S.of(context).High_diastolic_blood_pressure,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2)
          ])
        ]));
  }

  // Helper function
  void onDetailTap(BuildContext context, int index, IndicatorPageData data) {
    if (data.getFilter().getFilterIndex() == 0) {
      showPopup(context, index, data);
      return;
    }
    if (data.getFilter().getFilterIndex() == 1) {
      BlocProvider.of<IndicatorCubit>(context).updateData(
          data, IndicatorFilter(0, data.getData()[index].getDateTime()),
          id: mem?.id);
    } else {
      BlocProvider.of<IndicatorCubit>(context).updateData(
          data, IndicatorFilter(1, data.getData()[index].getDateTime()),
          id: mem?.id);
    }
  }

  void showPopup(BuildContext context, int index, IndicatorPageData pageData) {
    showDialog(
        context: context,
        builder: (_) => IndicatorDetailPopup(
            title: S.of(context).Blood_pressure,
            value: formatToShow(pageData.getData()[index].getValue()),
            unit: unit,
            time: DateFormat('HH:mm dd.MM.yyyy')
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

  String formatToShow(double value) {
    return (value ~/ 1).toString() +
        '/' +
        ((value * 1000) % 1000).toStringAsFixed(0);
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
                ShowSnackBar.showSuccessSnackBar(
                    context,
                    S.of(context).Delete_blood_pressure +
                        ' ' +
                        S.of(context).successfully +
                        '!');
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
            title: S.of(context).Edit_blood_pressure,
            indicator: S.of(context).Blood_pressure,
            dataPicker: IndicatorDataPicker.bloodPressure(),
            subDataPicker: IndicatorDataPicker.bloodPressure(),
            indexPicker: (data.getData()[index].getValue() ~/ 1).toInt(),
            subIndexPicker:
                ((data.getData()[index].getValue() * 1000) % 1000).toInt(),
            dateTime: data.getData()[index].getDateTime(),
            isDate: true,
            isTime: true,
            unit: unit,
            middleSymbol: '/',
            cancel: () => Navigator.pop(context),
            ok: (indexPicker, subIndexPicker, time) {
              BlocProvider.of<IndicatorCubit>(context)
                  .editIndicator(
                      data.getType(),
                      data.getData()[index],
                      IndicatorData(
                          indexPicker + subIndexPicker / 1000, time, ''),
                      data.getOwnerID())
                  .then((value) {
                BlocProvider.of<IndicatorCubit>(context)
                    .updateData(data, data.getFilter(), id: mem?.id);
                ShowSnackBar.showSuccessSnackBar(
                    context,
                    S.of(context).Edit_blood_pressure +
                        ' ' +
                        S.of(context).successfully +
                        '!');
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
    int formatLatest = 120;
    int subFormatLatest = 80;
    if (state.data.getLatestRecord().getValue() != 0) {
      formatLatest = (state.data.getLatestRecord().getValue() ~/ 1).toInt();
      subFormatLatest =
          ((state.data.getLatestRecord().getValue() * 1000) % 1000).toInt();
    }
    return showModalBottomSheet(
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        context: context,
        builder: (_) => IndicatorEditBottomSheet(
            title: S.of(context).Add_blood_pressure,
            indicator: S.of(context).Blood_pressure,
            dataPicker: IndicatorDataPicker.bloodPressure(),
            subDataPicker: IndicatorDataPicker.bloodPressure(),
            indexPicker: formatLatest,
            subIndexPicker: subFormatLatest,
            dateTime: DateTime.now(),
            isDate: true,
            isTime: true,
            unit: unit,
            middleSymbol: '/',
            cancel: () => Navigator.pop(context),
            ok: (indexPicker, subIndexPicker, time) => addRecord(
                context, indexPicker + subIndexPicker / 1000, time, state)));
  }

  void addRecord(BuildContext context, double indexPicker, DateTime time,
      IndicatorState state) {
    BlocProvider.of<IndicatorCubit>(context)
        .addIndicator(4, IndicatorData(indexPicker, time, ""))
        .then((value) {
      if (value)
        ShowSnackBar.showSuccessSnackBar(
            context,
            S.of(context).Add_blood_pressure +
                ' ' +
                S.of(context).successfully +
                '!');

      BlocProvider.of<IndicatorCubit>(context)
          .updateData(state.data, state.data.getFilter(), id: mem?.id);
    });
    Navigator.pop(context);
  }

  MoreInfo customMoreInfo() {
    MoreInfo moreInfo = MoreInfo("", "assets/hardData/blood_pressure.json");
    if (user.yOB == -1) {
      moreInfo.content =
          "Huyết áp bình thường được xác định khi: Huyết áp tâm thu từ 90 mmHg đến 129 mmHg và huyết áp tâm trương từ 60 mmHg đến 84 mmHg.";
      return moreInfo;
    }
    int age = DateTime.now().year - user.yOB;
    if (age >= 1 && age <= 5) {
      moreInfo.content =
          "Chỉ số huyết áp thấp là 80/55, huyết áp trung bình là 95/65, huyết áp cao là 110/79.";
    } else if (age >= 6 && age <= 13) {
      moreInfo.content =
          "Chỉ số huyết áp thấp là 90/60, huyết áp trung bình là 105/70, huyết áp cao là 115/80.";
    } else if (age >= 14 && age <= 19) {
      moreInfo.content =
          "Chỉ số huyết áp thấp là 105/73, huyết áp trung bình là 117/77, huyết áp cao là 120/81.";
    } else if (age >= 20 && age <= 24) {
      moreInfo.content =
          "Chỉ số huyết áp thấp là 108/75, huyết áp trung bình là 120/79, huyết áp cao là 132/83.";
    } else if (age >= 25 && age <= 29) {
      moreInfo.content =
          "Chỉ số huyết áp thấp là 109/76, huyết áp trung bình là 121/80, huyết áp cao là 133/84.";
    } else if (age >= 30 && age <= 34) {
      moreInfo.content =
          "Chỉ số huyết áp thấp là 110/77, huyết áp trung bình là 122/81, huyết áp cao là 134/85.";
    } else if (age >= 35 && age <= 39) {
      moreInfo.content =
          "Chỉ số huyết áp thấp là 111/78, huyết áp trung bình là 123/82, huyết áp cao là 135/86.";
    } else if (age >= 40 && age <= 44) {
      moreInfo.content =
          "Chỉ số huyết áp thấp là 112/79, huyết áp trung bình là 125/83, huyết áp cao là 137/87.";
    } else if (age >= 45 && age <= 49) {
      moreInfo.content =
          "Chỉ số huyết áp thấp là 115/80, huyết áp trung bình là 127/84, huyết áp cao là 139/88.";
    } else if (age >= 50 && age <= 54) {
      moreInfo.content =
          "Chỉ số huyết áp thấp là 116/81, huyết áp trung bình là 129/85, huyết áp cao là 142/89.";
    } else if (age >= 55 && age <= 59) {
      moreInfo.content =
          "Chỉ số huyết áp thấp là 118/82, huyết áp trung bình là 131/86, huyết áp cao là 144/90.";
    } else if (age >= 60 && age <= 64) {
      moreInfo.content =
          "Chỉ số huyết áp thấp là 121/83, huyết áp trung bình là 134/87, huyết áp cao là 147/91.";
    } else {
      moreInfo.content =
          "Huyết áp bình thường được xác định khi: Huyết áp tâm thu từ 90 mmHg đến 129 mmHg và huyết áp tâm trương từ 60 mmHg đến 84 mmHg.";
    }
    return moreInfo;
  }

  double getMax1() {
    double value = 140;
    int age = DateTime.now().year - user.yOB;
    if (age >= 1 && age <= 5) {
      value = 110;
    } else if (age >= 6 && age <= 13) {
      value = 115;
    } else if (age >= 14 && age <= 19) {
      value = 120;
    } else if (age >= 20 && age <= 24) {
      value = 132;
    } else if (age >= 25 && age <= 29) {
      value = 133;
    } else if (age >= 30 && age <= 34) {
      value = 134;
    } else if (age >= 35 && age <= 39) {
      value = 135;
    } else if (age >= 40 && age <= 44) {
      value = 137;
    } else if (age >= 45 && age <= 49) {
      value = 139;
    } else if (age >= 50 && age <= 54) {
      value = 142;
    } else if (age >= 55 && age <= 59) {
      value = 144;
    } else if (age >= 60 && age <= 64) {
      value = 147;
    }
    return value;
  }

  double getMax2() {
    double value = 140;
    int age = DateTime.now().year - user.yOB;
    if (age >= 1 && age <= 5) {
      value = 79;
    } else if (age >= 6 && age <= 13) {
      value = 80;
    } else if (age >= 14 && age <= 19) {
      value = 81;
    } else if (age >= 20 && age <= 24) {
      value = 83;
    } else if (age >= 25 && age <= 29) {
      value = 84;
    } else if (age >= 30 && age <= 34) {
      value = 85;
    } else if (age >= 35 && age <= 39) {
      value = 86;
    } else if (age >= 40 && age <= 44) {
      value = 87;
    } else if (age >= 45 && age <= 49) {
      value = 88;
    } else if (age >= 50 && age <= 54) {
      value = 89;
    } else if (age >= 55 && age <= 59) {
      value = 90;
    } else if (age >= 60 && age <= 64) {
      value = 91;
    }
    return value;
  }
}
