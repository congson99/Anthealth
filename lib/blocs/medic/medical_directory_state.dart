import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/models/medic/medical_directory_models.dart';

class MedicalDirectoryState extends CubitState {
  MedicalDirectoryState(this.location, this.data);

  final String location;
  final List<MedicalDirectoryData> data;

  @override
  List<Object?> get props => [location, data];
}
