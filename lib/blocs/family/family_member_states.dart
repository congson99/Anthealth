import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';

class FamilyMemberState extends CubitState {
  FamilyMemberState(this.data);

  final FamilyMemberData data;

  @override
  List<Object?> get props => [data];
}
