import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:anthealth_mobile/models/community/community_models.dart';
import 'package:anthealth_mobile/models/dashboard/dashboard_models.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardCubit extends Cubit<CubitState> {
  DashboardCubit() : super(InitialState()) {
    health();
  }

  // Initial State
  home() {
    emit(HomeState());
  }

  health() async {
    emit(HealthLoadingState());
    await CommonService.instance
        .send(MessageIDPath.getHealthData(), {}.toString());
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

  medic() async {
    emit(MedicLoadingState());
    await CommonService.instance
        .send(MessageIDPath.getMedicData(), {}.toString());
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
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1]),
      FamilyMemberData(
          "sd",
          "Van Anh",
          "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg",
          "012013011",
          "ahaha@hca.com",
          true,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1]),
      FamilyMemberData(
          "id",
          "Nguyen Van Anh",
          "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg",
          "012013011",
          "ahaha@hca.com",
          false,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1]),
      FamilyMemberData(
          "id",
          "Nguyen Van Anh",
          "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg",
          "012013011",
          "ahaha@hca.com",
          false,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1]),
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
          "", "", "", "", "", false, [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1]);
    return FamilyMemberData(
        "id",
        "Nguyen Van Anh",
        "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg",
        "012013011",
        "ahaha@hca.com",
        false,
        [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1]);
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
}
