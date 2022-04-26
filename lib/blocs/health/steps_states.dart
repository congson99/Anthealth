import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/models/health/steps_models.dart';

class StepsState extends CubitState {
  StepsState(this.data, this.monthReport, this.yearReport);

  final StepsDayData data;
  final StepsMonthReport monthReport;
  final StepsYearReport yearReport;

  @override
  List<Object> get props => [data, monthReport, yearReport];
}
