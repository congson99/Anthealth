import 'dart:convert';

import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:anthealth_mobile/models/common/gps_models.dart';
import 'package:anthealth_mobile/models/dashboard/dashboard_models.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/models/medic/medical_directory_models.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/models/medic/medication_reminder_models.dart';
import 'package:anthealth_mobile/models/post/post_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardCubit extends Cubit<CubitState> {
  DashboardCubit() : super(InitialState()) {
    home();
  }

  /// Initial State
  home() async {
    emit(HomeLoadingState());
    List<MedicalAppointment> medicalAppointment = [];
    List<ReminderMask> reminderMask = [];
    DateTime now = DateTime.now();
    medicalAppointment.addAll([
      MedicalAppointment(DateTime(now.year, now.month, now.day + 50, 0, 0),
          "Bệnh viện đại học y dược", now, "Kiểm tra sức khoẻ định kỳ")
    ]);
    reminderMask.addAll([
      ReminderMask(
          "Name",
          MedicineData(
              "",
              "Paradol Paradol ",
              30,
              0,
              0,
              "https://drugbank.vn/api/public/gridfs/box-panadol-extra-optizobaddvi-thuoc100190do-chinh-dien-15236089259031797856781.jpg",
              "https://drugbank.vn/thuoc/Panadol-Extra-with-Optizorb&VN-19964-16",
              ""),
          DateTime(now.year, now.month, now.day, 7, 0),
          1,
          "")
    ]);
    List<dynamic> result = [];
    while (medicalAppointment.length + reminderMask.length > 0) {
      if (medicalAppointment.length == 0) {
        result.addAll(reminderMask);
        break;
      }
      if (reminderMask.length == 0) {
        result.addAll(medicalAppointment);
        break;
      }
      if (medicalAppointment.first.dateTime.isBefore(reminderMask.first.time)) {
        result.add(medicalAppointment.first);
        medicalAppointment.removeAt(0);
      } else {
        result.add(reminderMask.first);
        reminderMask.removeAt(0);
      }
    }
    List<Post> posts = [];
    await Post.fromJson("assets/hardData/height.json")
        .then((value) => posts.add(value));
    await Post.fromJson("assets/hardData/weight.json")
        .then((value) => posts.add(value));
    await Post.fromJson("assets/hardData/blood_pressure.json")
        .then((value) => posts.add(value));
    emit(HomeState(result, posts));
  }

  health() async {
    emit(HealthLoadingState());
    await CommonService.instance.send(MessageIDPath.getHealthData(), {});
    CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getHealthData(), value)) {
        List<double> indicatorLatestData = HealthPageData.formatIndicatorsList(
            ServerLogic.formatList(
                ServerLogic.getData(value)["indicatorInfo"]));
        emit(HealthState(HealthPageData(indicatorLatestData)));
      }
    });
  }

  void medic() async {
    emit(MedicLoadingState());
    await CommonService.instance.send(MessageIDPath.getMedicData(), {});
    CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getMedicData(), value)) {
        emit(MedicState(MedicPageData.formatData(
            ServerLogic.getData(value)["latestMedicalRecord"],
            ServerLogic.getData(value)["upcomingAppointment"],
            ServerLogic.getData(value)["medicineBoxes"])));
      }
    });
  }

  family() async {
    emit(MedicLoadingState());
    emit(FamilyState([
      FamilyMemberData(
          "123",
          "Trần Bố",
          "https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock--480x320.jpg",
          "0372828282",
          "father@anthealth.com",
          true,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1],
          0),
      FamilyMemberData(
          "Nguyễn Thị Lan",
          "Nguyễn Thị Lan",
          "https://engineering.unl.edu/images/staff/Kayla-Person.jpg",
          "012013011",
          "mother@hca.com",
          false,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1],
          0),
      FamilyMemberData(
          "id",
          "Trần Con Trai",
          "https://www.investnational.com.au/wp-content/uploads/2016/08/person-stock-2.png",
          "012013011",
          "son@hca.com",
          false,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1],
          0),
      FamilyMemberData(
          "id",
          "Trần Huệ",
          "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg",
          "012013011",
          "dauger@hca.com",
          false,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1],
          0),
      FamilyMemberData(
          "id",
          "Trần Hùng",
          "https://static01.nyt.com/images/2021/10/13/science/13shatner-launch-oldest-person-sub/13shatner-launch-oldest-person-sub-mediumSquareAt3X.jpg",
          "012013011",
          "dauger@hca.com",
          false,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1],
          0),
      FamilyMemberData(
          "id",
          "Lê Thị Hoa",
          "https://bacsiielts.vn/wp-content/uploads/2022/05/talk-about-a-famous-person-3.jpg",
          "012013011",
          "dauger@hca.com",
          false,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1],
          0),
      FamilyMemberData(
          "id",
          "La Hữu Phúc",
          "https://qph.cf2.quoracdn.net/main-qimg-8eeb0bdbcfe06a441197179e72367009.webp",
          "012013011",
          "dauger@hca.com",
          false,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1],
          0),
      FamilyMemberData(
          "id",
          "Lê Ngọc Lan",
          "https://img.huffingtonpost.com/asset/5d02417b2500004e12e454a5.jpeg?ops=scalefit_720_noupscale",
          "012013011",
          "dauger@hca.com",
          false,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1],
          0),
      FamilyMemberData(
          "id",
          "Nguyễn Văn Hùng",
          "https://cdn.hswstatic.com/gif/play/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg",
          "012013011",
          "dauger@hca.com",
          false,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1],
          0),
      FamilyMemberData(
          "id",
          "Nguyễn Ngọc Thu Uyên",
          "https://i0.wp.com/www.yesmagazine.org/wp-content/uploads/2022/03/Ghaderi_1400x840.jpg?fit=1400%2C840&quality=90&ssl=1",
          "012013011",
          "dauger@hca.com",
          false,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1],
          0),
    ]));
  }

  settings([SettingsState? state]) {
    emit(SettingsLoadingState());
    emit(state ?? SettingsState());
  }

  /// Server Functions
  FamilyMemberData findUser(String email) {
    if (email == "")
      return FamilyMemberData(
          "", "", "", "", "", false, [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1], 0);
    return FamilyMemberData(
        "id",
        "Nguyen Van Anh",
        "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg",
        "012013011",
        "ahaha@hca.com",
        false,
        [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1],
        0);
  }

  Future<String> getFamilyID(String id) async {
    return "family";
  }

  Future<bool> removeFamilyMember(String id) async {
    return true;
  }

  Future<bool> grantFamilyAdmin(String id) async {
    return true;
  }

  Future<HealthPageData> getHealthPageData(String id) async {
    HealthPageData data = HealthPageData([]);
    await CommonService.instance.send(MessageIDPath.getHealthData(), {});
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(MessageIDPath.getHealthData(), value))
        data.indicatorsLatestData = HealthPageData.formatIndicatorsList(
            ServerLogic.formatList(
                ServerLogic.getData(value)["indicatorInfo"]));
    });
    return data;
  }

  Future<List<MedicalDirectoryData>> getMedicalContacts() async {
    var jsonText = await rootBundle.loadString('assets/hardData/hospital.json');
    List data = json.decode(jsonText);
    List<MedicalDirectoryData> result = [];
    for (dynamic x in data) {
      result.add(MedicalDirectoryData("", x["name"], x["address"], x["phone"],
          x["time"], "", GPS(double.parse(x["lat"]), double.parse(x["long"]))));
    }
    return result;
  }

  Future<List<MedicineData>> getMedications() async {
    var jsonText = await rootBundle.loadString('assets/hardData/medicine.json');
    List data = json.decode(jsonText);
    List<MedicineData> result = [];
    for (dynamic x in data) {
      result.add(MedicineData(
          "",
          x["name"],
          0,
          0,
          0,
          x["image"],
          x["Link"],
          "Thành phần:\n" +
              x["ingredients"] +
              "\n\n1. Chỉ định:\n" +
              x["allocate"] +
              "\n\n2. Chống chỉ định:\n" +
              x["contraindications"] +
              "\n\n3. Liều dùng/Cách dùng:\n" +
              x["dosage"] +
              "\n\n4. Tác dụng phụ:\n" +
              x["sideEffects"] +
              "\n\n5. Thận trọng:\n" +
              x["Careful"] +
              "\n\n6. Tương tác thuốc:\n" +
              x["Interactions"] +
              "\n\n7. Bảo quản:\n" +
              x["Preserve"] +
              "\n\n8. Đóng gói:\n" +
              x["Pack"]));
    }
    print(result.length);
    return result;
  }

  Future<List<MedicineData>> getMedicationsWithoutNote() async {
    var jsonText = await rootBundle.loadString('assets/hardData/medicine.json');
    List data = json.decode(jsonText);
    List<MedicineData> result = [];
    for (dynamic x in data) {
      result
          .add(MedicineData("", x["name"], 0, 0, 0, x["image"], x["Link"], ""));
    }
    print(result.length);
    return result;
  }
}
