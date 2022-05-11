import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_states.dart';
import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalRecordCubit extends Cubit<CubitState> {
  MedicalRecordCubit() : super(InitialState()) {
    loadData();
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

  Future<bool> addData(MedicalRecordDetailData data) async {
    bool result = false;
    var temp = {
      "name": data.label.name,
      "place": data.label.location,
      "time": data.label.dateTime.millisecondsSinceEpoch ~/ 1000,
      "medicine": [],
      "detailsImage": data.diagnosePhoto,
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
    print(temp.toString());
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

  List<String> getLocationList() {
    return [
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
    ];
  }

  List<String> getMedicineList() {
    return [
      "Panadol Extra with Optizorb",
      "Cipogip 500 Tablet",
      "Augmentin 625mg"
    ];
  }

  DigitalMedicine getMedicine(int index) {
    var medicineList = [
      "Panadol Extra with Optizorb",
      "Cipogip 500 Tablet",
      "Augmentin 625mg"
    ];
    return DigitalMedicine(
        "id",
        medicineList[index],
        0,
        0,
        0,
        [0, 0, 0, 0],
        [],
        0,
        "https://drugbank.vn/api/public/gridfs/box-panadol-extra-optizobaddvi-thuoc100190do-chinh-dien-15236089259031797856781.jpg",
        "https://drugbank.vn/thuoc/Panadol-Extra-with-Optizorb&VN-19964-16",
        "");
  }
}
