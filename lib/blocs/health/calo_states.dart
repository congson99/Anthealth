import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/models/health/calo_models.dart';

class CaloState extends CubitState {
  CaloState(this.data);

  final CaloDayData data;

  @override
  List<Object> get props => [data];
}
