import 'dart:convert';
import 'dart:math';

import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:anthealth_mobile/models/common/gps_models.dart';
import 'package:anthealth_mobile/models/community/community_models.dart';
import 'package:anthealth_mobile/models/dashboard/dashboard_models.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/models/medic/medical_directory_models.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/models/medic/medication_reminder_models.dart';
import 'package:anthealth_mobile/models/user/doctor_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardCubit extends Cubit<CubitState> {
  DashboardCubit() : super(InitialState()) {
    home();
  }

  /// Initial State
  doctor() async {
    emit(DoctorLoadingState());
    await Future.delayed(Duration(seconds: 1));
    emit(DoctorState(
        Doctor(
            "id",
            "Strange",
            "https://vcdn1-giaitri.vnecdn.net/2022/05/05/DoctorStrange2mmm-1651738078-4301-1651738447.jpg?w=1200&h=0&q=100&dpr=1&fit=crop&s=hvLU0ITOvD2EhxFK8TD8Og",
            "022123123",
            "doctor.hca.com",
            "Bác sĩ khám mắt",
            "Bác sĩ ABC làm tại bệnh viện XYZ chuyên khám mắt, cận thị, loạn thị, đo kính. \nPhòng khám Bác Sĩ Mắt - 123 đường Phạm Văn Đồng \nSđt phòng khám: 213872132 - 2882138291",
            true),
        [
          DoctorAppointment(
              "",
              "doctorId",
              "patientId",
              "doctorName",
              "The Rock",
              "",
              "https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg",
              "Hẹn khám định kỳ",
              DateTime.now(),
              "Phòng khám Bác Sĩ Mắt - 123 đường Phạm Văn Đồng"),
          DoctorAppointment(
              "",
              "doctorId",
              "patientId",
              "doctorName",
              "Tom Holland",
              "",
              "https://image.thanhnien.vn/w1024/Uploaded/2022/juzagt/2021_12_16/1-5144.jpg",
              "Mổ mắt",
              DateTime.now(),
              "")
        ]));
  }

  home() async {
    emit(HomeLoadingState());
    List<MedicalAppointment> medicalAppointment = [];
    List<ReminderMask> reminderMask = [];
    DateTime now = DateTime.now();
    medicalAppointment.addAll([
      MedicalAppointment(DateTime(now.year, now.month, now.day, 0, 0),
          "Bệnh viện Chợ Rẫy", now, "Tái khám kiểm tra mắt"),
      MedicalAppointment(DateTime(now.year, now.month, now.day + 1, 0, 0),
          "Nha khoa ABC", now, "Hẹn khám răng"),
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
          ""),
      ReminderMask(
          "XX",
          MedicineData(
              "",
              "Pemol",
              24,
              0,
              2,
              "https://drugbank.vn/api/public/gridfs/box-panadol-extra-optizobaddvi-thuoc100190do-chinh-dien-15236089259031797856781.jpg",
              "https://drugbank.vn/thuoc/Panadol-Extra-with-Optizorb&VN-19964-16",
              "Morning"),
          DateTime(now.year, now.month, now.day, 17, 0),
          1,
          ""),
      ReminderMask(
          "XX",
          MedicineData(
              "",
              "Peas da mol",
              24,
              0,
              2,
              "https://drugbank.vn/api/public/gridfs/box-panadol-extra-optizobaddvi-thuoc100190do-chinh-dien-15236089259031797856781.jpg",
              "https://drugbank.vn/thuoc/Panadol-Extra-with-Optizorb&VN-19964-16",
              "Morning"),
          DateTime(now.year, now.month, now.day + 1, 6, 0),
          200,
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
    emit(HomeState(result));
  }

  health() async {
    emit(HealthLoadingState());
    await CommonService.instance
        .send(MessageIDPath.getHealthData(), {});
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
    await CommonService.instance
        .send(MessageIDPath.getMedicData(), {});
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
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1],0),
      FamilyMemberData(
          "sd",
          "Van Anh",
          "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg",
          "012013011",
          "ahaha@hca.com",
          false,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1],0),
      FamilyMemberData(
          "id",
          "Nguyen Van Anh",
          "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg",
          "012013011",
          "ahaha@hca.com",
          false,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1],0),
      FamilyMemberData(
          "id",
          "Nguyen Van Anh",
          "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg",
          "012013011",
          "ahaha@hca.com",
          false,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1],0),
    ]));
  }

  community([CommunityState? state]) {
    emit(CommunityLoadingState());
    emit(state ??
        CommunityState([
          CommunityGroup(
              "",
              [
                CommunityData(
                    '0',
                    "Yoga",
                    "Yoga a ha ha ehe he asida sndna dasd sadasd a das d asd as das d asd as d asnd asdnsandasndnad as d asd an dna nd",
                    "https://www.victoriavn.com/images/healthlibrary/hatha-yoga.jpg",
                    239,
                    true, []),
                CommunityData(
                    '0',
                    "Make up",
                    "Gys a ha ha ehe he asida sndna dasd sadasd a das d asd as das d asd as d asnd asdnsandasndnad as d asd an dna nd",
                    "http://file.hstatic.net/1000379579/article/thuat-ngu-makeup-danh-cho-nguoi-moi-bat-dau_e9dc32edb93647c4aefea1807091100a.jpg",
                    2883,
                    true, [])
              ],
              true),
          CommunityGroup(
              "Sport",
              [
                CommunityData(
                    '0',
                    "Yoga",
                    "Yoga a ha ha ehe he asida sndna dasd sadasd a das d asd as das d asd as d asnd asdnsandasndnad as d asd an dna nd",
                    "https://www.victoriavn.com/images/healthlibrary/hatha-yoga.jpg",
                    239,
                    true, []),
                CommunityData(
                    '0',
                    "Gym",
                    "Gys a ha ha ehe he asida sndna dasd sadasd a das d asd as das d asd as d asnd asdnsandasndnad as d asd an dna nd",
                    "http://www.elleman.vn/wp-content/uploads/2017/04/13/Nuoc-hoa-nam-cho-phong-gym-1.jpg",
                    2883,
                    false, [])
              ],
              false),
          CommunityGroup(
              "Women",
              [
                CommunityData(
                    '0',
                    "Skin care",
                    "Yoga a ha ha ehe he asida sndna dasd sadasd a das d asd as das d asd as d asnd asdnsandasndnad as d asd an dna nd",
                    "http://imc.net.vn/wp-content/uploads/2021/03/imc-skincare.jpg",
                    239,
                    false, []),
                CommunityData(
                    '0',
                    "Make up",
                    "Gys a ha ha ehe he asida sndna dasd sadasd a das d asd as das d asd as d asnd asdnsandasndnad as d asd an dna nd",
                    "http://file.hstatic.net/1000379579/article/thuat-ngu-makeup-danh-cho-nguoi-moi-bat-dau_e9dc32edb93647c4aefea1807091100a.jpg",
                    2883,
                    true, [])
              ],
              false)
        ]));
  }

  /// Server Functions
  FamilyMemberData findUser(String email) {
    if (email == "")
      return FamilyMemberData(
          "", "", "", "", "", false, [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1],0);
    return FamilyMemberData(
        "id",
        "Nguyen Van Anh",
        "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg",
        "012013011",
        "ahaha@hca.com",
        false,
        [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1],0);
  }

  Future<List<DoctorGroup>> getAllDoctor() async {
    return [
      DoctorGroup(
          "",
          [
            Doctor(
                "id",
                "Hung",
                "https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Trinh-Cong-Quyen-277x327.jpg",
                "2939121",
                "doctor.hca.com",
                "Bác sĩ khám mắt",
                "Bác sĩ ABC làm tại bệnh viện XYZ chuyên khám mắt, cận thị, loạn thị, đo kính. \nPhòng khám Bác Sĩ Mắt - 123 đường Phạm Văn Đồng \nSđt phòng khám: 213872132 - 2882138291",
                true),
            Doctor(
                "id",
                "Nguyet Nga",
                "https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Trinh-Cong-Quyen-277x327.jpg",
                "2939121",
                "doctor.hca.com",
                "Bác sĩ khám mắt",
                "Bác sĩ ABC làm tại bệnh viện XYZ chuyên khám mắt, cận thị, loạn thị, đo kính. \nPhòng khám Bác Sĩ Mắt - 123 đường Phạm Văn Đồng \nSđt phòng khám: 213872132 - 2882138291",
                true),
            Doctor(
                "id",
                "Manh Hung",
                "https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Trinh-Cong-Quyen-277x327.jpg",
                "2939121",
                "doctor.hca.com",
                "Bác sĩ khám mắt",
                "Bác sĩ ABC làm tại bệnh viện XYZ chuyên khám mắt, cận thị, loạn thị, đo kính. \nPhòng khám Bác Sĩ Mắt - 123 đường Phạm Văn Đồng \nSđt phòng khám: 213872132 - 2882138291",
                true),
            Doctor(
                "id",
                "An Tam",
                "https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Trinh-Cong-Quyen-277x327.jpg",
                "2939121",
                "doctor.hca.com",
                "Bác sĩ khám mắt",
                "Bác sĩ ABC làm tại bệnh viện XYZ chuyên khám mắt, cận thị, loạn thị, đo kính. \nPhòng khám Bác Sĩ Mắt - 123 đường Phạm Văn Đồng \nSđt phòng khám: 213872132 - 2882138291",
                true)
          ],
          true),
      DoctorGroup(
          "Khoa Nhi",
          [
            Doctor(
                "id",
                "Hung",
                "https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Trinh-Cong-Quyen-277x327.jpg",
                "2939121",
                "doctor.hca.com",
                "Bác sĩ khám mắt",
                "Bác sĩ ABC làm tại bệnh viện XYZ chuyên khám mắt, cận thị, loạn thị, đo kính. \nPhòng khám Bác Sĩ Mắt - 123 đường Phạm Văn Đồng \nSđt phòng khám: 213872132 - 2882138291",
                true),
            Doctor(
                "id",
                "Nguyet Nga",
                "https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Trinh-Cong-Quyen-277x327.jpg",
                "2939121",
                "doctor.hca.com",
                "Bác sĩ khám mắt",
                "Bác sĩ ABC làm tại bệnh viện XYZ chuyên khám mắt, cận thị, loạn thị, đo kính. \nPhòng khám Bác Sĩ Mắt - 123 đường Phạm Văn Đồng \nSđt phòng khám: 213872132 - 2882138291",
                true),
            Doctor(
                "id",
                "Manh Hung",
                "https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Trinh-Cong-Quyen-277x327.jpg",
                "2939121",
                "doctor.hca.com",
                "Bác sĩ khám mắt",
                "Bác sĩ ABC làm tại bệnh viện XYZ chuyên khám mắt, cận thị, loạn thị, đo kính. \nPhòng khám Bác Sĩ Mắt - 123 đường Phạm Văn Đồng \nSđt phòng khám: 213872132 - 2882138291",
                true),
            Doctor(
                "id",
                "An Tam",
                "https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Trinh-Cong-Quyen-277x327.jpg",
                "2939121",
                "doctor.hca.com",
                "Bác sĩ khám mắt",
                "Bác sĩ ABC làm tại bệnh viện XYZ chuyên khám mắt, cận thị, loạn thị, đo kính. \nPhòng khám Bác Sĩ Mắt - 123 đường Phạm Văn Đồng \nSđt phòng khám: 213872132 - 2882138291",
                true)
          ],
          false),
      DoctorGroup(
          "Khoa Rang Ham Mat",
          [
            Doctor(
                "id",
                "Hung",
                "https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Trinh-Cong-Quyen-277x327.jpg",
                "2939121",
                "doctor.hca.com",
                "Bác sĩ khám mắt",
                "Bác sĩ ABC làm tại bệnh viện XYZ chuyên khám mắt, cận thị, loạn thị, đo kính. \nPhòng khám Bác Sĩ Mắt - 123 đường Phạm Văn Đồng \nSđt phòng khám: 213872132 - 2882138291",
                true),
            Doctor(
                "id",
                "Nguyet Nga",
                "https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Trinh-Cong-Quyen-277x327.jpg",
                "2939121",
                "doctor.hca.com",
                "Bác sĩ khám mắt",
                "Bác sĩ ABC làm tại bệnh viện XYZ chuyên khám mắt, cận thị, loạn thị, đo kính. \nPhòng khám Bác Sĩ Mắt - 123 đường Phạm Văn Đồng \nSđt phòng khám: 213872132 - 2882138291",
                true),
            Doctor(
                "id",
                "Manh Hung",
                "https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Trinh-Cong-Quyen-277x327.jpg",
                "2939121",
                "doctor.hca.com",
                "Bác sĩ khám mắt",
                "Bác sĩ ABC làm tại bệnh viện XYZ chuyên khám mắt, cận thị, loạn thị, đo kính. \nPhòng khám Bác Sĩ Mắt - 123 đường Phạm Văn Đồng \nSđt phòng khám: 213872132 - 2882138291",
                true),
            Doctor(
                "id",
                "An Tam",
                "https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Trinh-Cong-Quyen-277x327.jpg",
                "2939121",
                "doctor.hca.com",
                "Bác sĩ khám mắt",
                "Bác sĩ ABC làm tại bệnh viện XYZ chuyên khám mắt, cận thị, loạn thị, đo kính. \nPhòng khám Bác Sĩ Mắt - 123 đường Phạm Văn Đồng \nSđt phòng khám: 213872132 - 2882138291",
                true)
          ],
          false),
      DoctorGroup(
          "Khoa Ngoai",
          [
            Doctor(
                "id",
                "Hung",
                "https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Trinh-Cong-Quyen-277x327.jpg",
                "2939121",
                "doctor.hca.com",
                "Bác sĩ khám mắt",
                "Bác sĩ ABC làm tại bệnh viện XYZ chuyên khám mắt, cận thị, loạn thị, đo kính. \nPhòng khám Bác Sĩ Mắt - 123 đường Phạm Văn Đồng \nSđt phòng khám: 213872132 - 2882138291",
                true),
            Doctor(
                "id",
                "Nguyet Nga",
                "https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Trinh-Cong-Quyen-277x327.jpg",
                "2939121",
                "doctor.hca.com",
                "Bác sĩ khám mắt",
                "Bác sĩ ABC làm tại bệnh viện XYZ chuyên khám mắt, cận thị, loạn thị, đo kính. \nPhòng khám Bác Sĩ Mắt - 123 đường Phạm Văn Đồng \nSđt phòng khám: 213872132 - 2882138291",
                true),
            Doctor(
                "id",
                "Manh Hung",
                "https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Trinh-Cong-Quyen-277x327.jpg",
                "2939121",
                "doctor.hca.com",
                "Bác sĩ khám mắt",
                "Bác sĩ ABC làm tại bệnh viện XYZ chuyên khám mắt, cận thị, loạn thị, đo kính. \nPhòng khám Bác Sĩ Mắt - 123 đường Phạm Văn Đồng \nSđt phòng khám: 213872132 - 2882138291",
                true),
            Doctor(
                "id",
                "An Tam",
                "https://www.hanhphuchospital.com/wp-content/uploads/2019/12/Bs-Trinh-Cong-Quyen-277x327.jpg",
                "2939121",
                "doctor.hca.com",
                "Bác sĩ khám mắt",
                "Bác sĩ ABC làm tại bệnh viện XYZ chuyên khám mắt, cận thị, loạn thị, đo kính. \nPhòng khám Bác Sĩ Mắt - 123 đường Phạm Văn Đồng \nSđt phòng khám: 213872132 - 2882138291",
                true)
          ],
          false)
    ];
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
    await CommonService.instance
        .send(MessageIDPath.getHealthData(), {});
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(MessageIDPath.getHealthData(), value))
        data.indicatorsLatestData = HealthPageData.formatIndicatorsList(
            ServerLogic.formatList(
                ServerLogic.getData(value)["indicatorInfo"]));
    });
    return data;
  }

  Future<bool> outCommunity(String id) async {
    community();
    return true;
  }

  Future<bool> joinCommunity(String id) async {
    community();
    return true;
  }

  void updateCommunityGroupOpening(CommunityState state, int index) {
    emit(InitialState());
    for (CommunityGroup x in state.communities) {
      if (x == state.communities[index]) {
        x.isOpening = !x.isOpening;
        continue;
      }
      x.isOpening = false;
    }
    community(state);
  }

  Future<List<MedicalDirectoryData>> getMedicalContacts() async {
    return [
      MedicalDirectoryData(
          "id",
          "Bệnh viện Chợ Rẫy",
          "201B Nguyễn Chí Thanh, phường 12, quận 5, Thành phố Hồ Chí Minh, Việt Nam",
          "02838554137",
          "06:00–16:00",
          "",
          GPS(10.757899397875105, 106.65948982430974)),
      MedicalDirectoryData(
          "id",
          "Bệnh viện Thống Nhất",
          "215 Hồng Bàng, Phường 11, Quận 5, Thành phố Hồ Chí Minh, Việt Nam",
          "02838554269",
          "03:00–16:30",
          "",
          GPS(10.755429618832546, 106.66453507044434)),
      MedicalDirectoryData(
          "id",
          "Bệnh viện Nhân dân Gia Định",
          "215 Hồng Bàng, Phường 11, Quận 5, Thành phố Hồ Chí Minh, Việt Nam",
          "02838554269",
          "03:00–16:30",
          "",
          GPS(10.755429618832546, 106.66453507044434)),
      MedicalDirectoryData(
          "id",
          "Bệnh viện Trưng Vương",
          "201B Nguyễn Chí Thanh, phường 12, quận 5, Thành phố Hồ Chí Minh, Việt Nam",
          "02838554137",
          "06:00–16:00",
          "",
          GPS(10.757899397875105, 106.65948982430974)),
      MedicalDirectoryData(
          "id",
          "Bệnh viện Nhân dân 115",
          "215 Hồng Bàng, Phường 11, Quận 5, Thành phố Hồ Chí Minh, Việt Nam",
          "02838554269",
          "03:00–16:30",
          "",
          GPS(10.755429618832546, 106.66453507044434)),
      MedicalDirectoryData(
          "id",
          "Bệnh viện Đa khoa Thủ Đức",
          "201B Nguyễn Chí Thanh, phường 12, quận 5, Thành phố Hồ Chí Minh, Việt Nam",
          "02838554137",
          "06:00–16:00",
          "",
          GPS(10.757899397875105, 106.65948982430974)),
      MedicalDirectoryData(
          "id",
          "Bệnh viện Đại học Y dược TP.HCM",
          "215 Hồng Bàng, Phường 11, Quận 5, Thành phố Hồ Chí Minh, Việt Nam",
          "02838554269",
          "03:00–16:30",
          "",
          GPS(10.755429618832546, 106.66453507044434)),
      MedicalDirectoryData(
          "id",
          "Trung tâm Da liễu TP.HCM",
          "201B Nguyễn Chí Thanh, phường 12, quận 5, Thành phố Hồ Chí Minh, Việt Nam",
          "02838554137",
          "06:00–16:00",
          "",
          GPS(10.757899397875105, 106.65948982430974)),
      MedicalDirectoryData(
          "id",
          "Trung tâm Răng - Hàm - Mặt TP.HCM",
          "215 Hồng Bàng, Phường 11, Quận 5, Thành phố Hồ Chí Minh, Việt Nam",
          "02838554269",
          "03:00–16:30",
          "",
          GPS(10.755429618832546, 106.66453507044434)),
      MedicalDirectoryData(
          "id",
          "Trung tâm Sức khỏe Tâm Thần",
          "201B Nguyễn Chí Thanh, phường 12, quận 5, Thành phố Hồ Chí Minh, Việt Nam",
          "02838554137",
          "06:00–16:00",
          "",
          GPS(10.757899397875105, 106.65948982430974)),
      MedicalDirectoryData(
          "id",
          "Trung tâm Truyền máu huyết học",
          "215 Hồng Bàng, Phường 11, Quận 5, Thành phố Hồ Chí Minh, Việt Nam",
          "02838554269",
          "03:00–16:30",
          "",
          GPS(10.755429618832546, 106.66453507044434)),
      MedicalDirectoryData(
          "id",
          "Y học dân tộc TP.HCM",
          "201B Nguyễn Chí Thanh, phường 12, quận 5, Thành phố Hồ Chí Minh, Việt Nam",
          "02838554137",
          "06:00–16:00",
          "",
          GPS(10.757899397875105, 106.65948982430974)),
      MedicalDirectoryData(
          "id",
          "Viện Y dược học dân tộc",
          "215 Hồng Bàng, Phường 11, Quận 5, Thành phố Hồ Chí Minh, Việt Nam",
          "02838554269",
          "03:00–16:30",
          "",
          GPS(10.755429618832546, 106.66453507044434)),
      MedicalDirectoryData(
          "id",
          "Viện Răng - Hàm - Mặt TP.HCM",
          "201B Nguyễn Chí Thanh, phường 12, quận 5, Thành phố Hồ Chí Minh, Việt Nam",
          "02838554137",
          "06:00–16:00",
          "",
          GPS(10.757899397875105, 106.65948982430974)),
    ];
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
