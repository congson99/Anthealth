import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/models/health/indicator_models.dart';

class IndicatorState extends CubitState {
  IndicatorState(this.data);

  final IndicatorPageData data;

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class IndicatorLoadingState extends CubitState {
  IndicatorLoadingState(this.data, this.filter);

  final IndicatorPageData data;
  final IndicatorFilter filter;

  @override
  // TODO: implement props
  List<Object> get props => [
        IndicatorPageData(data.getType(), data.getLatestRecord(),
            data.getMoreInfo(), filter, [])
      ];
}
