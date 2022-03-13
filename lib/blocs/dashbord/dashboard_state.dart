import 'package:anthealth_mobile/blocs/app_state.dart';

class HomeState extends CubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HealthState extends CubitState {
  HealthState(this.name);

  final String name;

  @override
  // TODO: implement props
  List<Object> get props => [name];
}

class MedicState extends CubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FamilyState extends CubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CommunityState extends CubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
