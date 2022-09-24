import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/health/calo_states.dart';
import 'package:anthealth_mobile/models/health/calo_models.dart';
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

  List<CaloIn> getCaloIn() {
    return [
      CaloIn("a", DateTime.now(), "Ca", "Con", 400, 0),
      CaloIn("b", DateTime.now(), "Com", "Chen", 200, 0),
      CaloIn("c", DateTime.now(), "Trung", "Qua", 100, 0),
      CaloIn("d", DateTime.now(), "Bo", "100g", 500, 0),
      CaloIn("e", DateTime.now(), "Heo", "100g", 400, 0),
      CaloIn("f", DateTime.now(), "Rau", "Dia", 20, 0),
    ];
  }

  List<CaloOut> getCaloOut() {
    return [
      CaloOut("a", DateTime.now(), "Chay", 400, 0),
      CaloOut("b", DateTime.now(), "Di bo", 200, 0),
      CaloOut("c", DateTime.now(), "Nhay day", 300, 0),
      CaloOut("d", DateTime.now(), "Boi", 400, 0),
    ];
  }
}
