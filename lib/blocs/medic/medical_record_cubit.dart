import 'dart:convert';
import 'dart:io';

import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_states.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalRecordCubit extends Cubit<CubitState> {
  MedicalRecordCubit() : super(InitialState()) {
    loadData();
  }

  // Initial State
  void loadedData(MedicalRecordPageData data) {
    emit(MedicalRecordState(data));
  }

  // Update data
  void updateData() {
    loadData();
  }

  void updateOpeningState(int index, MedicalRecordPageData data) {
    loadedData(MedicalRecordPageData.changeOpeningState(index, data));
  }

  // Service Function
  void loadData() async {
    emit(InitialState());
    await CommonService.instance
        .send(MessageIDPath.getMedicalRecordPageData(), "");
    CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getMedicalRecordPageData(), value)) {
        loadedData(MedicalRecordPageData.formatData(
            ServerLogic.getData(value)["listRecord"],
            ServerLogic.getData(value)["listAppointment"]));
      }
    });
  }

  Future<bool> addData(
      MedicalRecordDetailData data, List<List<File>> list) async {
    bool result = false;
    List<List<String>> tempList = [[], [], [], []];
    for (int i = 0; i < 4; i++)
      for (File x in list[i]) {
        List<int> imageBytes = await File(x.path).readAsBytes();
        String base64Image = base64Encode(imageBytes);
        tempList[i].add(base64Image);
      }
    var temp = {
      "name": data.getLabel().getName(),
      "place": data.getLabel().getLocation(),
      "time": data.getLabel().getDateTime().millisecondsSinceEpoch ~/ 1000,
      "medicine": [],
      "detailsImage": [],
      "testImage": [],
      "diagnoseImage": [],
      "medicineImage": []
      // "detailsImage": tempList[0],
      // "testImage": tempList[1],
      // "diagnoseImage": tempList[2],
      // "medicineImage": tempList[3]
    };
    if (data.getAppointment()!.getName() != "") {
      var tempAppointment = {
        "appointment": {
          "content": data.getAppointment()!.getName(),
          "time": data.getAppointment()!.getDateTime().millisecondsSinceEpoch ~/
              1000,
          "place": data.getAppointment()!.getLocation()
        }
      };
      temp.addAll(tempAppointment);
    }
    await CommonService.instance
        .send(MessageIDPath.addNewMedicalRecord(), temp.toString());
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
        .send(MessageIDPath.deleteMedicalRecord(), temp.toString());
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.deleteMedicalRecord(), value)) {
        if (ServerLogic.getData(value)["status"]) result = true;
      }
    });
    return result;
  }
}
