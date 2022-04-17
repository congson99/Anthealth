import 'package:anthealth_mobile/blocs/medic/medicine_box_state.dart';

class BoxMedicineLogic {
  static bool isNoMember(List<MedicineBoxPerson> members) {
    for (MedicineBoxPerson x in members) if (x.isChose) return false;
    return true;
  }

  static List<MedicineBoxPerson> filterChosenPerson(
      List<MedicineBoxPerson> resource) {
    List<MedicineBoxPerson> result = [];
    for (MedicineBoxPerson x in resource) if (x.isChose) result.add(x);
    return result;
  }
}
