import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/health/calo_states.dart';
import 'package:anthealth_mobile/models/health/calo_models.dart';
import 'package:anthealth_mobile/models/health/water_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaloCubit extends Cubit<CubitState> {
  CaloCubit() : super(InitialState()) {
    loadData();
  }

  // Initial State
  void loadedData(CaloState state) {
    emit(CaloState(state.data));
  }

  // Update data
  void updateData(CaloState state) {
    emit(InitialState());
    loadedData(state);
  }

  // Service Function
  Future<void> loadData() async {
    loadedData(CaloState(CaloDayData(2000, [
      CaloIn(DateTime.now(), "", 200, 2),
      CaloIn(DateTime.now(), "", 800, 0.5),
      CaloIn(DateTime.now(), "", 500, 1)
    ], [
      CaloOut(DateTime.now(), "", 50, 5)
    ])));
  }

  WaterDayData getDayData(DateTime dateTime) {
    return WaterDayData(200, [
      Water(DateTime(0, 0, 0, 2, 3), 200),
      Water(DateTime(0, 0, 0, 2, 20), 500),
      Water(DateTime(0, 0, 0, 6, 20), 500),
      Water(DateTime(0, 0, 0, 17, 20), 500)
    ]);
  }

  WaterMonthReport getMonthData(DateTime dateTime) {
    return WaterMonthReport(21, 30, [
      WaterDayReportData(900, 1200),
      WaterDayReportData(2000, 1800),
      WaterDayReportData(2000, 3000),
      WaterDayReportData(3000, 0),
      WaterDayReportData(2000, 1200),
      WaterDayReportData(2000, 1800),
      WaterDayReportData(2000, 0),
      WaterDayReportData(2000, 1800),
      WaterDayReportData(2000, 3000),
      WaterDayReportData(3000, 0),
      WaterDayReportData(2000, 1200),
      WaterDayReportData(2000, 1800),
      WaterDayReportData(2000, 0),
    ]);
  }

  WaterYearReport getYearData(DateTime dateTime) {
    return WaterYearReport([
      WaterMonthReportData(32, 28, 2839),
      WaterMonthReportData(32, 28, 2322),
      WaterMonthReportData(32, 28, 3422),
      WaterMonthReportData(32, 28, 9123),
      WaterMonthReportData(32, 28, 7272),
      WaterMonthReportData(32, 28, 123),
      WaterMonthReportData(32, 28, 2128),
      WaterMonthReportData(32, 28, 281),
      WaterMonthReportData(32, 28, 2129),
      WaterMonthReportData(32, 28, 1282),
      WaterMonthReportData(32, 28, 128),
      WaterMonthReportData(32, 28, 219),
    ]);
  }
}
