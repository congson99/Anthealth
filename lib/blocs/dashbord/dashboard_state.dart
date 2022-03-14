import 'package:anthealth_mobile/blocs/app_state.dart';
import 'package:anthealth_mobile/models/dashboard/dashboard_models.dart';

class HomeState extends CubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HealthState extends CubitState {
  HealthState(this.healthPageData);

  final HealthPageData healthPageData;

  @override
  // TODO: implement props
  List<Object> get props => [healthPageData];
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


class HomeLoadingState extends CubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HealthLoadingState extends CubitState {

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MedicLoadingState extends CubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FamilyLoadingState extends CubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CommunityLoadingState extends CubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
