import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/health/indicator_cubit.dart';
import 'package:anthealth_mobile/blocs/health/indicator_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/health/indicator_models.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_appbar.dart';
import 'package:anthealth_mobile/views/common_widgets/next_previous_bar.dart';
import 'package:anthealth_mobile/views/common_widgets/switch_bar.dart';
import 'package:anthealth_mobile/views/common_widgets/warning_popup.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_detail_popup.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_detail_records.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_edit_bottom_sheet.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_latest_record.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_line_chart.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HeightPage extends StatefulWidget {
  const HeightPage({Key? key}) : super(key: key);

  final String unit = 'm';

  @override
  _HeightPageState createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<IndicatorCubit>(
        create: (context) => IndicatorCubit(0, DateTime.now().year),
        child:
            BlocBuilder<IndicatorCubit, CubitState>(builder: (context, state) {
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
  }

  // AppBar
  CustomAppBar buildAppBar(BuildContext context, CubitState state) {
    return CustomAppBar(
        title: S.of(context).Height,
        back: () => Navigator.pop(context),
        add: () {
          buildAddIndicatorBottomSheet(context, state);
        },
        settings: () {});
  }

  // Content
  Widget buildContent(
          BuildContext context, IndicatorPageData pageData, bool loading) =>
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IndicatorLatestRecord(
                unit: widget.unit,
                value: (pageData.getLatestRecord().getValue() == 0)
                    ? ''
                    : pageData.getLatestRecord().getValue().toString(),
                time: DateFormat('dd.MM.yyyy')
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
                  content: [S.of(context).Year, S.of(context).All_time],
                  index: data.getFilter().getFilterIndex(),
                  onIndexChange: (index) =>
                      BlocProvider.of<IndicatorCubit>(context).updateData(
                          data, IndicatorFilter(index, DateTime.now().year)),
                  colorID: 0,
                ),
                if (data.getFilter().getFilterIndex() == 0)
                  buildNextPreviousBar(data, context),
                SizedBox(height: 24),
                if (loading) Center(child: CircularProgressIndicator()),
                if (!loading) buildDetailContent(data, context)
              ]));

  Widget buildNextPreviousBar(IndicatorPageData data, BuildContext context) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24),
          NextPreviousBar(
              content: data.getFilter().getFilterValue().toString(),
              increse: () {
                if (data.getFilter().getFilterValue() < DateTime.now().year)
                  BlocProvider.of<IndicatorCubit>(context).updateData(
                      data,
                      IndicatorFilter(
                          0, data.getFilter().getFilterValue() + 1));
              },
              decrese: () {
                if (data.getFilter().getFilterValue() > 1900)
                  BlocProvider.of<IndicatorCubit>(context).updateData(
                      data,
                      IndicatorFilter(
                          0, data.getFilter().getFilterValue() - 1));
              }),
        ],
      );
  Widget buildDetailContent(IndicatorPageData data, BuildContext context) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (data.getData().length == 0)
              Text(S.of(context).no_indicator_record,
                  style: Theme.of(context).textTheme.bodyText2),
            if (data.getData().length > 1)
              IndicatorLineChart(
                  filterIndex: data.getFilter().getFilterIndex(),
                  indicatorIndex: 0,
                  data: data.getFilter().getFilterIndex() == 0
                      ? IndicatorPageData.convertToMonthChartLatestData(
                          data.getData())
                      : IndicatorPageData.convertToYearChartData(
                          data.getData())),
            if (data.getData().length > 1) SizedBox(height: 24),
            if (data.getData().length != 0)
              IndicatorDetailRecords(
                  unit: widget.unit,
                  dateTimeFormat: (data.getFilter().getFilterIndex() == 0)
                      ? 'dd.MM'
                      : 'yyyy',
                  data: data.getData(),
                  onTap: (index) => onDetailTap(context, index, data),
                  isDirection: (data.getFilter().getFilterIndex() == 1))
          ]);


  // Hepper function
  Future<dynamic> buildAddIndicatorBottomSheet(
      BuildContext context, CubitState state) {
    int formatLatest = (state is IndicatorState)
        ? (state.data.getLatestRecord().getValue() * 100).toInt()
        : 0;
    if (formatLatest == 0) formatLatest = 100;
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
            indexPicker: 250 - formatLatest,
            dateTime: DateTime.now(),
            isDate: true,
            unit: widget.unit,
            cancel: () => Navigator.pop(context),
            ok: (indexPicker, time) =>
                addRecord(context, indexPicker, time, state)));
  }

  void addRecord(
      BuildContext context, int indexPicker, DateTime time, CubitState state) {
    BlocProvider.of<IndicatorCubit>(context)
        .addIndicator(0, IndicatorData(indexPicker / 100, time, ""))
        .then((value) {
      if (value)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(S.of(context).Add_height +
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
    if (data.getFilter().getFilterIndex() == 1) {
      BlocProvider.of<IndicatorCubit>(context).updateData(
          data, IndicatorFilter(0, data.getData()[index].getDateTime().year));
    } else
      showPopup(index, data.getData());
  }

  void showPopup(int index, List<IndicatorData> data) {
    showDialog(
        context: context,
        builder: (_) => IndicatorDetailPopup(
            title: S.of(context).Height,
            value: data[index].getValue().toString(),
            unit: widget.unit,
            time: DateFormat('hh:mm dd.MM.yyyy')
                .format(data[index].getDateTime()),
            recordID: data[index].getRecordID(),
            delete: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (_) => WarningPopup(
                      title: S.of(context).Warning_delete_data,
                      cancel: () => Navigator.pop(context),
                      delete: () {
                        // Todo
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(S.of(context).Delete_height +
                                ' ' +
                                S.of(context).successfully +
                                '!')));
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
                      title: S.of(context).Edit_height,
                      indicator: S.of(context).Height,
                      dataPicker: IndicatorDataPicker.height(),
                      indexPicker: 250,
                      dateTime: data[index].getDateTime(),
                      isDate: true,
                      unit: widget.unit,
                      cancel: () => Navigator.pop(context),
                      ok: (indexPicker, time) {
                        //TOdo
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(S.of(context).Edit_height +
                                ' ' +
                                S.of(context).successfully +
                                '!')));
                      }));
            },
            close: () => Navigator.pop(context)));
  }
}
