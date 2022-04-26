import 'package:anthealth_mobile/models/health/steps_models.dart';

class StepsLogic {
  static int distanceCalculator(int steps) {
    return (steps * 0.8).toInt();
  }

  static int caloCalculator(int steps) {
    return (steps * 0.14).toInt();
  }

  static List<String> dataPicker() {
    List<String> result = [];
    for (int i = 0; i < 100; i++) result.add(i.toString());
    return result;
  }

  static List<String> subDataPicker() {
    List<String> result = [];
    result.add("000");
    for (int i = 10; i < 100; i += 10) result.add("0" + i.toString());
    for (int i = 100; i < 1000; i += 10) result.add(i.toString());
    return result;
  }

  static List<Steps> mergeStepsInHour(List<Steps> data) {
    List<Steps> result = [];
    for (Steps x in data) {
      if (result.length != 0 && x.time.hour == result.last.time.hour) {
        Steps temp = result.last;
        temp = Steps(temp.time, temp.value + x.value);
        result.removeAt(result.length - 1);
        result.add(temp);
      } else {
        result.add(x);
      }
    }
    return result.reversed.toList();
  }
}
