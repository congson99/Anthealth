class DashboardLogic {
  static List<String> handleIndicatorToShow(List<double> data) {
    List<String> result = [];
    for (int i = 0; i < 6; i++) {
      if (data[i] == 0) {
        result.add("_");
        continue;
      }
      if (i == 0) result.add(data[i].toStringAsFixed(2));
      if (i == 1 || i == 3) result.add(data[i].toStringAsFixed(1));
      if (i == 2 || i == 5) result.add(data[i].toStringAsFixed(0));
      if (i == 4)
        result.add((data[i] ~/ 1).toString() +
            '/' +
            ((data[i] * 1000) % 1000).toStringAsFixed(0));
    }
    return result;
  }

}