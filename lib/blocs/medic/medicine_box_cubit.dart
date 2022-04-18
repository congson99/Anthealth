import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/medic/medicine_box_state.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
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
    List<MedicineData> medicine = state.medicine;
    if (updateIndex == 0) name = value;
    if (updateIndex == 1)
      for (int i = 0; i < member.length; i++) member[i].isChose = value[i];
    if (updateIndex == 2) medicine.add(value);
    if (updateIndex == 3) {
      int index = value[0];
      MedicineData temp = value[1];
      if (temp.getQuantity() == 0)
        medicine.removeAt(index);
      else
        medicine[index] = temp;
    }
    loadedData(MedicineBoxState(name, medicine, member));
  }

  // Service Function
  Future<void> loadData(String? id) async {
    if (id == null)
      loadedData(MedicineBoxState("", [], [
        MedicineBoxPerson(
            "id",
            "Cong Son",
            "https://thumbs.dreamstime.com/b/happy-person-portrait-smiling-woman-tanned-skin-curly-hair-happy-person-portrait-smiling-young-friendly-woman-197501184.jpg",
            true),
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
    else
      loadedData(MedicineBoxState("Home", [], [
        MedicineBoxPerson(
            "id",
            "Cong Son",
            "https://thumbs.dreamstime.com/b/happy-person-portrait-smiling-woman-tanned-skin-curly-hair-happy-person-portrait-smiling-young-friendly-woman-197501184.jpg",
            true),
        MedicineBoxPerson(
            "id",
            "Cong Son",
            "https://thumbs.dreamstime.com/b/happy-person-portrait-smiling-woman-tanned-skin-curly-hair-happy-person-portrait-smiling-young-friendly-woman-197501184.jpg",
            true),
        MedicineBoxPerson(
            "id",
            "Cong Son",
            "https://thumbs.dreamstime.com/b/happy-person-portrait-smiling-woman-tanned-skin-curly-hair-happy-person-portrait-smiling-young-friendly-woman-197501184.jpg",
            true),
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

  List<String> loadMedicineList() {
    var list = [
      "Panadol Extra with Optizorb sad asdasdsadsdas sa das",
      "Cipogip 500 Tablet",
      "Augmentin 625mg"
    ];
    return list;
  }

  MedicineData getMedicineData(int index) {
    var list = [
      "Panadol Extra with Optizorb sad asdasdsadsdas sa das",
      "Cipogip 500 Tablet",
      "Augmentin 625mg"
    ];
    return MedicineData(
        "",
        list[index],
        0,
        2,
        1,
        "https://drugbank.vn/api/public/gridfs/box-panadol-extra-optizobaddvi-thuoc100190do-chinh-dien-15236089259031797856781.jpg",
        "https://drugbank.vn/thuoc/Panadol-Extra-with-Optizorb&VN-19964-16",
        "note");
  }
}
