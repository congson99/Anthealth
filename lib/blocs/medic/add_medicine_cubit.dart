import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/medic/add_medicine_state.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMedicineCubit extends Cubit<CubitState> {
  AddMedicineCubit(DigitalMedicine? medicine) : super(InitialState()) {
    loadData(medicine);
  }

  // Initial State
  void loadedData(DigitalMedicine data, List<String> medicineNameList,
      List<TempCustomDosage> customDosage, int count) {
    emit(AddMedicineState(data, medicineNameList, customDosage, count));
  }

  // Update data
  Future<void> updateData(
      AddMedicineState state, int updateIndex, dynamic value) async {
    emit(InitialState());
    DigitalMedicine digitalMedicine = state.data;
    List<TempCustomDosage> customDosage = state.customDosage;
    int count = state.countCustomDosage;
    if (updateIndex == 0) {
      print(value.runtimeType);
      digitalMedicine = DigitalMedicine.updateQuantity(state.data, value);
    }
    if (updateIndex == 1)
      digitalMedicine = DigitalMedicine.updateDosage(state.data, value);
    if (updateIndex == 2) {
      print(customDosage.length);
      customDosage[count].isShow = true;
      count++;
    }
    if (updateIndex == 3) customDosage[value].isShow = false;
    if (updateIndex == 4) customDosage[int.parse(value[0])].time = value[1];
    if (updateIndex == 5)
      customDosage[int.parse(value[0])].quantity = double.parse(value[1]);
    if (updateIndex == 6)
      digitalMedicine = DigitalMedicine.updateRepeat(state.data, value);
    if (updateIndex == 7)
      digitalMedicine = DigitalMedicine.updateNote(state.data, value);
    loadedData(digitalMedicine, state.medicineNameList, customDosage, count);
  }

  // Service Function
  Future<void> loadData(DigitalMedicine? medicine) async {
    List<String> medicineNameList = [
      "Panadol Extra with Optizorb",
      "Cipogip 500 Tablet",
      "Augmentin 625mg"
    ];
    DigitalMedicine digitalMedicine =
        DigitalMedicine("", "", 0, 0, 0, [0, 0, 0, 0], [], 0, "", "");
    List<TempCustomDosage> tempCustomDosage = [];
    int count = 0;
    if (medicine != null) {
      digitalMedicine = medicine;
      for (int i = 0; i < 50; i++)
        tempCustomDosage.add(TempCustomDosage(false, "", 0));
      for (int i = 0; i < medicine.getCustomDosage().length; i++) {
        tempCustomDosage[i] = TempCustomDosage(
            true,
            medicine.getCustomDosage()[i].getTime(),
            medicine.getCustomDosage()[i].getQuantity());
      }
      count = medicine.getCustomDosage().length;
    }
    loadedData(digitalMedicine, medicineNameList, tempCustomDosage, count);
  }

  Future<void> loadMedicine(int index) async {
    emit(InitialState());
    var list = [
      "Panadol Extra with Optizorb",
      "Cipogip 500 Tablet",
      "Augmentin 625mg"
    ];
    List<TempCustomDosage> tempCustomDosage = [];
    for (int i = 0; i < 50; i++)
      tempCustomDosage.add(TempCustomDosage(false, "", 0));
    loadedData(
        DigitalMedicine(
            index.toString(),
            list[index],
            0,
            0,
            0,
            [0, 0, 0, 0],
            [],
            0,
            "https://drugbank.vn/api/public/gridfs/box-panadol-extra-optizobaddvi-thuoc100190do-chinh-dien-15236089259031797856781.jpg",
            "https://drugbank.vn/thuoc/Panadol-Extra-with-Optizorb&VN-19964-16"),
        list,
        tempCustomDosage,
        0);
  }

  DigitalMedicine addMedicine(AddMedicineState state) {
    List<DigitalCustomMedicineDosage> customDosage = [];
    for (TempCustomDosage x in state.customDosage) {
      if (x.isShow == true && x.time != "" && x.quantity > 0)
        customDosage.add(DigitalCustomMedicineDosage(x.time, x.quantity));
    }
    DigitalMedicine result = DigitalMedicine(
        "",
        state.data.getName(),
        state.data.getQuantity(),
        state.data.getUnit(),
        state.data.getUsage(),
        state.data.getDosage(),
        customDosage,
        (state.data.getRepeat() == -1) ? 1 : state.data.getRepeat(),
        state.data.getImagePath(),
        state.data.getURL(),
        state.data.getNote());
    return result;
  }
}
