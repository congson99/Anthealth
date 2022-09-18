import 'dart:convert';
import 'dart:io';

import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_detail_state.dart';
import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalRecordDetailCubit extends Cubit<CubitState> {
  MedicalRecordDetailCubit(String id,
      [MedicalRecordDetailData? medicalRecordDetailData])
      : super(InitialState()) {
    if (id == "add") {
      List<DigitalMedicine> medicine = [];
      if (medicalRecordDetailData != null)
        medicine = medicalRecordDetailData.prescription;
      loadedData(
          medicalRecordDetailData ??
              MedicalRecordDetailData(
                  MedicalRecordLabel("", DateTime.now(), "", ""),
                  [],
                  [],
                  [],
                  [],
                  [],
                  MedicalAppointment(DateTime.now(), "", DateTime.now(), "")),
          [[], [], [], []],
          medicine);
    } else
      loadData(id);
  }

  /// Handle States
  Future<void> loadedData(MedicalRecordDetailData data, List<List<File>> list,
      List<DigitalMedicine> medicine) async {
    List<String> hospitals = await getLocationList();
    emit(MedicalRecordDetailState(data, hospitals, list, medicine));
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

  // Update data
  void updateData(
      MedicalRecordDetailData data,
      String changeName,
      dynamic changeValue,
      List<List<File>> list,
      List<DigitalMedicine> medicine) async {
    emit(MedicalRecordDetailState(
        MedicalRecordDetailData(
            MedicalRecordLabel("", DateTime.now(), "", ""),
            [],
            [],
            [],
            [],
            [],
            MedicalAppointment(DateTime.now(), "", DateTime.now(), "")),
        [],
        [],
        []));
    // loadedData(
    //     MedicalRecordDetailData.updateData(data, changeName, changeValue),
    //     list,
    //     medicine);
  }

  void updateMedicine(MedicalRecordDetailState state, int type, int index,
      [DigitalMedicine? value]) async {
    emit(InitialState());
    List<DigitalMedicine> tempList = state.medicine;
    if (type == 0) tempList.add(value!);
    if (type == 1) tempList.removeAt(index);
    if (type == 2) {
      tempList.removeAt(index);
      tempList.insert(index, value!);
    }
    loadedData(state.data, state.list, tempList);
  }

  // Service Function
  Future<void> loadData(String id) async {
    var temp = {"id": id};
    await CommonService.instance
        .send(MessageIDPath.getMedicalRecordDetail(), temp);
    CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getMedicalRecordDetail(), value)) {
        loadedData(
            MedicalRecordDetailData.formatData(ServerLogic.getData(value)),
            [],
            []);
      }
    });
  }
}
