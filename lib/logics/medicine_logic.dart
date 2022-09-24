import 'dart:math';

import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:flutter/cupertino.dart';

class MedicineLogic {
  // String handle
  static String handleMedicineString(
      BuildContext context, DigitalMedicine medicine) {
    String result = "";
    result += MedicineLogic.getUsage(context, medicine.usage);
    if (medicine.repeat > 0)
      result += " | " + MedicineLogic.getRepeat(context, medicine.repeat);
    result += " | " +
        MedicineLogic.getDosage(
            context, medicine.dosage, medicine.customDosage, medicine.unit);
    if (medicine.note != "") result += " | " + medicine.note;
    return result;
  }

  static List<Map<String, dynamic>> dosages(List<double> dosage) {
    List<Map<String, dynamic>> dosages = [];
    for (int i = 0; i < 4; i++) {
      switch (i) {
        case (0):
          if (dosage[0] != 0.0) {
            dosages.add({"time": "07:00", "amount": dosage[0]});
          }
          break;
        case (1):
          if (dosage[1] != 0.0) {
            dosages.add({"time": "11:00", "amount": dosage[1]});
          }
          break;
        case (2):
          if (dosage[2] != 0.0) {
            dosages.add({"time": "17:00", "amount": dosage[2]});
          }
          break;
        case (3):
          if (dosage[3] != 0.0) {
            dosages.add({"time": "19:00", "amount": dosage[3]});
          }
          break;
      }
    }
    return dosages;
  }

  static List<double> formatDosage(List<dynamic> data) {
    List<double> result = [0, 0, 0, 0];
    for (dynamic y in data) {
      switch (y["time"]) {
        case ("07:00"):
          {
            result[0] = 0.0 + y["amount"];
            break;
          }
        case ("11:00"):
          {
            result[1] = 0.0 + y["amount"];
            break;
          }
        case ("17:00"):
          {
            result[2] = 0.0 + y["amount"];
            break;
          }
        case ("19:00"):
          {
            result[3] = 0.0 + y["amount"];
            break;
          }
      }
    }
    return result;
  }

  static String handleMedicineWithoutDosageString(
      BuildContext context, MedicineData medicine) {
    String result = "";
    result += S.of(context).Usage +
        ": " +
        MedicineLogic.getUsage(context, medicine.getUsage());
    if (medicine.getNote() != "") result += " | " + medicine.getNote();
    return result;
  }

  static String getUnit(BuildContext context, int index) {
    switch (index) {
      case 0:
        return S.of(context).pill;
      case 1:
        return "ml";
      case 2:
        return S.of(context).phial;
      case 3:
        return S.of(context).pack;
      default:
        return "";
    }
  }

  static String getUnitNoContext(int index) {
    switch (index) {
      case 0:
        return "viên";
      case 1:
        return "ml";
      case 2:
        return "ống";
      case 3:
        return "gói";
      default:
        return "";
    }
  }

  static String getUsage(BuildContext context, int index) {
    switch (index) {
      case 0:
        return S.of(context).drink;
      case 1:
        return S.of(context).apply;
      case 2:
        return S.of(context).chew;
      case 3:
        return S.of(context).inject;
      case 4:
        return S.of(context).drops;
      default:
        return "";
    }
  }

  static String convertRepeat(int data) {
    String result = data.toString();
    int remain = 8 - result.length;
    for (int i = 0; i < remain; i++) {
      result = "0" + result;
    }
    return result;
  }

  static String getRepeat(BuildContext context, int index) {
    if (index == 0) return "";
    if (index == 1 || index == 11111111) return S.of(context).daily;
    if (index >= 10000000) {
      String result = S.of(context).weekly + " (";
      if ((index ~/ 1000000) % 2 == 1) result += S.of(context).mon + ",";
      if ((index ~/ 100000) % 2 == 1) result += S.of(context).tue + ",";
      if ((index ~/ 10000) % 2 == 1) result += S.of(context).wed + ",";
      if ((index ~/ 1000) % 2 == 1) result += S.of(context).thu + ",";
      if ((index ~/ 100) % 2 == 1) result += S.of(context).fri + ",";
      if ((index ~/ 10) % 2 == 1) result += S.of(context).sat + ",";
      if (index % 2 == 1) result += S.of(context).sun + ",";
      result = result.substring(0, result.length - 1);
      result += ")";
      return result;
    }
    if (index % 7 == 0)
      return S.of(context).custom_repeat_left +
          (index ~/ 7).toString() +
          S.of(context).custom_week_repeat_right;
    return S.of(context).custom_repeat_left +
        index.toString() +
        S.of(context).custom_day_repeat_right;
  }

  static String getDosage(BuildContext context, List<double> list,
      List<DigitalCustomMedicineDosage> customList, int unitID) {
    String unit = MedicineLogic.getUnit(context, unitID);
    String result = "";
    if (list[0] != 0)
      result += S.of(context).morning +
          " " +
          MedicineLogic.handleQuantity(list[0]) +
          " " +
          unit +
          ", ";
    if (list[1] != 0)
      result += S.of(context).noon +
          " " +
          MedicineLogic.handleQuantity(list[1]) +
          " " +
          unit +
          ", ";
    if (list[2] != 0)
      result += S.of(context).afternoon +
          " " +
          MedicineLogic.handleQuantity(list[2]) +
          " " +
          unit +
          ", ";
    if (list[3] != 0)
      result += S.of(context).night +
          " " +
          MedicineLogic.handleQuantity(list[3]) +
          " " +
          unit +
          ", ";
    for (DigitalCustomMedicineDosage x in customList)
      result += (x.time +
          " " +
          MedicineLogic.handleQuantity(x.quantity) +
          " " +
          unit +
          ", ");
    if (result.length > 0) result = result.substring(0, result.length - 2);
    return result;
  }

  // Repeat handle
  static List<String> listRepeat(BuildContext context) {
    return [
      S.of(context).daily,
      S.of(context).Every_few_days,
      S.of(context).Customized_by_week,
      S.of(context).other_repeat
    ];
  }

  static String getRepeatType(BuildContext context, int index) {
    if (index == 1 || index == 11111111) return S.of(context).daily;
    if (index >= 10000000) return S.of(context).Customized_by_week;
    if (index == -2) return S.of(context).other_repeat;
    return S.of(context).Every_few_days;
  }

  static List<List<int>> formatToWeekChoice(int repeat) {
    List<List<int>> result = [];
    if ((repeat ~/ 1000000) % 2 == 1)
      result.add([2, 1]);
    else
      result.add([2, 0]);
    if ((repeat ~/ 100000) % 2 == 1)
      result.add([3, 1]);
    else
      result.add([3, 0]);
    if ((repeat ~/ 10000) % 2 == 1)
      result.add([4, 1]);
    else
      result.add([4, 0]);
    if ((repeat ~/ 1000) % 2 == 1)
      result.add([5, 1]);
    else
      result.add([5, 0]);
    if ((repeat ~/ 100) % 2 == 1)
      result.add([6, 1]);
    else
      result.add([6, 0]);
    if ((repeat ~/ 10) % 2 == 1)
      result.add([7, 1]);
    else
      result.add([7, 0]);
    if (repeat % 2 == 1)
      result.add([8, 1]);
    else
      result.add([8, 0]);
    return result;
  }

  static int formatWeekChoiceToRepeat(List<List<int>> logicList) {
    int result = 10000000;
    for (List<int> x in logicList) result += (x[1] * pow(10, 8 - x[0])).toInt();
    return result;
  }

  static String formatDateToWeekChoice(BuildContext context, int value) {
    switch (value) {
      case 2:
        return S.of(context).mon;
      case 3:
        return S.of(context).tue;
      case 4:
        return S.of(context).wed;
      case 5:
        return S.of(context).thu;
      case 6:
        return S.of(context).fri;
      case 7:
        return S.of(context).sat;
      case 8:
        return S.of(context).sun;
    }
    return "";
  }

  static int updateWeekCustomRepeat(int repeat, int index) {
    List<List<int>> logicList = MedicineLogic.formatToWeekChoice(repeat);
    logicList[index - 2][1] = (logicList[index - 2][1] + 1) % 2;
    return MedicineLogic.formatWeekChoiceToRepeat(logicList);
  }

  // Dosage handle
  static bool isNullDosage(List<double> data) {
    double sum = 0;
    for (double x in data) sum += x;
    if (sum == 0) return true;
    return false;
  }

  // Helper Function
  static String handleQuantity(double quantity) {
    if ((quantity * 10).toInt() % 10 == 0) return quantity.toStringAsFixed(0);
    return quantity.toStringAsFixed(1);
  }
}
