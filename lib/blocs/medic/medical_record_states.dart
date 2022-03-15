import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';

class MedicalRecordState extends CubitState {
  MedicalRecordState(this.data);

  final MedicalRecordPageData data;

  @override
  List<Object?> get props => [data];
}
