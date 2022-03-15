import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/common_logic/server_logic.dart';
import 'package:anthealth_mobile/blocs/medic/medical_record_states.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalRecordCubit extends Cubit<CubitState> {
  MedicalRecordCubit() : super(InitialState()) {
    loadData();
  }

  // Initial State
  void loadedData(MedicalRecordPageData data) {
    emit(MedicalRecordState(data));
  }

  // Update data
  void updateData() {
    loadData();
  }

  void updateOpeningState(int index, MedicalRecordPageData data) {
    loadedData(MedicalRecordPageData.changeOpeningState(index, data));
  }

  // Service Function
  Future<void> loadData() async {
    await CommonService.instance.send(MessageIDPath.checkConnect(), "");
    CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.checkConnect(), value)) {
        loadedData(MedicalRecordPageData([
          MedicalRecordYearLabel(
              DateTime.now(),
              2,
              [
                MedicalRecordLabel(DateTime.now(), '_location', '_name'),
                MedicalRecordLabel(DateTime.now(), '_loca2tion', '_nam2e')
              ],
              false),
          MedicalRecordYearLabel(
              DateTime.now(),
              3,
              [
                MedicalRecordLabel(DateTime.now(), '_location', '_name'),
                MedicalRecordLabel(DateTime.now(), '_loca2tion', '_nam2e'),
                MedicalRecordLabel(DateTime.now(), '_loca2tion', '_nam2e')
              ],
              false)
        ], [
          MedicalAppointment(
              DateTime.now(), "_location", DateTime.now(), "_name"),MedicalAppointment(
              DateTime.now(), "_location", DateTime.now(), "_name")
        ]));
      }
    });
  }
}
