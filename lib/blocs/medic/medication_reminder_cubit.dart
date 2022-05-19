import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/medic/medication_reminder_state.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/models/medic/medication_reminder_models.dart';
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

  List<List<Prescription>> getAllPrescriptions() {
    return [
      [
        Prescription("", "Thuoc Bo Hang Ngay", "", [
          DigitalMedicine(
              "",
              "Peas dmol",
              24,
              0,
              2,
              [1, 1, 0, 0],
              [],
              00000001,
              "https://drugbank.vn/api/public/gridfs/box-panadol-extra-optizobaddvi-thuoc100190do-chinh-dien-15236089259031797856781.jpg",
              "https://drugbank.vn/thuoc/Panadol-Extra-with-Optizorb&VN-19964-16",
              "Morning"),
          DigitalMedicine(
              "",
              "Peas dmosa da sl",
              24,
              0,
              2,
              [0, 1, 1, 0],
              [],
              00000001,
              "https://drugbank.vn/api/public/gridfs/box-panadol-extra-optizobaddvi-thuoc100190do-chinh-dien-15236089259031797856781.jpg",
              "https://drugbank.vn/thuoc/Panadol-Extra-with-Optizorb&VN-19964-16",
              "Morning")
        ])
      ],
      [
        Prescription("", "Kham Mat", "(20.10.2022) BV Cho Ray", [
          DigitalMedicine(
              "",
              "Peas dmol",
              24,
              0,
              2,
              [1, 0, 1, 1],
              [],
              00000001,
              "https://drugbank.vn/api/public/gridfs/box-panadol-extra-optizobaddvi-thuoc100190do-chinh-dien-15236089259031797856781.jpg",
              "https://drugbank.vn/thuoc/Panadol-Extra-with-Optizorb&VN-19964-16",
              "Morning"),
          DigitalMedicine(
              "",
              "Peas dmosa da sl",
              24,
              0,
              2,
              [1, 1, 1, 1],
              [],
              00000001,
              "https://drugbank.vn/api/public/gridfs/box-panadol-extra-optizobaddvi-thuoc100190do-chinh-dien-15236089259031797856781.jpg",
              "https://drugbank.vn/thuoc/Panadol-Extra-with-Optizorb&VN-19964-16",
              "Morning")
        ])
      ]
    ];
  }

  Future<bool> stopReminder(MedicationReminder reminder) async {
    return true;
  }

  Future<bool> addReminder(List<MedicationReminder> reminder) async {
    return true;
  }

  Future<bool> addPrescription(Prescription prescription) async {
    return true;
  }
}
