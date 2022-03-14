import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/common_logic/server_logic.dart';
import 'package:anthealth_mobile/blocs/health/indicator_states.dart';
import 'package:anthealth_mobile/models/health/indicator_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndicatorCubit extends Cubit<CubitState> {
  IndicatorCubit(int filterValue) : super(InitialState()) {
    loadData(IndicatorFilter(0, filterValue));
  }

  // Initial State
  void loadedData(IndicatorPageData data) {
    emit(IndicatorState(data));
  }

  void loadingData(IndicatorPageData data, IndicatorFilter filter) {
    emit(IndicatorLoadingState(data, filter));
  }

  // Update data
  void updateData(IndicatorPageData data, IndicatorFilter filter) {
    loadingData(data, filter);
    loadData(filter);
  }

  // Service Function
  Future<void> loadData(IndicatorFilter filter) async {
    await CommonService.instance.send(MessageIDPath.checkConnect(), "");
    CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.checkConnect(), value)) {
        loadedData(IndicatorPageData(0, IndicatorData(0, DateTime.now(), ''),
            MoreInfo('', ''), filter, []));
      }
    });
  }
}
