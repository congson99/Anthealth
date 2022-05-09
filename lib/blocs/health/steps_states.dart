import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/models/health/steps_models.dart';

class StepsState extends CubitState {
  StepsState(this.data);

  final StepsDayData data;

  @override
  List<Object> get props => [data];
}
