class HealthPageData {
  HealthPageData(this._name, this._indicatorsLatestData);

  String _name;
  List<double> _indicatorsLatestData;

  String getName() => _name;

  List<double> getIndicatorsLatestData() => _indicatorsLatestData;

  static List<double> formatIndicatorsList(List<dynamic> data) {
    List<double> result = [0, 0, 0, 0, 0, 0];
    for (dynamic i in data)
      result[i["type"]] = (i["value"] == 0) ? 0 : i["value"];
    return result;
  }
}
