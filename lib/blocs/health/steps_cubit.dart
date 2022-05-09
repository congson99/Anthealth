import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/health/steps_states.dart';
import 'package:anthealth_mobile/models/health/steps_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepsCubit extends Cubit<CubitState> {
  StepsCubit() : super(InitialState()) {
    loadData();
  }

  /// Handle States
  void loadedData(StepsState state) {
    emit(StepsState(state.data));
  }

  void updateData(StepsState state) {
    emit(InitialState());
    loadedData(state);
  }

  /// Service Functions
  Future<void> loadData() async {
    loadedData(StepsState(StepsDayData(
        2000, [Steps(DateTime.now(), 500), Steps(DateTime.now(), 800)])));
  }

  StepsDayData getDayData(DateTime dateTime) {
    return StepsDayData(200, [
      Steps(DateTime(0, 0, 0, 2, 3), 200),
      Steps(DateTime(0, 0, 0, 2, 20), 500),
      Steps(DateTime(0, 0, 0, 6, 20), 500),
      Steps(DateTime(0, 0, 0, 17, 20), 500)
    ]);
  }

  StepsMonthReport getMonthData(DateTime dateTime) {
    return StepsMonthReport(200000, 21, 30, [
      StepsDayReportData(900, 1200),
      StepsDayReportData(2000, 1800),
      StepsDayReportData(2000, 3000),
      StepsDayReportData(3000, 0),
      StepsDayReportData(2000, 1200),
      StepsDayReportData(2000, 1800),
      StepsDayReportData(2000, 0),
      StepsDayReportData(2000, 1800),
      StepsDayReportData(2000, 3000),
      StepsDayReportData(3000, 0),
      StepsDayReportData(2000, 1200),
      StepsDayReportData(2000, 1800),
      StepsDayReportData(2000, 0),
    ]);
  }

  StepsYearReport getYearData(DateTime dateTime) {
    return StepsYearReport(200000231, [
      StepsMonthReportData(32, 28, 2839),
      StepsMonthReportData(32, 28, 2322),
      StepsMonthReportData(32, 28, 3422),
      StepsMonthReportData(32, 28, 9123),
      StepsMonthReportData(32, 28, 7272),
      StepsMonthReportData(32, 28, 123),
      StepsMonthReportData(32, 28, 2128),
      StepsMonthReportData(32, 28, 281),
      StepsMonthReportData(32, 28, 2129),
      StepsMonthReportData(32, 28, 1282),
      StepsMonthReportData(32, 28, 128),
      StepsMonthReportData(32, 28, 219),
    ]);
  }
}
