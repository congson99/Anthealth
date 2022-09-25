import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/logics/medicine_logic.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:flutter/cupertino.dart';

class Prescription {
  Prescription(this.id, this.name, this.description, this.medication);

  String id;
  String name;
  String description;
  List<DigitalMedicine> medication;
}

class MedicationReminder {
  MedicationReminder(this.id, this.prescription, this.medicine,
      this.dayReminder, this.allReminder, this.repeat);

  String id;
  Prescription prescription;
  MedicineData medicine;
  List<Reminder> dayReminder;
  List<Reminder> allReminder;
  String repeat;

  static double getQuantity(MedicationReminder reminder) {
    double result = 0;
    for (Reminder x in reminder.allReminder) result += x.quantity;
    return result;
  }

  static double getRemainingQuantity(MedicationReminder reminder) {
    double result = 0;
    for (Reminder x in reminder.allReminder)
      if (x.time.isAfter(DateTime.now())) result += x.quantity;
    return result;
  }

  static MedicationReminder createBase(BuildContext context,
      DigitalMedicine prescription, String name, String description) {
    List<Reminder> dayReminder = [];
    for (int i = 0; i < 4; i++) {
      double quantity = prescription.dosage[i];
      if (quantity > 0) {
        if (i == 0)
          dayReminder.add(Reminder(
              DateTime(1, 1, 1, 7, 0), quantity, S.of(context).morning));
        if (i == 1)
          dayReminder.add(
              Reminder(DateTime(1, 1, 1, 11, 0), quantity, S.of(context).noon));
        if (i == 2)
          dayReminder.add(Reminder(
              DateTime(1, 1, 1, 17, 0), quantity, S.of(context).afternoon));
        if (i == 3)
          dayReminder.add(Reminder(
              DateTime(1, 1, 1, 20, 0), quantity, S.of(context).night));
      }
    }
    double quantity = prescription.quantity;
    List<Reminder> allReminder = [];
    DateTime now = DateTime.now();
    int counter = 0;
    while (quantity > 0) {
      allReminder.add(Reminder(
          DateTime(now.year, now.month, now.day + 1,
              dayReminder[counter].time.hour, dayReminder[counter].time.minute),
          dayReminder[counter].quantity,
          dayReminder[counter].note));
      quantity -= dayReminder[counter].quantity;
      counter = (counter + 1) % dayReminder.length;
    }
    allReminder.last.quantity -= quantity;
    return MedicationReminder(
        "",
        Prescription(prescription.id, name, description, []),
        MedicineData.formatFromDigitalMedicine(prescription),
        dayReminder,
        allReminder,
        MedicineLogic.convertRepeat(prescription.repeat));
  }

  static MedicationReminder createDone(
      double quantity, MedicationReminder reminder, DateTime dateTime) {
    double countQuantity = quantity;
    List<Reminder> allReminder = [];
    int counter = 0;
    while (countQuantity > 0) {
      allReminder.add(Reminder(
          DateTime(
              dateTime.year,
              dateTime.month,
              dateTime.day,
              reminder.dayReminder[counter].time.hour,
              reminder.dayReminder[counter].time.minute),
          reminder.dayReminder[counter].quantity,
          reminder.dayReminder[counter].note));
      countQuantity -= reminder.dayReminder[counter].quantity;
      counter = (counter + 1) % reminder.dayReminder.length;
    }
    allReminder.last.quantity -= countQuantity;
    return MedicationReminder("", reminder.prescription, reminder.medicine,
        reminder.dayReminder, allReminder, reminder.repeat);
  }
}

class Reminder {
  Reminder(this.time, this.quantity, this.note);

  DateTime time;
  double quantity;
  String note;
}

class ReminderMask {
  ReminderMask(this.name, this.medicine, this.time, this.quantity, this.note);

  String name;
  MedicineData medicine;
  DateTime time;
  double quantity;
  String note;
}
