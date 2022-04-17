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
      MedicalDirectoryData("Benh vien ai da", "_location", "023023023",
          "_workTime", "_note", GPS(10.757899397875105, 106.65948982430974)),
      MedicalDirectoryData("Benh vien asdk", "_location", "023023023",
          "_workTime", "_note", GPS(10.757899397875105, 106.65948982430974)),
      MedicalDirectoryData("benh vien asdk", "_location", "023023023",
          "_workTime", "_note", GPS(10.757899397875105, 106.65948982430974)),
      MedicalDirectoryData("Co so y te asdk", "_location", "023023023",
          "_workTime", "_note", GPS(10.757899397875105, 106.65948982430974)),
      MedicalDirectoryData("co so y te asdk", "_location", "023023023",
          "_workTime", "_note", GPS(10.757899397875105, 106.65948982430974)),
      MedicalDirectoryData("Co so y te asdk", "_location", "023023023",
          "_workTime", "_note", GPS(10.757899397875105, 106.65948982430974)),
      MedicalDirectoryData("Phong kham asdk", "_location", "023023023",
          "_workTime", "_note", GPS(10.757899397875105, 106.65948982430974)),
      MedicalDirectoryData("Phong kham asdk", "_location", "023023023",
          "_workTime", "_note", GPS(10.757899397875105, 106.65948982430974)),
      MedicalDirectoryData("So y te asdk", "_location", "023023023",
          "_workTime", "_note", GPS(10.757899397875105, 106.65948982430974)),
    ]));
  }
}
