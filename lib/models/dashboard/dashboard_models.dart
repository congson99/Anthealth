class HealthPageData {
  HealthPageData(this._indicatorsLatestData);

  List<double> _indicatorsLatestData;

  List<double> getIndicatorsLatestData() => _indicatorsLatestData;

  static List<double> formatIndicatorsList(List<dynamic> data) {
    List<double> result = [0, 0, 0, 0, 0, 0, 0];
    for (dynamic i in data)
      result[i["type"]] = (i["value"] == 0) ? 0 : i["value"];
    // Todo: get second blood pressure value
    return result;
  }
}

class MedicPageData {
  MedicPageData(
      this._latestRecord, this._latestAppointment, this._listMedicineBox);

  String _latestRecord;
  String _latestAppointment;
  List<String> _listMedicineBox;

  String getLatestRecord() => _latestRecord;

  String getLatestAppointment() => _latestAppointment;

  List<String> getListMedicineBox() => _listMedicineBox;
}
