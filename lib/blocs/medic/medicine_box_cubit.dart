import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/medic/medicine_box_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicineBoxCubit extends Cubit<CubitState> {
  MedicineBoxCubit([String? id]) : super(InitialState()) {
    loadData(id);
  }

  // Initial State
  void loadedData(MedicineBoxState state) {
    emit(MedicineBoxState(state.name, state.medicine, state.member));
  }

  // Update data
  Future<void> updateData(
      MedicineBoxState state, int updateIndex, dynamic value) async {
    emit(InitialState());
    String name = state.name;
    List<MedicineBoxPerson> member = state.member;
    if (updateIndex == 0) name = value;
    if (updateIndex == 1) {
      for (int i = 0; i < member.length; i++) member[i].isChose = value[i];
    }
    loadedData(MedicineBoxState(name, state.medicine, member));
  }

  // Service Function
  Future<void> loadData(String? id) async {
    if (id == null)
      loadedData(MedicineBoxState("", [], [
        MedicineBoxPerson(
            "id",
            "Cong Son",
            "https://thumbs.dreamstime.com/b/happy-person-portrait-smiling-woman-tanned-skin-curly-hair-happy-person-portrait-smiling-young-friendly-woman-197501184.jpg",
            false),
        MedicineBoxPerson(
            "id",
            "Cong Son",
            "https://thumbs.dreamstime.com/b/happy-person-portrait-smiling-woman-tanned-skin-curly-hair-happy-person-portrait-smiling-young-friendly-woman-197501184.jpg",
            false),
        MedicineBoxPerson(
            "id",
            "Cong Son",
            "https://thumbs.dreamstime.com/b/happy-person-portrait-smiling-woman-tanned-skin-curly-hair-happy-person-portrait-smiling-young-friendly-woman-197501184.jpg",
            false),
        MedicineBoxPerson(
            "id",
            "Cong Son",
            "https://thumbs.dreamstime.com/b/happy-person-portrait-smiling-woman-tanned-skin-curly-hair-happy-person-portrait-smiling-young-friendly-woman-197501184.jpg",
            false),
        MedicineBoxPerson(
            "id",
            "Cong Son",
            "https://thumbs.dreamstime.com/b/happy-person-portrait-smiling-woman-tanned-skin-curly-hair-happy-person-portrait-smiling-young-friendly-woman-197501184.jpg",
            false),
      ]));
  }
}
