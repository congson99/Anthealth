import 'dart:io';

import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';

class MedicalRecordDetailState extends CubitState {
  MedicalRecordDetailState(
      this.data, this.locationList, this.list, this.medicine);

  final MedicalRecordDetailData data;
  final List<String> locationList;
  final List<List<File>> list;
  final List<DigitalMedicine> medicine;

  @override
  List<Object?> get props => [data, locationList, list, medicine];
}
