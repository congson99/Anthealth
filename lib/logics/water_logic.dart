import 'package:anthealth_mobile/models/health/water_models.dart';

class WaterLogic {
  static List<String> dataPicker() {
    List<String> result = [];
    for (int i = 0; i < 10; i++) result.add(i.toString());
    return result;
  }

  static List<String> subDataPicker() {
    List<String> result = [];
    result.add("000");
    for (int i = 10; i < 100; i += 10) result.add("0" + i.toString());
    for (int i = 100; i < 1000; i += 10) result.add(i.toString());
    return result;
  }

  static List<Water> mergeWaterInHour(List<dynamic> data) {
    List<Water> result = [];
    for (Water x in data) {
      if (result.length != 0 && x.time.hour == result.last.time.hour) {
        Water temp = result.last;
        temp = Water(temp.time, temp.value + x.value);
        result.removeAt(result.length - 1);
        result.add(temp);
      } else {
        result.add(x);
      }
    }
    return result.reversed.toList();
  }
}
