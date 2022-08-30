import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/attach/attach_states.dart';
import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:anthealth_mobile/models/family/family_models.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttachCubit extends Cubit<CubitState> {
  AttachCubit() : super(InitialState()) {
    loadData();
  }

  void loadedData() {
    emit(AttachState());
  }

  void loadData() {
    loadedData();
  }

  /// Server Functions
  Future<List<MedicalRecordYearLabel>> getMedicalRecord() async {
    List<MedicalRecordYearLabel> result = [];
    await CommonService.instance
        .send(MessageIDPath.getMedicalRecordPageData(), {});
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getMedicalRecordPageData(), value)) {
        result = MedicalRecordPageData.formatData(
                ServerLogic.getData(value)["listRecord"],
                ServerLogic.getData(value)["listAppointment"])
            .listYearLabel;
      }
    });
    return result;
  }

  Future<List<FamilyMemberData>> getFamily() async {
    List<FamilyMemberData> result = [
      FamilyMemberData(
          "123",
          "Nguyen Van Anh",
          "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg",
          "012013011",
          "ahaha@hca.com",
          true,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1], 1999),
      FamilyMemberData(
          "sd",
          "Van Anh",
          "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg",
          "012013011",
          "ahaha@hca.com",
          true,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1], 1999),
      FamilyMemberData(
          "id",
          "Nguyen Van Anh",
          "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg",
          "012013011",
          "ahaha@hca.com",
          false,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1], 1999),
      FamilyMemberData(
          "id",
          "Nguyen Van Anh",
          "https://reso.movie/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg",
          "012013011",
          "ahaha@hca.com",
          false,
          [1, 1, -1, 1, -1, 0, 1, 1, 0, 1, -1], 1999),
    ];
    return result;
  }
}
