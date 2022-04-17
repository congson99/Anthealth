import 'package:anthealth_mobile/blocs/app_states.dart';

class MedicalDirectoryState extends CubitState {
  MedicalDirectoryState(this.locationNameList, this.index, this.data);

  final List<String> locationNameList;
  final int index;
  final List<String> data;

  @override
  List<Object?> get props => [locationNameList, index, data];
}
