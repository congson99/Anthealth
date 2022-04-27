import 'package:intl/intl.dart';

class NumberLogic {
  static String formatIntMore3(int value) {
    return NumberFormat.decimalPattern().format(value);
  }

  static String handleDoubleFix0(double value) {
    if ((value * 10).toInt() % 10 == 0) return value.toStringAsFixed(0);
    return value.toStringAsFixed(1);
  }
}
