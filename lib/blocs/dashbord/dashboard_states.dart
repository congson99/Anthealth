import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/models/community/community_models.dart';
import 'package:anthealth_mobile/models/dashboard/dashboard_models.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';

class HomeState extends CubitState {
  HomeState(this.events);

  final List<dynamic> events;

  @override
  List<Object> get props => [events];
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
  FamilyState(this.members);

  final List<FamilyMemberData> members;

  @override
  List<Object> get props => [members];
}

class CommunityState extends CubitState {
  CommunityState(this.communities);

  final List<CommunityGroup> communities;

  @override
  List<Object> get props => [communities];
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
