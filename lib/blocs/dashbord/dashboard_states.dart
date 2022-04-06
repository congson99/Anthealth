import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/models/dashboard/dashboard_models.dart';

class HomeState extends CubitState {
  @override
  List<Object> get props => [];
}

class HealthState extends CubitState {
  HealthState(this.healthPageData);

  final HealthPageData healthPageData;

  @override
  List<Object> get props => [healthPageData];
}

class MedicState extends CubitState {
  MedicState(this.medicPageData);

  final MedicPageData medicPageData;

  @override
  List<Object> get props => [medicPageData];
}

class FamilyState extends CubitState {
  @override
  List<Object> get props => [];
}

class CommunityState extends CubitState {
  @override
  List<Object> get props => [];
}

class HomeLoadingState extends CubitState {
  @override
  List<Object> get props => [];
}

class HealthLoadingState extends CubitState {
  @override
  List<Object> get props => [];
}

class MedicLoadingState extends CubitState {
  @override
  List<Object> get props => [];
}

class FamilyLoadingState extends CubitState {
  @override
  List<Object> get props => [];
}

class CommunityLoadingState extends CubitState {
  @override
  List<Object> get props => [];
}