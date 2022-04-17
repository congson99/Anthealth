import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DateTimeLogic {
  static String formatMonthYear(BuildContext context, DateTime time) {
    String result = '';
    switch (time.month) {
      case 1:
        result = S.of(context).January;
        break;
      case 2:
        result = S.of(context).February;
        break;
      case 3:
        result = S.of(context).March;
        break;
      case 4:
        result = S.of(context).April;
        break;
      case 5:
        result = S.of(context).May;
        break;
      case 6:
        result = S.of(context).June;
        break;
      case 7:
        result = S.of(context).July;
        break;
      case 8:
        result = S.of(context).August;
        break;
      case 9:
        result = S.of(context).September;
        break;
      case 10:
        result = S.of(context).October;
        break;
      case 11:
        result = S.of(context).November;
        break;
      case 12:
        result = S.of(context).December;
        break;
    }
    return result + ' ' + time.year.toString();
  }

  static String formatMonth(BuildContext context, DateTime time) {
    String result = '';
    switch (time.month) {
      case 1:
        result = S.of(context).January;
        break;
      case 2:
        result = S.of(context).February;
        break;
      case 3:
        result = S.of(context).March;
        break;
      case 4:
        result = S.of(context).April;
        break;
      case 5:
        result = S.of(context).May;
        break;
      case 6:
        result = S.of(context).June;
        break;
      case 7:
        result = S.of(context).July;
        break;
      case 8:
        result = S.of(context).August;
        break;
      case 9:
        result = S.of(context).September;
        break;
      case 10:
        result = S.of(context).October;
        break;
      case 11:
        result = S.of(context).November;
        break;
      case 12:
        result = S.of(context).December;
        break;
    }
    return result;
  }

  static String formatHourToHour(DateTime time) {
    DateTime lastHour = DateTime(0, 0, 0, time.hour + 1);
    return DateFormat("HH").format(time) +
        ":00 - " +
        DateFormat("HH:mm").format(lastHour);
  }

  static bool compareHourWithNow(DateTime time) {
    if (time.year < DateTime.now().year) return true;
    if (time.year > DateTime.now().year) return false;
    if (time.month < DateTime.now().month) return true;
    if (time.month > DateTime.now().month) return false;
    if (time.day < DateTime.now().day) return true;
    if (time.day > DateTime.now().day) return false;
    if (time.hour < DateTime.now().hour) return true;
    return false;
  }

  static bool compareDayWithNow(DateTime time) {
    if (time.year < DateTime.now().year) return true;
    if (time.year > DateTime.now().year) return false;
    if (time.month < DateTime.now().month) return true;
    if (time.month > DateTime.now().month) return false;
    if (time.day < DateTime.now().day) return true;
    return false;
  }
}
