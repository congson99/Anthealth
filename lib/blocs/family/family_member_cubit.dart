import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/family/family_member_states.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FamilyMemberCubit extends Cubit<CubitState> {
  FamilyMemberCubit(String id) : super(InitialState()) {
    loadData(id);
  }

  loadedData(FamilyMemberState state) {
    emit(FamilyMemberState(state.data));
  }

  loadData(String id) {
    loadedData(FamilyMemberState(FamilyMemberData(
        id,
        "Nguyen Van Anh",
        "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg",
        "012013011",
        "ahaha@hca.com",
        [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1])));
  }
}
