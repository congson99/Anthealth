import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/common_logic/dateTime_logic.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/health/indicator_cubit.dart';
import 'package:anthealth_mobile/blocs/health/indicator_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/health/indicator_models.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_appbar.dart';
import 'package:anthealth_mobile/views/common_widgets/next_previous_bar.dart';
import 'package:anthealth_mobile/views/common_widgets/switch_bar.dart';
import 'package:anthealth_mobile/views/common_widgets/warning_popup.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/blood_pressure_line_chart.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_detail_popup.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_detail_records.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_edit_bottom_sheet.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_latest_record.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_line_chart.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BloodPressurePage extends StatelessWidget {
  const BloodPressurePage({Key? key, required this.dashboardContext})
      : super(key: key);

  final BuildContext dashboardContext;
  final String unit = 'mmHg';

  @override
  Widget build(BuildContext context) => BlocProvider<IndicatorCubit>(
      create: (context) => IndicatorCubit(4),
      child: BlocBuilder<IndicatorCubit, CubitState>(builder: (context, state) {
        if (state is IndicatorState)
          return Scaffold(
              body: SafeArea(
                  child: Stack(children: [
            Container(
                margin: (state.data.getLatestRecord().getValue() != 0)
                    ? EdgeInsets.only(top: 65)
                    : EdgeInsets.only(top: 16),
                child: SingleChildScrollView(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: buildContent(context, state.data, false)))),
            buildAppBar(context, state)
          ])));
        if (state is IndicatorLoadingState)
          return Scaffold(
              body: SafeArea(
                  child: Stack(children: [
            Container(
                margin: (state.data.getLatestRecord().getValue() != 0)
                    ? EdgeInsets.only(top: 65)
                    : EdgeInsets.only(top: 16),
                child: SingleChildScrollView(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: buildContent(context, state.data, true)))),
            buildAppBar(context, state)
          ])));
        else
          return LoadingPage();
      }));

  // AppBar
  Widget buildAppBar(BuildContext context, CubitState state) => CustomAppBar(
      title: S.of(context).Blood_pressure,
      back: () {
        BlocProvider.of<DashboardCubit>(dashboardContext).health();
        Navigator.pop(context);
      },
      add: () {
        buildAddIndicatorBottomSheet(context, state);
      },
      settings: () {});

  // Content
  Widget buildContent(
          BuildContext context, IndicatorPageData pageData, bool loading) =>
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IndicatorLatestRecord(
                unit: unit,
                value: (pageData.getLatestRecord().getValue() == 0)
                    ? ''
                    : formatToShow(pageData.getLatestRecord().getValue()),
                time: DateFormat('HH:mm dd.MM.yyyy')
                    .format(pageData.getLatestRecord().getDateTime()),
                information: pageData.getMoreInfo()),
            buildDetailContainer(context, pageData, loading),
            SizedBox(height: 32)
          ]);

  // Child Component
  Widget buildDetailContainer(
          BuildContext context, IndicatorPageData data, bool loading) =>
      Container(
          decoration: BoxDecoration(
              color: AnthealthColors.primary5,
              borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SwitchBar(
                  content: [
                    S.of(context).Hour,
                    S.of(context).Day,
                    S.of(context).All_time
                  ],
                  index: data.getFilter().getFilterIndex(),
                  onIndexChange: (index) =>
                      BlocProvider.of<IndicatorCubit>(context).updateData(
                          data, IndicatorFilter(index, DateTime.now())),
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

  Widget buildHourNextPreviousBar(
          IndicatorPageData data, BuildContext context) =>
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            NextPreviousBar(
                content:
                    DateTimeLogic.formatHourToHour(data.getFilter().getTime()) +
                        DateFormat(" (dd.MM)")
                            .format(data.getFilter().getTime()),
                increse: () {
                  if (DateTimeLogic.compareHourWithNow(
                      data.getFilter().getTime()))
                    BlocProvider.of<IndicatorCubit>(context).updateData(
                        data,
                        IndicatorFilter(
                            0,
                            IndicatorFilter.addHour(
                                data.getFilter().getTime(), 1)));
                },
                decrese: () {
                  if (data.getFilter().getTime().year > 1900)
                    BlocProvider.of<IndicatorCubit>(context).updateData(
                        data,
                        IndicatorFilter(
                            0,
                            IndicatorFilter.addHour(
                                data.getFilter().getTime(), -1)));
                })
          ]);

  Widget buildDayNextPreviousBar(
          IndicatorPageData data, BuildContext context) =>
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            NextPreviousBar(
                content:
                    DateFormat("dd.MM.yyyy").format(data.getFilter().getTime()),
                increse: () {
                  if (DateTimeLogic.compareDayWithNow(
                      data.getFilter().getTime()))
                    BlocProvider.of<IndicatorCubit>(context).updateData(
                        data,
                        IndicatorFilter(
                            1,
                            IndicatorFilter.addDay(
                                data.getFilter().getTime(), 1)));
                },
                decrese: () {
                  if (data.getFilter().getTime().year > 1900)
                    BlocProvider.of<IndicatorCubit>(context).updateData(
                        data,
                        IndicatorFilter(
                            1,
                            IndicatorFilter.addDay(
                                data.getFilter().getTime(), -1)));
                })
          ]);

  Widget buildDetailContent(IndicatorPageData data, BuildContext context) =>
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (data.getData().length == 0)
              Text(S.of(context).no_indicator_record,
                  style: Theme.of(context).textTheme.bodyText2),
            if (data.getData().length > 1)
              BloodPressureLineChart(
                  filterIndex: data.getFilter().getFilterIndex(),
                  data: (data.getFilter().getFilterIndex() == 0)
                      ? IndicatorPageData.convertToRecordChart10Data(
                          data.getData())
                      : (data.getFilter().getFilterIndex() == 1)
                          ? IndicatorPageData.convertToHourChartData(
                              data.getData())
                          : IndicatorPageData.convertToDayChartData(
                              data.getData())),
            if (data.getData().length > 1) SizedBox(height: 24),
            if (data.getData().length != 0)
              IndicatorDetailRecords(
                  unit: unit,
                  dateTimeFormat: (data.getFilter().getFilterIndex() == 0)
                      ? 'HH:mm'
                      : (data.getFilter().getFilterIndex() == 1)
                          ? 'hh-hh'
                          : 'dd.MM.yyyy',
                  data: data.getData(),
                  fixed: 10,
                  onTap: (index) => onDetailTap(context, index, data),
                  isDirection: (data.getFilter().getFilterIndex() != 0))
          ]);

  // Hepper function
  Future<dynamic> buildAddIndicatorBottomSheet(
      BuildContext context, CubitState state) {
    int formatLatest = 120;
    int subFormatLatest = 80;
    if (state is IndicatorState &&
        state.data.getLatestRecord().getValue() != 0) {
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
      CubitState state) {
    BlocProvider.of<IndicatorCubit>(context)
        .addIndicator(4, IndicatorData(indexPicker, time, ""))
        .then((value) {
      if (value)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(S.of(context).Add_blood_pressure +
                ' ' +
                S.of(context).successfully +
                '!')));
      if (state is IndicatorState)
        BlocProvider.of<IndicatorCubit>(context)
            .updateData(state.data, state.data.getFilter());
    });
    Navigator.pop(context);
  }

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

  void showPopup(BuildContext context, int index, IndicatorPageData data) {
    showDialog(
        context: context,
        builder: (_) => IndicatorDetailPopup(
            title: S.of(context).Blood_pressure,
            value: formatToShow(data.getData()[index].getValue()),
            unit: unit,
            time: DateFormat('HH:mm dd.MM.yyyy')
                .format(data.getData()[index].getDateTime()),
            recordID: data.getData()[index].getRecordID(),
            delete: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (_) => WarningPopup(
                      title: S.of(context).Warning_delete_data,
                      cancel: () => Navigator.pop(context),
                      delete: () {
                        BlocProvider.of<IndicatorCubit>(context)
                            .deleteIndicator(data.getType(),
                                data.getData()[index], data.getOwnerID())
                            .then((value) {
                          if (value)
                            BlocProvider.of<IndicatorCubit>(context)
                                .updateData(data, data.getFilter());
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  S.of(context).Delete_blood_pressure +
                                      ' ' +
                                      S.of(context).successfully +
                                      '!')));
                        });
                        Navigator.pop(context);
                      }));
            },
            edit: () {
              Navigator.pop(context);
              showModalBottomSheet(
                  enableDrag: false,
                  isDismissible: true,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16))),
                  context: context,
                  builder: (_) => IndicatorEditBottomSheet(
                      title: S.of(context).Edit_blood_pressure,
                      indicator: S.of(context).Blood_pressure,
                      dataPicker: IndicatorDataPicker.bloodPressure(),
                      subDataPicker: IndicatorDataPicker.bloodPressure(),
                      indexPicker:
                          (data.getLatestRecord().getValue() ~/ 1).toInt(),
                      subIndexPicker:
                          ((data.getLatestRecord().getValue() * 1000) % 1000)
                              .toInt(),
                      dateTime: data.getData()[index].getDateTime(),
                      isDate: true,
                      unit: unit,
                      middleSymbol: '/',
                      cancel: () => Navigator.pop(context),
                      ok: (indexPicker, subIndexPicker, time) {
                        BlocProvider.of<IndicatorCubit>(context)
                            .editIndicator(
                                data.getType(),
                                data.getData()[index],
                                IndicatorData(
                                    indexPicker + subIndexPicker / 1000,
                                    time,
                                    ''),
                                data.getOwnerID())
                            .then((value) {
                          BlocProvider.of<IndicatorCubit>(context)
                              .updateData(data, data.getFilter());
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(S.of(context).Edit_blood_pressure +
                                  ' ' +
                                  S.of(context).successfully +
                                  '!')));
                        });
                        Navigator.pop(context);
                      }));
            },
            close: () => Navigator.pop(context)));
  }

  String formatToShow(double value) {
    return (value ~/ 1).toString() +
        '/' +
        ((value * 1000) % 1000).toStringAsFixed(0);
  }
}
