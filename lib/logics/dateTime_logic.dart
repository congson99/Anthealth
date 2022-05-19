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

  static bool compareMonthWithNow(DateTime time) {
    if (time.year < DateTime.now().year) return true;
    if (time.year > DateTime.now().year) return false;
    if (time.month < DateTime.now().month) return true;
    return false;
  }

  static String todayFormat(
      BuildContext context, DateTime time, String format) {
    if (time.year == DateTime.now().year &&
        time.month == DateTime.now().month &&
        time.day == DateTime.now().day) return S.of(context).Today;
    if (time.year == DateTime.now().year &&
        time.month == DateTime.now().month &&
        time.day == DateTime.now().day - 1) return S.of(context).Yesterday;
    if (time.year == DateTime.now().year &&
        time.month == DateTime.now().month &&
        time.day == DateTime.now().day + 1) return S.of(context).Tomorrow;
    return DateFormat(format).format(time);
  }

  static DateTime increaseDay(DateTime time) {
    return DateTime(time.year, time.month, time.day + 1);
  }

  static DateTime increaseMonth(DateTime time) {
    return DateTime(time.year, time.month + 1);
  }

  static DateTime increaseYear(DateTime time) {
    return DateTime(time.year + 1);
  }

  static DateTime decreaseDay(DateTime time) {
    return DateTime(time.year, time.month, time.day - 1);
  }

  static DateTime decreaseMonth(DateTime time) {
    return DateTime(time.year, time.month - 1);
  }

  static DateTime decreaseYear(DateTime time) {
    return DateTime(time.year - 1);
  }

  static String formatPastDateTime(BuildContext context, DateTime time) {
    DateTime now = DateTime.now();
    if (now.difference(time).inMinutes < 0) return "";
    if (DateTimeLogic.daysBetween(time, now) > 0 &&
        DateTimeLogic.daysBetween(time, now) < 8) {
      int day = now.day - time.day;
      if (day == 1)
        return S.of(context).Yesterday;
      else
        return day.toString() + S.of(context).days_ago;
    }
    if (time.year < now.year) return DateFormat("dd.MM.yyyy").format(time);
    if (time.day < now.day) return DateFormat("dd.MM").format(time);
    if (time.hour < now.hour) {
      int hour = now.hour - time.hour;
      if (hour == 1)
        return "1" + S.of(context).hour_ago;
      else
        return hour.toString() + S.of(context).hours_ago;
    }
    int minute = now.minute - time.minute;
    if (minute <= 1) return "1" + S.of(context).minute_ago;
    return minute.toString() + S.of(context).minutes_ago;
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return to.difference(from).inDays;
  }
}
