import 'package:intl/intl.dart';

class HealthPageData {
  HealthPageData(this._indicatorsLatestData);

  List<double> _indicatorsLatestData;

  List<double> getIndicatorsLatestData() => _indicatorsLatestData;

  static List<double> formatIndicatorsList(List<dynamic> data) {
    List<double> result = [0, 0, 0, 0, 0, 0];
    for (dynamic i in data)
      result[i["type"]] = 0.0 + ((i["value"] == 0) ? 0 : i["value"]);
    return result;
  }

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

class MedicPageData {
  MedicPageData(
      this._latestRecord, this._latestAppointment, this._listMedicineBox);

  String _latestRecord;
  String _latestAppointment;
  List<String> _listMedicineBox;

  String getLatestRecord() => _latestRecord;

  String getLatestAppointment() => _latestAppointment;

  List<String> getListMedicineBox() => _listMedicineBox;

  static MedicPageData formatData(dynamic latestMedicalRecord,
      dynamic upcomingAppointment, dynamic medicineBoxes) {
    String latest = "";
    String upcoming = "";
    List<String> list = [];

    if (latestMedicalRecord != "") {
      DateTime tempTime = DateTime.fromMillisecondsSinceEpoch(
          latestMedicalRecord["time"] * 1000);
      latest = DateFormat("dd.MM.yyyy").format(tempTime) +
          " - " +
          latestMedicalRecord["place"].toString();
    }

    if (upcomingAppointment != "") {
      DateTime tempTime = DateTime.fromMillisecondsSinceEpoch(
          upcomingAppointment["time"] * 1000);
      upcoming = DateFormat("dd.MM.yyyy").format(tempTime) +
          " - " +
          upcomingAppointment["place"].toString();
    }

    return MedicPageData(latest, upcoming, list);
  }
}
