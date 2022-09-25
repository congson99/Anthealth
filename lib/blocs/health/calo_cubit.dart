import 'dart:convert';

import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/health/calo_states.dart';
import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:anthealth_mobile/models/health/calo_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
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
    CaloDayData caloDayData = await getDayData(DateTime.now());
    loadedData(CaloState(caloDayData));
  }

  Future<CaloDayData> getDayData(DateTime dateTime) async {
    CaloDayData caloDayData = CaloDayData(0, [], []);
    Map<String, dynamic> data = {
      "time": dateTime.millisecondsSinceEpoch ~/ 1000
    };
    await CommonService.instance.send(MessageIDPath.getCaloDay(), data);
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(MessageIDPath.getCaloDay(), value)) {
        if (ServerLogic.getData(value) != null) {
          print(value);
          caloDayData.goal = ServerLogic.getData(value)["goal"];
          for (dynamic x in ServerLogic.getData(value)["caloin"]) {
            caloDayData.caloIn.add(CaloIn(
                x["id"],
                DateTime.fromMillisecondsSinceEpoch(x["time"] * 1000),
                x["name"],
                x["servingName"],
                x["servingCalo"],
                0.0 + x["serving"]));
          }
          for (dynamic x in ServerLogic.getData(value)["caloout"]) {
            caloDayData.caloOut.add(CaloOut(
                x["id"], DateTime.fromMillisecondsSinceEpoch(x["time"] * 1000), x["name"], x["unitCalo"], x["min"]));
          }
        }
      }
    });
    return caloDayData;
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

  Future<bool> addCaloIn(CaloIn calo) async {
    bool result = false;
    Map<String, dynamic> data = {
      "id": calo.id,
      "time": calo.time.millisecondsSinceEpoch ~/ 1000,
      "name": calo.name,
      "servingName": calo.servingName,
      "servingCalo": calo.servingCalo,
      "serving": calo.serving
    };
    await CommonService.instance.send(MessageIDPath.addCaloIn(), data);
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(MessageIDPath.addCaloIn(), value)) {
        if (ServerLogic.getData(value) != null) {
          result = ServerLogic.getData(value)["status"];
        }
      }
    });
    return result;
  }

  Future<bool> addCaloOut(CaloOut calo) async {
    bool result = false;
    Map<String, dynamic> data = {
      "id": calo.id,
      "time": calo.time.millisecondsSinceEpoch ~/ 1000,
      "name": calo.name,
      "unitCalo": calo.unitCalo,
      "min": calo.min
    };
    await CommonService.instance.send(MessageIDPath.addCaloOut(), data);
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(MessageIDPath.addCaloOut(), value)) {
        if (ServerLogic.getData(value) != null) {
          result = ServerLogic.getData(value)["status"];
        }
      }
    });
    return result;
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
