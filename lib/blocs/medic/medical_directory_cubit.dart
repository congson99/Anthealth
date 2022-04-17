import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/medic/medical_directory_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalDirectoryCubit extends Cubit<CubitState> {
  MedicalDirectoryCubit() : super(InitialState()) {
    loadData();
  }

  // Initial State
  void loadedData(MedicalDirectoryState state) {
    emit(
        MedicalDirectoryState(state.locationNameList, state.index, state.data));
  }

  // Update data
  void updateData() {
    loadData();
  }

  // Service Function
  void loadData() async {
    loadedData(MedicalDirectoryState(["Hồ Chí Minh"], 0, []));
  }
}
