import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/medic/medication_reminder_state.dart';
import 'package:anthealth_mobile/logics/medicine_logic.dart';
import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/models/medic/medication_reminder_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MedicationReminderCubit extends Cubit<CubitState> {
  MedicationReminderCubit() : super(InitialState()) {
    loadMedicationReminder();
  }

  /// Handle States
  void loadedData(MedicationReminderState state) {
    emit(MedicationReminderState(state.time, state.reminder));
  }

  /// Service Functions
  void loadMedicationReminder([DateTime? time]) async {
    emit(InitialState());
    DateTime now = time ?? DateTime.now();
    List<ReminderMask> reminder = [];
    Map<String, dynamic> data = {
      "startTime": DateFormat("yyyy-MM-dd").format(now) + " 00:00:00",
      "endTime": DateFormat("yyyy-MM-dd").format(now) + " 23:59:59"
    };
    await CommonService.instance
        .send(MessageIDPath.getDurationReminder(), data);
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getDurationReminder(), value)) {
        if (ServerLogic.getData(value) != null) {
          for (dynamic x in ServerLogic.getData(value)["data"])
            reminder.add(ReminderMask(
                x["name"],
                MedicineData("", x["name"], 0.0, int.parse(x["unit"]), 0,
                    x["img"], "", ""),
                DateTime.fromMicrosecondsSinceEpoch(x["time"] * 1000000),
                0.0 + x["need_amount"],
                ""));
        }
      }
    });
    loadedData(MedicationReminderState(time ?? DateTime.now(), reminder));
  }

  List<List<MedicationReminder>> getAllReminders() {
    DateTime now = DateTime.now();
    return [[], []];
  }

  Future<List<List<Prescription>>> getSelfPrescriptions() async {
    List<List<Prescription>> result = [[], []];
    await CommonService.instance.send(MessageIDPath.getSelfPrescription(), {});
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getSelfPrescription(), value)) {
        if (value != "null")
          for (dynamic x in ServerLogic.getData(value)["create_prescript"]) {
            List<DigitalMedicine> medication = [];
            for (dynamic y in x["medicine"])
              medication.add(DigitalMedicine(
                  y["id"],
                  y["data"]["name"],
                  0.0 + y["quantity"],
                  int.parse(y["data"]["unit"]),
                  0,
                  MedicineLogic.formatDosage(y["dosages"]),
                  [],
                  int.parse(y["repeat"]),
                  y["data"]["img"],
                  y["data"]["ref"],
                  y["note"]));
            result[1].add(Prescription(x["id"], x["name"], "", medication));
          }
        for (dynamic x in ServerLogic.getData(value)["record_prescript"]) {
          if (x["medicine"].length == 0) continue;
          List<DigitalMedicine> medication = [];
          for (dynamic y in x["medicine"])
            medication.add(DigitalMedicine(
                y["id"],
                y["data"]["name"],
                0.0 + y["quantity"],
                int.parse(y["data"]["unit"]),
                0,
                MedicineLogic.formatDosage(y["dosages"]),
                [],
                int.parse(y["repeat"]),
                y["data"]["img"],
                y["data"]["ref"],
                y["note"]));
          result[0].add(Prescription(
              x["id"],
              x["name"],
              x["desc"]["place"] + " - " + x["desc"]["create_time"],
              medication));
        }
      }
    });
    return result;
  }

  Future<List<Prescription>> getRecordPrescriptions() async {
    List<Prescription> result = [];

    return result;
  }

  Future<bool> stopReminder(MedicationReminder reminder) async {
    return true;
  }

  Future<bool> addReminder(List<MedicationReminder> reminder) async {
    bool result = false;
    List<Map<String, Object>> medicines = [];
    for (MedicationReminder x in reminder) {
      List<Map<String, dynamic>> dosages = [];
      for (Reminder y in x.dayReminder) {
        dosages.add(
            {"amount": y.quantity, "time": DateFormat("HH:mm").format(y.time)});
      }
      medicines.add({
        "quantity": MedicationReminder.getQuantity(x),
        "id": x.medicine.getId(),
        "repeat": x.repeat,
        "startTime":
            DateFormat("yyyy-MM-dd HH:mm:ss").format(x.allReminder[0].time),
        "dosages": dosages
      });
    }
    Map<String, dynamic> data = {
      "prescriptId": reminder[0].prescription.id,
      "medicine": medicines
    };
    await CommonService.instance.send(MessageIDPath.addReminder(), data);
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(MessageIDPath.addReminder(), value)) {
        if (ServerLogic.getData(value) != null)
          result = ServerLogic.getData(value)["status"];
      }
    });
    return result;
  }

  Future<bool> addPrescription(Prescription prescription) async {
    bool result = false;
    List<Map<String, dynamic>> medication = [];
    for (DigitalMedicine x in prescription.medication)
      medication.add({
        "id": x.id,
        "repeat": MedicineLogic.convertRepeat(x.repeat),
        "note": x.note,
        "dosages": MedicineLogic.dosages(x.dosage),
        "quantity": x.quantity
      });
    Map<String, dynamic> data = {
      "name": prescription.name,
      "medicine": medication
    };
    await CommonService.instance
        .send(MessageIDPath.addSelfPrescription(), data);
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.addSelfPrescription(), value)) {
        if (ServerLogic.getData(value) != null)
          result = ServerLogic.getData(value)["status"];
      }
    });
    return result;
  }
}
