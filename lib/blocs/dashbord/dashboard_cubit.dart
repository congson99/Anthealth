import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/common_logic/server_logic.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/models/dashboard/dashboard_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardCubit extends Cubit<CubitState> {
  DashboardCubit() : super(InitialState()) {
    home();
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

  medic() {
    emit(MedicState(MedicPageData(
        "18.10.2021 - BV Chợ Rẫy",
        "21.02.2022 - BV ĐHYD",
        ["Hộp thuốc ở nhà", "Hộp thuốc nhà nội", "Hộp thuốc dự phòng"])));
  }

  family() {
    emit(FamilyState());
  }

  community() {
    emit(CommunityState());
  }
}
