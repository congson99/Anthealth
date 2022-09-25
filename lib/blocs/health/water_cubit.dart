import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/health/water_states.dart';
import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:anthealth_mobile/models/health/water_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WaterCubit extends Cubit<CubitState> {
  WaterCubit() : super(InitialState()) {
    loadData();
  }

  /// Handle States
  void loadedData(WaterState state) {
    emit(WaterState(state.data));
  }

  void updateData(WaterState state) {
    emit(InitialState());
    loadedData(state);
  }

  /// Service Functions
  Future<void> loadData() async {
    WaterDayData waterDayData = await getDayData(DateTime.now());
    loadedData(WaterState(waterDayData));
  }

  Future<bool> updateGoal(int goal) async {
    bool result = false;
    Map<String, dynamic> data = {"goal": goal};
    await CommonService.instance.send(MessageIDPath.updateWaterGoal(), data);
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.updateWaterGoal(), value)) {
        if (ServerLogic.getData(value) != null) {
          result = ServerLogic.getData(value)["status"];
        }
      }
    });
    return result;
  }

  Future<bool> addData(Water water) async {
    bool result = false;
    Map<String, dynamic> data = {
      "time": water.time.millisecondsSinceEpoch ~/ 1000,
      "value": water.value
    };
    await CommonService.instance.send(MessageIDPath.addWater(), data);
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(MessageIDPath.addWater(), value)) {
        if (ServerLogic.getData(value) != null) {
          result = ServerLogic.getData(value)["status"];
        }
      }
    });
    return result;
  }

  Future<WaterDayData> getDayData(DateTime dateTime) async {
    WaterDayData waterDayData = WaterDayData(0, []);
    Map<String, dynamic> data = {
      "time": dateTime.millisecondsSinceEpoch ~/ 1000
    };
    await CommonService.instance.send(MessageIDPath.getWaterDay(), data);
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(MessageIDPath.getWaterDay(), value)) {
        if (ServerLogic.getData(value) != null) {
          print(value);
          waterDayData.goal = ServerLogic.getData(value)["goal"];
          for (dynamic x in ServerLogic.getData(value)["record"]) {
            waterDayData.record.add(Water(
                DateTime.fromMillisecondsSinceEpoch(x["time"]), x["value"]));
          }
        }
      }
    });
    return waterDayData;
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
