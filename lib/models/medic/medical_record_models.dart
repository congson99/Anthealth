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
  DigitalMedicine(
      this._id,
      this._name,
      this._quantity,
      this._unit,
      this._usage,
      this._dosage,
      this._customDosage,
      this._repeat,
      this._imagePath,
      this._url,
      [this._note]);

  final String _id;
  final String _name;
  final double _quantity;
  final int _unit;
  final int _usage;
  final List<double> _dosage;
  final List<DigitalCustomMedicineDosage> _customDosage;
  final int _repeat;
  final String? _note;
  final String _imagePath;
  final String _url;

  String getId() => _id;

  String getName() => _name;

  double getQuantity() => _quantity;

  int getUnit() => _unit;

  int getUsage() => _usage;

  List<double> getDosage() => _dosage;

  List<DigitalCustomMedicineDosage> getCustomDosage() => _customDosage;

  int getRepeat() => _repeat;

  String? getNote() => _note;

  String getImagePath() => _imagePath;

  String getURL() => _url;

  static DigitalMedicine updateQuantity(DigitalMedicine data, double quantity) {
    return DigitalMedicine(
        data.getId(),
        data.getName(),
        quantity,
        data.getUnit(),
        data.getUsage(),
        data.getDosage(),
        data.getCustomDosage(),
        data.getRepeat(),
        data.getImagePath(),
        data.getURL());
  }

  static DigitalMedicine updateDosage(
      DigitalMedicine data, List<double> dosage) {
    return DigitalMedicine(
        data.getId(),
        data.getName(),
        data.getQuantity(),
        data.getUnit(),
        data.getUsage(),
        dosage,
        data.getCustomDosage(),
        data.getRepeat(),
        data.getImagePath(),
        data.getURL());
  }

  static DigitalMedicine updateRepeat(DigitalMedicine data, int value) {
    return DigitalMedicine(
        data.getId(),
        data.getName(),
        data.getQuantity(),
        data.getUnit(),
        data.getUsage(),
        data.getDosage(),
        data.getCustomDosage(),
        value,
        data.getImagePath(),
        data.getURL());
  }

  static DigitalMedicine updateNote(DigitalMedicine data, String value) {
    return DigitalMedicine(
        data.getId(),
        data.getName(),
        data.getQuantity(),
        data.getUnit(),
        data.getUsage(),
        data.getDosage(),
        data.getCustomDosage(),
        data.getRepeat(),
        data.getImagePath(),
        data.getURL(),
        value);
  }
}

class DigitalCustomMedicineDosage {
  DigitalCustomMedicineDosage(this._time, this._quantity);

  final String _time;
  final double _quantity;

  String getTime() => _time;

  double getQuantity() => _quantity;
}
