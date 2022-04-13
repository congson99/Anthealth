import 'dart:io';

import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';

class MedicalRecordDetailState extends CubitState {
  MedicalRecordDetailState(this.data, this.locationList, this.list);

  final MedicalRecordDetailData data;
  final List<String> locationList;
  final List<List<File>> list;

  @override
  List<Object?> get props => [data, locationList, list];
}
