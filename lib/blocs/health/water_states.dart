import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/models/health/water_models.dart';

class WaterState extends CubitState {
  WaterState(this.data, this.monthReport, this.yearReport);

  final WaterDayData data;
  final WaterMonthReport monthReport;
  final WaterYearReport yearReport;

  @override
  List<Object> get props => [data, monthReport, yearReport];
}
