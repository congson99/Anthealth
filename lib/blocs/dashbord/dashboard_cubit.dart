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
    emit(FamilyLoadingState());
    await CommonService.instance.send(MessageIDPath.getFamilyData(), {});
    CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getFamilyData(), value)) {
        List<Invitation> invitations = [];
        // ServerLogic.getData(value)["invite_list"] ?? [];
        List<FamilyMemberData> members = [];
        if (ServerLogic.getData(value)["member_list"] != null)
          for (dynamic x in ServerLogic.getData(value)["member_list"])
            members.add(FamilyMemberData(
                x["uid"].toString(),
                x["name"],
                x["base_info"]["avatar"],
                x["base_info"]["phone"],
                x["base_info"]["email"],
                x["rule"] == 2,
                [true, true, true, true, true, true, true, true, true],
                x["birthDay"]));
        emit(FamilyState(members, invitations));
      }
    });
  }

  Future<List<FamilyMemberData>> getMemberData() async {
    List<FamilyMemberData> members = [];
    await CommonService.instance.send(MessageIDPath.getFamilyData(), {});
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getFamilyData(), value)) {
        if (ServerLogic.getData(value)["member_list"] != null)
          for (dynamic x in ServerLogic.getData(value)["member_list"])
            members.add(FamilyMemberData(
                x["uid"].toString(),
                x["name"],
                x["base_info"]["avatar"],
                x["base_info"]["phone"],
                x["base_info"]["email"],
                x["rule"] == 2,
                [true, true, true, true, true, true, true, true, true],
                x["birthDay"]));
        print(value);
      }
    });
    return members;
  }

  settings([SettingsState? state]) {
    emit(SettingsLoadingState());
    emit(state ?? SettingsState());
  }

  /// Server Functions
  FamilyMemberData findUser(String email) {
    if (email == "")
      return FamilyMemberData("", "", "", "", "", false,
          [true, true, true, true, true, true, true, true, true], 0);
    return FamilyMemberData(
        "id",
        "Nguyen Van Anh",
        "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg",
        "012013011",
        "ahaha@hca.com",
        false,
        [true, true, true, true, true, true, true, true],
        0);
  }

  Future<void> createFamily() async {
    await CommonService.instance.send(MessageIDPath.createFamily(), {});
    CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.createFamily(), value)) {
        if (ServerLogic.getData(value)["status"]) family();
      }
    });
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
