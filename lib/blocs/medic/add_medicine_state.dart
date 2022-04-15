import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:flutter/material.dart';

class AddMedicineState extends CubitState {
  AddMedicineState(this.data, this.medicineNameList, this.customDosage,
      this.countCustomDosage);

  final DigitalMedicine data;
  final List<String> medicineNameList;
  final List<TempCustomDosage> customDosage;
  final int countCustomDosage;

  @override
  List<Object?> get props =>
      [data, medicineNameList, customDosage, countCustomDosage];
}

class TempCustomDosage {
  TempCustomDosage(this.isShow, this.time, this.quantity);

  bool isShow;
  String time;
  double quantity;
}
