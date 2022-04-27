import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/medic/medical_directory_state.dart';
import 'package:anthealth_mobile/models/common/gps_models.dart';
import 'package:anthealth_mobile/models/medic/medical_directory_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalDirectoryCubit extends Cubit<CubitState> {
  MedicalDirectoryCubit() : super(InitialState()) {
    loadData();
  }

  // Initial State
  void loadedData(MedicalDirectoryState state) {
    emit(MedicalDirectoryState(state.location, state.data));
  }

  // Update data
  void updateData() {
    loadData();
  }

  // Service Function
  void loadData() async {
    loadedData(MedicalDirectoryState("Tp. Hồ Chí Minh", [
      MedicalDirectoryData(
          "Bệnh viện Chợ Rẫy",
          "201B Nguyễn Chí Thanh, phường 12, quận 5, Thành phố Hồ Chí Minh, Việt Nam",
          "02838554137",
          "06:00–16:00",
          "",
          GPS(10.757899397875105, 106.65948982430974)),
      MedicalDirectoryData(
          "Bệnh viện Đại học Y dược TP.HCM",
          "215 Hồng Bàng, Phường 11, Quận 5, Thành phố Hồ Chí Minh, Việt Nam",
          "02838554269",
          "03:00–16:30",
          "",
          GPS(10.755429618832546, 106.66453507044434)),
    ]));
  }
}
