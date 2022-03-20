import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/common_logic/server_logic.dart';
import 'package:anthealth_mobile/blocs/health/indicator_states.dart';
import 'package:anthealth_mobile/models/health/indicator_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndicatorCubit extends Cubit<CubitState> {
  IndicatorCubit(int type, int filterID) : super(InitialState()) {
    loadData(type, IndicatorFilter(filterID, DateTime.now()));
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
    await CommonService.instance.send(MessageIDPath.getIndicatorData(),
        IndicatorPageData.formatToSendLoadData(type, filter));
    CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getIndicatorData(), value)) {
        loadedData(IndicatorPageData.getPageData(type, filter, value));
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

  Future<bool> deleteIndicator(int type, IndicatorData data, int owner) async {
    var result = false;
    var temp = {
      "type": type,
      "data": {
        "time": data.getDateTime().millisecondsSinceEpoch ~/ 1000,
        "owner": owner,
      }
    };
    await CommonService.instance
        .send(MessageIDPath.deleteIndicator(), temp.toString());
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.deleteIndicator(), value))
        result = ServerLogic.getData(value)["status"];
    });
    return result;
  }

  Future<bool> editIndicator(
      int type, IndicatorData oldData, IndicatorData newData, int owner) async {
    var result = false;
    await deleteIndicator(type, oldData, owner).then((value) async {
      if (value)
        await addIndicator(type, newData).then((value2) {
          if (value2) result = true;
        });
    });
    return result;
  }
}
