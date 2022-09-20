import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/medic/medication_reminder_state.dart';
import 'package:anthealth_mobile/logics/medicine_logic.dart';
import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/models/medic/medication_reminder_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    DateTime now = DateTime.now();
    List<ReminderMask> reminder = [
      ReminderMask(
          "Name",
          MedicineData(
              "",
              "Paradol Paradol ",
              30,
              0,
              0,
              "https://drugbank.vn/api/public/gridfs/box-panadol-extra-optizobaddvi-thuoc100190do-chinh-dien-15236089259031797856781.jpg",
              "https://drugbank.vn/thuoc/Panadol-Extra-with-Optizorb&VN-19964-16",
              ""),
          DateTime(now.year, now.month, now.day, 7, 0),
          1,
          ""),
      ReminderMask(
          "Name",
          MedicineData(
              "",
              "Paradad as dol",
              30,
              0,
              0,
              "https://drugbank.vn/api/public/gridfs/box-panadol-extra-optizobaddvi-thuoc100190do-chinh-dien-15236089259031797856781.jpg",
              "https://drugbank.vn/thuoc/Panadol-Extra-with-Optizorb&VN-19964-16",
              ""),
          DateTime(now.year, now.month, now.day, 7, 0),
          1,
          ""),
      ReminderMask(
          "Name",
          MedicineData(
              "",
              "Paras adol",
              30,
              2,
              0,
              "https://drugbank.vn/api/public/gridfs/box-panadol-extra-optizobaddvi-thuoc100190do-chinh-dien-15236089259031797856781.jpg",
              "https://drugbank.vn/thuoc/Panadol-Extra-with-Optizorb&VN-19964-16",
              ""),
          DateTime(now.year, now.month, now.day, 11, 30),
          1,
          ""),
      ReminderMask(
          "XX",
          MedicineData(
              "",
              "Pemol",
              24,
              0,
              2,
              "https://drugbank.vn/api/public/gridfs/box-panadol-extra-optizobaddvi-thuoc100190do-chinh-dien-15236089259031797856781.jpg",
              "https://drugbank.vn/thuoc/Panadol-Extra-with-Optizorb&VN-19964-16",
              "Morning"),
          DateTime(now.year, now.month, now.day, 17, 0),
          1,
          ""),
      ReminderMask(
          "XX",
          MedicineData(
              "",
              "Peas da mol",
              24,
              1,
              2,
              "https://drugbank.vn/api/public/gridfs/box-panadol-extra-optizobaddvi-thuoc100190do-chinh-dien-15236089259031797856781.jpg",
              "https://drugbank.vn/thuoc/Panadol-Extra-with-Optizorb&VN-19964-16",
              "Morning"),
          DateTime(now.year, now.month, now.day, 17, 0),
          200,
          ""),
      ReminderMask(
          "XX",
          MedicineData(
              "",
              "Peas dmol",
              24,
              0,
              2,
              "https://drugbank.vn/api/public/gridfs/box-panadol-extra-optizobaddvi-thuoc100190do-chinh-dien-15236089259031797856781.jpg",
              "https://drugbank.vn/thuoc/Panadol-Extra-with-Optizorb&VN-19964-16",
              "Morning"),
          DateTime(now.year, now.month, now.day, 22, 30),
          1,
          "")
    ];
    loadedData(MedicationReminderState(time ?? DateTime.now(), reminder));
  }

  List<List<MedicationReminder>> getAllReminders() {
    DateTime now = DateTime.now();
    return [
      [
        MedicationReminder(
            "id",
            Prescription("", "pre X", "BV Y", []),
            MedicineData(
                "",
                "Peas dmol",
                24,
                0,
                2,
                "https://drugbank.vn/api/public/gridfs/box-panadol-extra-optizobaddvi-thuoc100190do-chinh-dien-15236089259031797856781.jpg",
                "https://drugbank.vn/thuoc/Panadol-Extra-with-Optizorb&VN-19964-16",
                "Morning"),
            [
              Reminder(DateTime(now.year, now.month, now.day, 7, 0), 2, ""),
              Reminder(DateTime(now.year, now.month, now.day, 12, 0), 1, ""),
              Reminder(DateTime(now.year, now.month, now.day, 17, 30), 1, "")
            ],
            [
              Reminder(
                  DateTime(now.year, now.month, now.day - 2, 12, 0), 1, ""),
              Reminder(
                  DateTime(now.year, now.month, now.day - 2, 17, 30), 1, ""),
              Reminder(DateTime(now.year, now.month, now.day - 1, 7, 0), 2, ""),
              Reminder(
                  DateTime(now.year, now.month, now.day - 1, 12, 0), 1, ""),
              Reminder(
                  DateTime(now.year, now.month, now.day - 1, 17, 30), 1, ""),
              Reminder(DateTime(now.year, now.month, now.day, 7, 0), 2, ""),
              Reminder(DateTime(now.year, now.month, now.day, 12, 0), 1, ""),
              Reminder(DateTime(now.year, now.month, now.day, 17, 30), 1, ""),
              Reminder(DateTime(now.year, now.month, now.day + 1, 7, 0), 2, ""),
              Reminder(
                  DateTime(now.year, now.month, now.day + 1, 12, 0), 1, ""),
              Reminder(
                  DateTime(now.year, now.month, now.day + 1, 17, 30), 1, ""),
              Reminder(DateTime(now.year, now.month, now.day + 2, 7, 0), 2, "")
            ])
      ],
      [
        MedicationReminder(
            "id",
            Prescription("", "pre X", "BV Y", []),
            MedicineData(
                "",
                "Peas dmol",
                24,
                0,
                2,
                "https://drugbank.vn/api/public/gridfs/box-panadol-extra-optizobaddvi-thuoc100190do-chinh-dien-15236089259031797856781.jpg",
                "https://drugbank.vn/thuoc/Panadol-Extra-with-Optizorb&VN-19964-16",
                "Morning"),
            [
              Reminder(DateTime(now.year, now.month, now.day, 11, 0), 1, ""),
              Reminder(DateTime(now.year, now.month, now.day, 19, 0), 1, ""),
            ],
            [
              Reminder(
                  DateTime(now.year, now.month, now.day - 20, 11, 0), 1, ""),
              Reminder(
                  DateTime(now.year, now.month, now.day - 20, 19, 0), 1, ""),
              Reminder(
                  DateTime(now.year, now.month, now.day - 19, 11, 0), 1, ""),
              Reminder(
                  DateTime(now.year, now.month, now.day - 19, 19, 0), 1, ""),
              Reminder(
                  DateTime(now.year, now.month, now.day - 18, 11, 0), 1, ""),
              Reminder(
                  DateTime(now.year, now.month, now.day - 18, 19, 0), 1, ""),
            ])
      ]
    ];
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
    return true;
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
