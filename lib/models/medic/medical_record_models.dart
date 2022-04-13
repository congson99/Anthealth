import 'package:anthealth_mobile/blocs/common_logic/server_logic.dart';

class MedicalRecordPageData {
  MedicalRecordPageData(this._listYearLabel, this._listAppointment);

  final List<MedicalRecordYearLabel> _listYearLabel;
  final List<MedicalAppointment> _listAppointment;

  List<MedicalRecordYearLabel> getListYearLabel() => _listYearLabel;

  List<MedicalAppointment> getListAppointment() => _listAppointment;

  static MedicalRecordPageData formatData(
      dynamic listRecord, dynamic listAppointment) {
    List<MedicalRecordYearLabel> yearLabel = [];
    List<MedicalAppointment> appointment = [];
    if (listRecord != "") {
      int year = 0;
      for (dynamic i in listRecord) {
        MedicalRecordLabel temp = MedicalRecordLabel(
            i["id"],
            DateTime.fromMillisecondsSinceEpoch(i["time"] * 1000),
            i["place"],
            i["name"]);
        if (temp.getDateTime().year == year)
          yearLabel.last.addMedicalRecordLabel(temp);
        else {
          yearLabel.add(
              MedicalRecordYearLabel(temp.getDateTime(), 1, [temp], false));
          year = temp.getDateTime().year;
        }
      }
    }
    if (listAppointment != "") {
      for (dynamic i in listAppointment) {
        appointment.add(MedicalAppointment(
            DateTime.fromMillisecondsSinceEpoch(i["time"] * 1000),
            i["place"],
            DateTime.fromMillisecondsSinceEpoch(i["time"] * 1000),
            i["content"]));
      }
    }
    return MedicalRecordPageData(yearLabel, appointment);
  }

  static MedicalRecordPageData changeOpeningState(
      int index, MedicalRecordPageData data) {
    List<MedicalRecordYearLabel> temp = [];
    for (MedicalRecordYearLabel i in data.getListYearLabel()) {
      if (data.getListYearLabel().indexOf(i) != index)
        temp.add(i);
      else
        temp.add(MedicalRecordYearLabel(i.getDateTime(), i.getQuantity(),
            i.getData(), !i.getOpeningState()));
    }
    return MedicalRecordPageData(temp, data.getListAppointment());
  }
}

class MedicalRecordYearLabel {
  MedicalRecordYearLabel(
      this._dateTime, this._quantity, this._data, this._openingState);

  final DateTime _dateTime;
  int _quantity;
  final List<MedicalRecordLabel> _data;
  bool _openingState;

  DateTime getDateTime() => _dateTime;

  int getQuantity() => _quantity;

  List<MedicalRecordLabel> getData() => _data;

  bool getOpeningState() => _openingState;

  void addMedicalRecordLabel(MedicalRecordLabel medicalRecordLabel) {
    _data.add(medicalRecordLabel);
    _quantity++;
  }
}

class MedicalRecordLabel {
  MedicalRecordLabel(this._id, this._dateTime, this._location, this._name);

  final String _id;
  final DateTime _dateTime;
  final String _location;
  final String _name;

  String getID() => _id;

  DateTime getDateTime() => _dateTime;

  String getLocation() => _location;

  String getName() => _name;
}

class MedicalAppointment {
  MedicalAppointment(
      this._dateTime, this._location, this._lastTime, this._name);

  final DateTime _dateTime;
  final String _location;
  final DateTime _lastTime;
  final String _name;

  DateTime getDateTime() => _dateTime;

  String getLocation() => _location;

  DateTime getLastTime() => _lastTime;

  String getName() => _name;

  static formatData(dynamic data, DateTime lastTime) {
    if (data == null)
      return MedicalAppointment(DateTime.now(), "", DateTime.now(), "");
    return MedicalAppointment(
        DateTime.fromMillisecondsSinceEpoch(data["time"] * 1000),
        data["place"],
        lastTime,
        data["content"]);
  }
}

class MedicalRecordDetailData {
  MedicalRecordDetailData(this._label, this._detailPhoto, this._testPhoto,
      this._diagnosePhoto, this._prescriptionPhoto, this._prescription,
      [this._appointment]);

  final MedicalRecordLabel _label;
  final List<String> _detailPhoto;
  final List<String> _testPhoto;
  final List<String> _diagnosePhoto;
  final List<String> _prescriptionPhoto;
  final List<DigitalMedicine> _prescription;
  final MedicalAppointment? _appointment;

  MedicalRecordLabel getLabel() => _label;

  List<String> getDetailPhoto() => _detailPhoto;

  List<String> getTestPhoto() => _testPhoto;

  List<String> getDiagnosePhoto() => _diagnosePhoto;

  List<String> getPrescriptionPhoto() => _prescriptionPhoto;

  List<DigitalMedicine> getPrescription() => _prescription;

  MedicalAppointment? getAppointment() => _appointment;

  static MedicalRecordDetailData formatData(dynamic data) {
    final List<String> detailPhoto = [];
    final List<String> testPhoto = [];
    final List<String> diagnosePhoto = [];
    final List<String> prescriptionPhoto = [];
    if (data["detailsImage"].length != 0)
      detailPhoto.addAll(data["detailsImage"]);
    if (data["diagnoseImage"].length != 0)
      diagnosePhoto.addAll(data["diagnoseImage"]);
    if (data["medicineImage"].length != 0)
      prescriptionPhoto.addAll(data["medicineImage"]);
    return MedicalRecordDetailData(
        MedicalRecordLabel(
            data["rid"],
            DateTime.fromMillisecondsSinceEpoch(data["time"] * 1000),
            data["place"],
            data["name"]),
        detailPhoto,
        testPhoto,
        diagnosePhoto,
        prescriptionPhoto,
        [],
        MedicalAppointment.formatData(data["appointment"],
            DateTime.fromMillisecondsSinceEpoch(data["time"] * 1000)));
  }

  static MedicalRecordDetailData updateData(
      MedicalRecordDetailData data, String changeName, dynamic changeValue) {
    if (changeName == "name")
      return MedicalRecordDetailData(
          MedicalRecordLabel(
              data.getLabel().getID(),
              data.getLabel().getDateTime(),
              data.getLabel().getLocation(),
              changeValue as String),
          data.getDetailPhoto(),
          data.getTestPhoto(),
          data.getDiagnosePhoto(),
          data.getPrescriptionPhoto(),
          data.getPrescription(),
          data.getAppointment());
    if (changeName == "location")
      return MedicalRecordDetailData(
          MedicalRecordLabel(
              data.getLabel().getID(),
              data.getLabel().getDateTime(),
              changeValue as String,
              data.getLabel().getName()),
          data.getDetailPhoto(),
          data.getTestPhoto(),
          data.getDiagnosePhoto(),
          data.getPrescriptionPhoto(),
          data.getPrescription(),
          MedicalAppointment(data.getAppointment()!.getDateTime(), changeValue,
              data.getLabel().getDateTime(), data.getAppointment()!.getName()));
    if (changeName == "time")
      return MedicalRecordDetailData(
          MedicalRecordLabel(data.getLabel().getID(), changeValue as DateTime,
              data.getLabel().getLocation(), data.getLabel().getName()),
          data.getDetailPhoto(),
          data.getTestPhoto(),
          data.getDiagnosePhoto(),
          data.getPrescriptionPhoto(),
          data.getPrescription(),
          data.getAppointment());
    if (changeName == "appointment_content")
      return MedicalRecordDetailData(
          data.getLabel(),
          data.getDetailPhoto(),
          data.getTestPhoto(),
          data.getDiagnosePhoto(),
          data.getPrescriptionPhoto(),
          data.getPrescription(),
          MedicalAppointment(
              data.getAppointment()!.getDateTime(),
              data.getAppointment()!.getLocation(),
              data.getLabel().getDateTime(),
              changeValue));
    if (changeName == "appointment_location")
      return MedicalRecordDetailData(
          data.getLabel(),
          data.getDetailPhoto(),
          data.getTestPhoto(),
          data.getDiagnosePhoto(),
          data.getPrescriptionPhoto(),
          data.getPrescription(),
          MedicalAppointment(data.getAppointment()!.getDateTime(), changeValue,
              data.getLabel().getDateTime(), data.getAppointment()!.getName()));
    if (changeName == "appointment_time")
      return MedicalRecordDetailData(
          data.getLabel(),
          data.getDetailPhoto(),
          data.getTestPhoto(),
          data.getDiagnosePhoto(),
          data.getPrescriptionPhoto(),
          data.getPrescription(),
          MedicalAppointment(
              changeValue as DateTime,
              data.getAppointment()!.getLocation(),
              data.getLabel().getDateTime(),
              data.getAppointment()!.getName()));
    return data;
  }
}

class DigitalMedicine {
  DigitalMedicine(this._id, this._name, this._quantity, this._unit, this._usage,
      this._dosage, this._customDosage, this._repeat,
      [this._note]);

  final String _id;
  final String _name;
  final int _quantity;
  final int _unit;
  final int _usage;
  final List<DigitalMedicineDosage> _dosage;
  final List<DigitalCustomMedicineDosage> _customDosage;
  final int _repeat;
  final String? _note;

  String getId() => _id;

  String getName() => _name;

  int getQuantity() => _quantity;

  int getUnit() => _unit;

  int getUsage() => _usage;

  List<DigitalMedicineDosage> getDosage() => _dosage;

  List<DigitalCustomMedicineDosage> getCustomDosage() => _customDosage;

  int getRepeat() => _repeat;

  String? getNote() => _note;
}

class DigitalMedicineDosage {
  DigitalMedicineDosage(this._time, this._quantity);

  final int _time;
  final int _quantity;

  int getTime() => _time;

  int getQuantity() => _quantity;
}

class DigitalCustomMedicineDosage {
  DigitalCustomMedicineDosage(this._time, this._quantity);

  final String _time;
  final int _quantity;

  String getTime() => _time;

  int getQuantity() => _quantity;
}
