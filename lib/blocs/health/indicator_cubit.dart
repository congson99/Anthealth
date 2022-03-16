import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/common_logic/server_logic.dart';
import 'package:anthealth_mobile/blocs/health/indicator_states.dart';
import 'package:anthealth_mobile/models/health/indicator_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndicatorCubit extends Cubit<CubitState> {
  IndicatorCubit(int type, int filterValue) : super(InitialState()) {
    loadData(type, IndicatorFilter(0, filterValue));
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
    loadData(data.getType(), filter);
  }

  // Service Function
  Future<void> loadData(int type, IndicatorFilter filter) async {
    var temp = {
      "type": type,
      "filterID": filter.getFilterIndex(),
      "filterData": {"year": filter.getFilterValue()}
    };
    await CommonService.instance
        .send(MessageIDPath.getIndicatorData(), temp.toString());
    CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getIndicatorData(), value)) {
        List<IndicatorData> list = IndicatorPageData.formatList(
            filter.getFilterIndex(), ServerLogic.getData(value)["data"]);
        var data = ServerLogic.getData(value)["latest"];
        print(data);
        loadedData(IndicatorPageData(type, IndicatorData(0, DateTime.now(), ''),
            MoreInfo('', ''), filter, list));
      }
    });
  }

  Future<bool> addIndicator(int type, IndicatorData data) async {
    var result = false;
    var temp = {
      "type": type,
      "data": {
        "value": data.getValue().toString(),
        "time": data.getDateTime().millisecondsSinceEpoch ~/ 1000
      }
    };
    await CommonService.instance
        .send(MessageIDPath.addIndicator(), temp.toString());
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(MessageIDPath.addIndicator(), value))
        result = ServerLogic.getData(value)["status"];
    });
    return result;
  }
}
