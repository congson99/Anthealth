import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_appbar.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/health/indicator/widgets/indicator_detail_records.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/common_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MedicalRecordPage extends StatefulWidget {
  const MedicalRecordPage({Key? key}) : super(key: key);

  @override
  _MedicalRecordPageState createState() => _MedicalRecordPageState();
}

class _MedicalRecordPageState extends State<MedicalRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      Container(
          margin: const EdgeInsets.only(top: 65),
          child: SingleChildScrollView(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: buildContent(context)))),
      CustomAppBar(
          title: S.of(context).Medical_record,
          back: () => Navigator.pop(context),
          add: () {},
          settings: () {})
    ])));
  }

  Widget buildContent(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CommonText.section(S.of(context).Record, context),
          SizedBox(height: 16),
          buildDetailContainer(context),
          SizedBox(height: 32),
          CommonText.section(S.of(context).Medical_appointment, context),
          SizedBox(height: 16),
          SectionComponent(
              title: "21.02.2022 - BV ĐHYD",
              subTitle: "Lần khám trước: 09.03.2021",
              subSubTitle: "Nội dung: Khám mắt",
              colorID: 1),
          SizedBox(height: 32)
        ]);
  }

  Widget buildDetailContainer(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AnthealthColors.primary5,
            borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IndicatorDetailRecords(
                  unit: S.of(context).Record,
                  dateTimeFormat: '',
                  data: [],
                  onTap: (index) => onDetailTap(index))
            ]));
  }

  void onDetailTap(int index) {
    // if (_filterIndex == 1)
    //   setState(() {
    //     _filterIndex = 0;
    //     _dataIndex = index;
    //   });
    // else
    //   showPopup(index);
  }

// void showPopup(int index) {
//   showDialog(
//       context: context,
//       builder: (_) => IndicatorDetailPopup(
//           title: S.of(context).Height,
//           value: detailData[0][index].value.toString(),
//           unit: widget.unit,
//           time: DateFormat('hh:mm dd.MM.yyyy')
//               .format(detailData[0][index].dateTime),
//           recordID: detailData[0][index].recordID,
//           delete: () {
//             Navigator.pop(context);
//             showDialog(
//                 context: context,
//                 builder: (_) => WarningPopup(
//                     title: S.of(context).Warning_delete_data,
//                     cancel: () => Navigator.pop(context),
//                     delete: () {
//                       setState(() => detailData[0].removeAt(index));
//                       Navigator.pop(context);
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                           content: Text(S.of(context).Delete_height +
//                               ' ' +
//                               S.of(context).successfully +
//                               '!')));
//                     }));
//           },
//           edit: () {
//             Navigator.pop(context);
//             showModalBottomSheet(
//                 enableDrag: false,
//                 isDismissible: true,
//                 isScrollControlled: true,
//                 shape: RoundedRectangleBorder(
//                     borderRadius:
//                         BorderRadius.vertical(top: Radius.circular(16))),
//                 context: context,
//                 builder: (_) => IndicatorEditBottomSheet(
//                     title: S.of(context).Edit_height,
//                     indicator: S.of(context).Height,
//                     dataPicker: _dataPicker,
//                     indexPicker: 250 - detailData[0][index].value,
//                     dateTime: detailData[0][index].dateTime,
//                     isDate: true,
//                     unit: widget.unit,
//                     cancel: () => Navigator.pop(context),
//                     ok: (indexPicker, time) {
//                       setState(() => detailData[0][index] = Indicator(
//                           250 - indexPicker,
//                           time,
//                           detailData[0][index].recordID));
//                       Navigator.pop(context);
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                           content: Text(S.of(context).Edit_height +
//                               ' ' +
//                               S.of(context).successfully +
//                               '!')));
//                     }));
//           },
//           close: () => Navigator.pop(context)));
// }

// List<String> convertToYearSwitchData(List<Indicator> heights) {
//   List<String> result = [];
//   for (Indicator x in heights) result.add(x.dateTime.year.toString());
//   return result;
// }
//
// List<FlSpot> convertToMonthChartData(List<Indicator> heights) {
//   List<int> temp = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
//   for (Indicator x in heights) temp[x.dateTime.month] = x.value;
//   List<FlSpot> result = [];
//   for (int i = 1; i <= 12; i++)
//     if (temp[i] != -1) result.add(FlSpot(i.toDouble(), temp[i].toDouble()));
//   return result;
// }

// List<FlSpot> convertToYearChartData(List<Indicator> heights) {
//   List<FlSpot> result = [];
//   for (Indicator x in heights)
//     result.insert(0, FlSpot(x.dateTime.year.toDouble(), x.value.toDouble()));
//   return result;
// }
//
// List<IndicatorDetailRecord> convertToMonthDetailData(
//     List<Indicator> heights) {
//   List<IndicatorDetailRecord> result = [];
//   for (Indicator x in heights)
//     result.add(IndicatorDetailRecord(DateFormat('dd.MM').format(x.dateTime),
//         (x.value ~/ 100).toString() + '.' + (x.value % 100).toString()));
//   return result;
// }

// List<IndicatorDetailRecord> convertToYearDetailData(List<Indicator> heights) {
//   List<IndicatorDetailRecord> result = [];
//   for (Indicator x in heights)
//     result.add(IndicatorDetailRecord(x.dateTime.year.toString(),
//         (x.value ~/ 100).toString() + '.' + (x.value % 100).toString()));
//   return result;
// }
}
