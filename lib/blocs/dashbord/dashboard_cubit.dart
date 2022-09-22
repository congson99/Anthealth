import 'dart:convert';

import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
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
import 'package:anthealth_mobile/views/common_widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DashboardCubit extends Cubit<CubitState> {
  DashboardCubit() : super(InitialState()) {
    home();
  }

  /// Initial State
  home() async {
    emit(HomeLoadingState());
    List<MedicalAppointment> medicalAppointment = [];
    DateTime now = DateTime.now();
    List<ReminderMask> reminder = [];
    Map<String, dynamic> data = {
      "startTime": DateFormat("yyyy-MM-dd HH:mm:ss").format(now),
      "endTime": DateFormat("yyyy-MM-dd").format(now.add(Duration(days: 1))) +
          " 23:59:59"
    };
    await CommonService.instance
        .send(MessageIDPath.getDurationReminder(), data);
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getDurationReminder(), value)) {
        if (ServerLogic.getData(value) != null) {
          for (dynamic x in ServerLogic.getData(value)["data"])
            reminder.add(ReminderMask(
                x["name"],
                MedicineData("", x["name"], 0.0, int.parse(x["unit"]), 0,
                    x["img"], "", ""),
                DateTime.fromMicrosecondsSinceEpoch(x["time"] * 1000000),
                0.0 + x["need_amount"],
                ""));
        }
      }
    });
    if (reminder.length > 2) reminder = reminder.sublist(0, 3);
    await CommonService.instance.send(MessageIDPath.getMedicData(), {});
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getMedicData(), value)) {
        if (value != "null") {
          if (ServerLogic.getData(value)["upcomingAppointment"] != "")
            medicalAppointment.addAll([
              MedicalAppointment(
                  DateTime.fromMillisecondsSinceEpoch(
                      ServerLogic.getData(value)["upcomingAppointment"]
                              ["time"] *
                          1000),
                  ServerLogic.getData(value)["upcomingAppointment"]["place"],
                  now,
                  ServerLogic.getData(value)["upcomingAppointment"]["content"])
            ]);
        }
      }
    });
    List<dynamic> result = [];
    while (medicalAppointment.length + reminder.length > 0) {
      if (medicalAppointment.length == 0) {
        result.addAll(reminder);
        break;
      }
      if (reminder.length == 0) {
        result.addAll(medicalAppointment);
        break;
      }
      if (medicalAppointment.first.dateTime.isBefore(reminder.first.time)) {
        result.add(medicalAppointment.first);
        medicalAppointment.removeAt(0);
      } else {
        result.add(reminder.first);
        reminder.removeAt(0);
      }
    }
    List<Post> posts = [];
    await CommonService.instance.send(MessageIDPath.getPosts(), {});
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(MessageIDPath.getPosts(), value)) {
        if (value != "null")
          for (dynamic x in ServerLogic.getData(value)["data"]) {
            List<String> content = [];
            for (dynamic y in x["content"]) content.add(y as String);
            posts.add(Post(x["postKey"], x["coverImage"], x["title"], content));
          }
      }
    });
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
    MedicPageData data = MedicPageData("", "", []);
    await CommonService.instance.send(MessageIDPath.getMedicData(), {});
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getMedicData(), value)) {
        data = MedicPageData.formatData(
            ServerLogic.getData(value)["latestMedicalRecord"],
            ServerLogic.getData(value)["upcomingAppointment"],
            ServerLogic.getData(value)["medicineBoxes"]);
      }
    });
    emit(MedicState(data));
  }

  family() async {
    emit(FamilyLoadingState());
    await CommonService.instance.send(MessageIDPath.getFamilyData(), {});
    CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getFamilyData(), value)) {
        List<Invitation> invitations = [];
        if (ServerLogic.getData(value)["invite_list"] != null)
          for (dynamic x in ServerLogic.getData(value)["invite_list"])
            invitations.add(Invitation(x["id"], x["adminInfo"]["name"]));
        List<FamilyMemberData> members = [];
        if (ServerLogic.getData(value)["member_list"] != null) {
          for (dynamic x in ServerLogic.getData(value)["member_list"])
            members.add(FamilyMemberData(
                x["uid"].toString(),
                x["name"],
                x["base_info"]["avatar"],
                x["base_info"]["phone"],
                x["base_info"]["email"],
                x["rule"] == 2,
                [],
                x["birthDay"]));
          for (dynamic x in ServerLogic.getData(value)["member_list"][0]
              ["permission"]) {
            for (FamilyMemberData y in members) {
              if (y.id == x["uid"].toString()) {
                List<bool> temp = [];
                for (bool per in x["permissions"]) temp.add(per);
                y.permission = temp;
              }
            }
          }
        }
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
        if (ServerLogic.getData(value)["member_list"] != null) {
          for (dynamic x in ServerLogic.getData(value)["member_list"]) {
            members.add(FamilyMemberData(
                x["uid"].toString(),
                x["name"],
                x["base_info"]["avatar"],
                x["base_info"]["phone"],
                x["base_info"]["email"],
                x["rule"] == 2,
                [],
                x["birthDay"]));
          }
          for (dynamic x in ServerLogic.getData(value)["member_list"][0]
              ["permission"]) {
            for (FamilyMemberData y in members) {
              if (y.id == x["uid"].toString()) {
                List<bool> temp = [];
                for (bool per in x["permissions"]) temp.add(per);
                y.permission = temp;
              }
            }
          }
        }
      }
    });
    return members;
  }

  Future<bool> addMember(String email) async {
    bool result = false;
    Map<String, dynamic> data = {"email": email};
    await CommonService.instance.send(MessageIDPath.addMember(), data);
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(MessageIDPath.addMember(), value)) {
        if (ServerLogic.getData(value)["status"] != null)
          result = ServerLogic.getData(value)["status"];
      }
    });
    return result;
  }

  settings([SettingsState? state]) {
    emit(SettingsLoadingState());
    emit(state ?? SettingsState());
  }

  /// Server Functions
  Future<List<FamilyMemberData>> findUser(String email) async {
    if (email.length < 2) return [];
    List<FamilyMemberData> familyMemberData = [];
    Map<String, dynamic> data = {"email": email};
    await CommonService.instance.send(MessageIDPath.findUser(), data);
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(MessageIDPath.findUser(), value)) {
        var data = ServerLogic.getData(value)["data"];
        for (dynamic x in data)
          familyMemberData.add(FamilyMemberData(
              x["uid"].toString(),
              x["name"],
              x["avatar"],
              "",
              x["email"],
              false,
              [true, true, true, true, true, true, true, true],
              0));
      }
    });
    return familyMemberData;
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

  Future<void> handleInvitation(
      BuildContext context, String familyID, bool isAccept) async {
    Map<String, dynamic> data = {"familyId": familyID, "accept": isAccept};
    await CommonService.instance.send(MessageIDPath.handleInvitation(), data);
    CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.handleInvitation(), value)) {
        if (ServerLogic.getData(value)["status"]) {
          ShowSnackBar.showSuccessSnackBar(context, S.of(context).successfully);
        }
        family();
      }
    });
  }

  Future<HealthPageData> getHealthPageData(String id) async {
    Map<String, dynamic> j = {"uid": id};
    HealthPageData data = HealthPageData([]);
    await CommonService.instance.send(MessageIDPath.getHealthData(), j);
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
    List<MedicineData> result = [];
    await CommonService.instance.send(MessageIDPath.getMedicines(), {});
    await CommonService.instance.client!.getData().then((value) {
      print(value);
      if (ServerLogic.checkMatchMessageID(MessageIDPath.getMedicines(), value))
        for (dynamic x in ServerLogic.getData(value)["data"]) {
          result.add(MedicineData(
              x["id"],
              x["name"],
              0,
              int.parse(x["unit"]),
              0,
              x["img"],
              x["reference"],
              "Thành phần:\n" +
                  x["component"] +
                  "\n\n1. Chỉ định:\n" +
                  x["point"] +
                  "\n\n2. Chống chỉ định:\n" +
                  x["no_point"] +
                  "\n\n3. Liều dùng/Cách dùng:\n" +
                  x["use"] +
                  "\n\n4. Tác dụng phụ:\n" +
                  x["side_effects"] +
                  "\n\n5. Thận trọng:\n" +
                  x["careful"] +
                  "\n\n6. Tương tác thuốc:\n" +
                  x["interact"] +
                  "\n\n7. Bảo quản:\n" +
                  x["preserve"] +
                  "\n\n8. Đóng gói:\n" +
                  x["pack"]));
        }
    });
    return result;
  }

  Future<bool> removeFromFamily(String uid) async {
    bool result = false;
    Map<String, dynamic> data = {"uid": uid};
    await CommonService.instance.send(MessageIDPath.outFamily(), data);
    await CommonService.instance.client!.getData().then((value) {
      if (value != "null") if (ServerLogic.checkMatchMessageID(
          MessageIDPath.outFamily(), value)) {
        result = ServerLogic.getData(value)["status"];
      }
    });
    return result;
  }

  Future<bool> grantFamilyMember(String uid) async {
    bool result = false;
    Map<String, dynamic> data = {"uid": uid};
    await CommonService.instance.send(MessageIDPath.grantFamilyMember(), data);
    await CommonService.instance.client!.getData().then((value) {
      if (value != "null") if (ServerLogic.checkMatchMessageID(
          MessageIDPath.grantFamilyMember(), value)) {
        result = ServerLogic.getData(value)["status"];
      }
    });
    return result;
  }

  Future<List<MedicineData>> getMedicationsWithoutNote() async {
    var jsonText = await rootBundle.loadString('assets/hardData/medicine.json');
    List data = json.decode(jsonText);
    List<MedicineData> result = [];
    for (dynamic x in data) {
      result.add(MedicineData(x["id"], x["name"], 0, int.parse(x["unit"]), 0,
          x["img"], x["reference"], ""));
    }
    return result;
  }
}
