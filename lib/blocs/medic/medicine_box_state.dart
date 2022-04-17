import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';

class MedicineBoxState extends CubitState {
  MedicineBoxState(this.name, this.medicine, this.member);

  final String name;
  final List<MedicineData> medicine;
  final List<MedicineBoxPerson> member;

  @override
  List<Object?> get props => [name, medicine, member];
}

class MedicineBoxPerson {
  MedicineBoxPerson(this.id, this.name, this.avatarPath, this.isChose);

  final String id;
  final String name;
  final String avatarPath;
  bool isChose;
}
