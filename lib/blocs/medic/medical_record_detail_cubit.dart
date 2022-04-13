import 'dart:io';

import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/common_logic/server_logic.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_detail_state.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalRecordDetailCubit extends Cubit<CubitState> {
  MedicalRecordDetailCubit(String id) : super(InitialState()) {
    if (id == "add")
      loadedData(
          MedicalRecordDetailData(
              MedicalRecordLabel("", DateTime.now(), "", ""),
              [],
              [],
              [],
              [],
              [],
              MedicalAppointment(DateTime.now(), "", DateTime.now(), "")),
          [[], [], [], []]);
    else
      loadData(id);
  }

  // Initial State
  void loadedData(MedicalRecordDetailData data, List<List<File>> list) {
    emit(MedicalRecordDetailState(
        data,
        [
          "Bệnh viện Huyện Bình Chánh",
          "Bệnh viện Huyện Cần Giờ",
          "Bệnh viện Huyện Củ Chi",
          "Bệnh viện Huyện Hóc Môn",
          "Bệnh viện Huyện Nhà Bè",
          "Bệnh viện Quận 1",
          "Bệnh viện Quận 10",
          "Bệnh viện Quận 11",
          "Bệnh viện Quận 12",
          "Bệnh viện Quận 2",
          "Bệnh viện Quận 3",
          "Bệnh viện Quận 4",
          "TRUNG TÂM Y TẾ QUẬN 5 (CS2)",
          "Bệnh viện Quận 6",
          "Bệnh viện Quận 7",
          "Bệnh viện Quận 8",
          "Bệnh viện Đa Khoa Lê Văn Việt",
          "Bệnh viện Quận Bình Tân",
          "Bệnh viện Quận Bình Thạnh",
          "Bệnh viện Quận Gò Vấp",
          "Bệnh Viện Quận Phú Nhuận",
          "Bệnh viện Quận Tân Bình",
          "Bệnh viện Quận Tân Phú",
          "Bệnh viện Quận Thủ Đức"
        ],
        list));
  }

  // Update data
  void updateData(MedicalRecordDetailData data, String changeName,
      dynamic changeValue, List<List<File>> list) async {
    emit(MedicalRecordDetailState(
        MedicalRecordDetailData(
            MedicalRecordLabel("", DateTime.now(), "", ""), [], [], [], [], []),
        [],
        []));
    loadedData(
        MedicalRecordDetailData.updateData(data, changeName, changeValue),
        list);
  }

  // Service Function
  Future<void> loadData(String id) async {
    var temp = {"id": id};
    await CommonService.instance
        .send(MessageIDPath.getMedicalRecordDetail(), temp.toString());
    CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getMedicalRecordDetail(), value)) {
        loadedData(
            MedicalRecordDetailData.formatData(ServerLogic.getData(value)), []);
      }
    });
  }
}
