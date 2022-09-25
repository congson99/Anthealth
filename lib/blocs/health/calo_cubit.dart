import 'dart:convert';

import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/health/calo_states.dart';
import 'package:anthealth_mobile/models/health/calo_models.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaloCubit extends Cubit<CubitState> {
  CaloCubit() : super(InitialState()) {
    loadData();
  }

  /// Handle States
  void loadedData(CaloState state) {
    emit(CaloState(state.data));
  }

  void updateData(CaloState state) {
    emit(InitialState());
    loadedData(state);
  }

  /// Service Functions
  Future<void> loadData() async {
    loadedData(CaloState(CaloDayData(1200, [
      // CaloIn("", DateTime.now(), "Cá ngừ", "100g", 200, 2),
      // CaloIn("", DateTime.now(), "Trứng gà", "quả", 800, 0.5),
      CaloIn("", DateTime.now(), "Cơm", "chén", 500, 1)
    ], [
      CaloOut("", DateTime.now(), "Chạy bộ", 50, 5)
    ])));
  }

  CaloDayData getDayData(DateTime dateTime) {
    return CaloDayData(2000, [
      CaloIn("", DateTime.now(), "Cá ngừ", "100g", 200, 2),
      CaloIn("", DateTime.now(), "Trứng gà", "quả", 800, 0.5),
      CaloIn("", DateTime.now(), "Cơm", "chén", 500, 1)
    ], [
      CaloOut("", DateTime.now(), "Chạy bộ", 50, 5)
    ]);
  }

  List<CaloDayReportData> getMonthReport(DateTime dateTime) {
    return [
      CaloDayReportData(2000, 1800, 200),
      CaloDayReportData(2000, 2200, 800),
      CaloDayReportData(2400, 2500, 0),
      CaloDayReportData(2400, 1700, 200),
      CaloDayReportData(2400, 2900, 900),
      CaloDayReportData(2400, 1200, 0),
      CaloDayReportData(2400, 2700, 500),
      CaloDayReportData(2300, 3200, 200),
      CaloDayReportData(2300, 2900, 300),
      CaloDayReportData(2300, 3500, 200),
    ];
  }

  List<CaloMonthReportData> getYearReport(DateTime dateTime) {
    return [
      CaloMonthReportData(1800, 200),
      CaloMonthReportData(2200, 800),
      CaloMonthReportData(2500, 0),
      CaloMonthReportData(1700, 200),
      CaloMonthReportData(2900, 900),
      CaloMonthReportData(1200, 0),
      CaloMonthReportData(2700, 500),
      CaloMonthReportData(3200, 200),
      CaloMonthReportData(2900, 300),
      CaloMonthReportData(3500, 200),
    ];
  }

  Future<List<CaloIn>> getCaloIn() async {
    var jsonText = await rootBundle.loadString('assets/hardData/calo_in.json');
    List data = json.decode(jsonText);
    List<CaloIn> result = [];
    for (dynamic x in data) {
      result.add(CaloIn(x["id"], DateTime.now(), x["name"], x["servingName"],
          int.parse(x["servingCalo"]), 0));
    }
    return result;
  }

  Future<List<CaloOut>> getCaloOut() async {
    var jsonText = await rootBundle.loadString('assets/hardData/calo_out.json');
    List data = json.decode(jsonText);
    List<CaloOut> result = [];
    for (dynamic x in data) {
      result.add(CaloOut(
          x["id"], DateTime.now(), x["name"], int.parse(x["unitCalo"]), 0));
    }
    return result;
  }
}
