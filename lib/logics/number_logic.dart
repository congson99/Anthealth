import 'package:intl/intl.dart';

class NumberLogic {
  static String formatIntMore3(int value) {
    return NumberFormat.decimalPattern().format(value);
  }
}
