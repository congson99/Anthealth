import 'package:anthealth_mobile/blocs/app_state.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardCubit extends Cubit<CubitState> {
  DashboardCubit() : super(InitialState()) {
    home();
  }

  // Initial State
  home() {
    emit(HomeState());
  }

  health() {
    emit(HealthState());
  }

  medic() {
    emit(MedicState());
  }

  family() {
    emit(FamilyState());
  }

  community() {
    emit(CommunityState());
  }
}
