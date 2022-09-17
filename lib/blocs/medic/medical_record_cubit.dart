import 'dart:convert';
import 'dart:math';

import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_states.dart';
import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalRecordCubit extends Cubit<CubitState> {
  MedicalRecordCubit({String? uid}) : super(InitialState()) {
    loadData(uid: uid);
  }

  /// Handle States
  void loadedData(MedicalRecordPageData data) {
    emit(MedicalRecordState(data));
  }

  void updateData() {
    loadData();
  }

  void updateOpeningState(int index, MedicalRecordPageData data) {
    emit(InitialState());
    MedicalRecordPageData newData = data;
    newData.listYearLabel[index].openingState =
        !newData.listYearLabel[index].openingState;
    loadedData(newData);
  }

  /// Service Functions
  void loadData({String? uid}) async {
    emit(InitialState());
    Map<String, dynamic> data = {};
    if (uid != null) data.addAll({"uid": uid});
    await CommonService.instance
        .send(MessageIDPath.getMedicalRecordPageData(), data);
    CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getMedicalRecordPageData(), value)) {
        loadedData(MedicalRecordPageData.formatData(
            ServerLogic.getData(value)["listRecord"],
            ServerLogic.getData(value)["listAppointment"]));
      }
    });
  }

  Future<bool> addData(MedicalRecordDetailData data) async {
    bool result = false;
    var temp = {
      "name": data.label.name,
      "place": data.label.location,
      "time": data.label.dateTime.millisecondsSinceEpoch ~/ 1000,
      "medicine": [],
      "detailsImage": data.detailPhoto,
      "testImage": data.testPhoto,
      "diagnoseImage": data.diagnosePhoto,
      "medicineImage": data.prescriptionPhoto
    };
    if (data.appointment.name != "") {
      var tempAppointment = {
        "appointment": {
          "content": data.appointment.name,
          "time": data.appointment.dateTime.millisecondsSinceEpoch ~/ 1000,
          "place": data.appointment.location
        }
      };
      temp.addAll(tempAppointment);
    }
    await CommonService.instance
        .send(MessageIDPath.addNewMedicalRecord(), temp);
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.addNewMedicalRecord(), value)) {
        if (ServerLogic.getData(value)["status"]) result = true;
      }
    });
    return result;
  }

  Future<bool> deleteData(String id) async {
    bool result = false;
    var temp = {"rid": id};
    await CommonService.instance
        .send(MessageIDPath.deleteMedicalRecord(), temp);
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.deleteMedicalRecord(), value)) {
        if (ServerLogic.getData(value)["status"]) result = true;
      }
    });
    return result;
  }

  Future<List<String>> getLocationList() async {
    var jsonText = await rootBundle.loadString('assets/hardData/hospital.json');
    List data = json.decode(jsonText);
    List<String> result = [];
    for (dynamic x in data) {
      result.add(x["name"]);
    }
    return result;
  }

  Future<List<MedicineData>> getMedications() async {
    List<MedicineData> result = [];
    for (int i = 0; i < 200; i++) {
      result.add(MedicineData(
          "_id",
          utf8.decode(["A".codeUnits[0] + i ~/ 10]) +
              String.fromCharCodes(Iterable.generate(
                  20,
                  (_) =>
                      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz        '
                          .codeUnitAt(Random().nextInt(60)))),
          0,
          Random().nextInt(3),
          Random().nextInt(4),
          "https://drugbank.vn/api/public/gridfs/box-panadol-extra-optizobaddvi-thuoc100190do-chinh-dien-15236089259031797856781.jpg",
          "https://drugbank.vn/thuoc/Panadol-Extra-with-Optizorb&VN-19964-16",
          ""));
    }
    return result;
  }
}
