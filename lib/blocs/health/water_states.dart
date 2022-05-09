import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/models/health/water_models.dart';

class WaterState extends CubitState {
  WaterState(this.data);

  final WaterDayData data;

  @override
  List<Object> get props => [data];
}
