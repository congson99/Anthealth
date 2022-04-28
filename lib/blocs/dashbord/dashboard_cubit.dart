import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/logics/server_logic.dart';
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
      FamilyMemberLabelData("0", "Ho Cong Son",
          "https://www.diethelmtravel.com/wp-content/uploads/2016/04/bill-gates-wealthiest-person.jpg"),
      FamilyMemberLabelData("1", "Le Van A",
          "https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg"),
      FamilyMemberLabelData("2", "Nguyen Van B",
          "https://content.fortune.com/wp-content/uploads/2018/07/gettyimages-961697338.jpg"),
      FamilyMemberLabelData("3", "Tran Thi C",
          "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg"),
      FamilyMemberLabelData("0", "Ho Cong Son",
          "https://www.diethelmtravel.com/wp-content/uploads/2016/04/bill-gates-wealthiest-person.jpg"),
      FamilyMemberLabelData("1", "Le Van A",
          "https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg"),
      FamilyMemberLabelData("2", "Nguyen Van B",
          "https://content.fortune.com/wp-content/uploads/2018/07/gettyimages-961697338.jpg"),
      FamilyMemberLabelData("3", "Tran Thi C",
          "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg"),
    ]));
  }

  community() {
    emit(CommunityState());
  }
}
