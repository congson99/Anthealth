import 'package:intl/intl.dart';

class HealthPageData {
  HealthPageData(this.indicatorsLatestData);

  List<double> indicatorsLatestData;

  static List<double> formatIndicatorsList(List<dynamic> data) {
    List<double> result = [0, 0, 0, 0, 0, 0];
    for (dynamic i in data)
      result[i["type"]] = 0.0 + ((i["value"] == 0) ? 0 : i["value"]);
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

    list.add("value");

    return MedicPageData(latest, upcoming, list);
  }
}
