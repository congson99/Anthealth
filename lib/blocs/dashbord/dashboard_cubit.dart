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
    List<Post> posts = [
      Post.generate(
          postKey: "Flutter",
          coverImage: "https://200lab-blog.imgix.net/2021/07/0_OA8mG-mK8hncsgQ4.jpg?auto=format,compress&w=1500",
          title: "Flutter là gì? Các đặc tính vượt trội của Flutter",
          content: [
            "Flutter là gì?",
            "Bạn có thể hiểu Flutter là bộ công cụ giao diện người dùng của Google để tạo các ứng dụng đẹp, được biên dịch native cho thiết bị di động, web và máy tính để bàn từ một mã nguồn duy nhất.",
            "Flutter là một framework giao diện người dùng mã nguồn mở miễn phí được tạo bởi Google và được phát hành vào tháng 5 năm 2017.",
            "Nói một cách dễ hiểu, điều này cho phép bạn tạo một ứng dụng di động chỉ với một lần code. Có nghĩa là bạn có thể sử dụng một ngôn ngữ lập trình và một mã nguồn để tạo hai ứng dụng khác nhau (IOS và Android).",
            "Không giống như các giải pháp phổ biến khác, Flutter không phải là một framework hoặc thư viện mà đó là một SDK hoàn chỉnh – bộ công cụ phát triển phần mềm đa nền tảng.",
            "https://200lab-blog.imgix.net/2021/07/0_OA8mG-mK8hncsgQ4.jpg?auto=format,compress&w=1500",
            "Để phát triển với Flutter, bạn sẽ sử dụng một ngôn ngữ lập trình có tên là Dart. Đây cũng là ngôn ngữ của Google được tạo vào tháng 10 năm 2011 và đã được cải thiện rất nhiều trong những năm qua. Dart tập trung vào phát triển front-end, bạn có thể sử dụng nó để tạo các ứng dụng di động và web.",
            "Quá trình phát triển Flutter",
            "https://d50cmv7hkyx4e.cloudfront.net/wp-content/uploads/2021/06/23141932/facebook_cover-1024x538-1.png",
            "Vào năm 2015, Google đã công bố Flutter, một SDK mới dựa trên ngôn ngữ Dart, làm nền tảng tiếp theo để phát triển Android và vào năm 2017, phiên bản alpha của nó (0.0.6) đã được phát hành cho công chúng lần đầu tiên.",
            "Vào ngày 4 tháng 12 năm 2018, Flutter 1.0 đã được phát hành tại sự kiện Flutter Live và có sẵn để các nhà phát triển có thể bắt đầu sử dụng SDK để tạo ứng dụng dễ dàng hơn. Đây được đánh dấu là phiên bản “stable” đầu tiên."
          ])
    ];
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
          "Nguyen Van Anh",
          "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg",
          "012013011",
          "ahaha@hca.com",
          true,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1],
          0),
      FamilyMemberData(
          "sd",
          "Van Anh",
          "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg",
          "012013011",
          "ahaha@hca.com",
          false,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1],
          0),
      FamilyMemberData(
          "id",
          "Nguyen Van Anh",
          "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg",
          "012013011",
          "ahaha@hca.com",
          false,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1],
          0),
      FamilyMemberData(
          "id",
          "Nguyen Van Anh",
          "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg",
          "012013011",
          "ahaha@hca.com",
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
