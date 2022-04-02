class MedicalRecordPageData {
  MedicalRecordPageData(this._listYearLabel, this._listAppointment);

  final List<MedicalRecordYearLabel> _listYearLabel;
  final List<MedicalAppointment> _listAppointment;

  List<MedicalRecordYearLabel> getListYearLabel() => _listYearLabel;

  List<MedicalAppointment> getListAppointment() => _listAppointment;

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
  final int _quantity;
  final List<MedicalRecordLabel> _data;
  bool _openingState;

  DateTime getDateTime() => _dateTime;

  int getQuantity() => _quantity;

  List<MedicalRecordLabel> getData() => _data;

  bool getOpeningState() => _openingState;
}

class MedicalRecordLabel {
  MedicalRecordLabel(this._dateTime, this._location, this._name);

  final DateTime _dateTime;
  final String _location;
  final String _name;

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
}

class MedicalRecordDetailData {
  MedicalRecordDetailData(
      this._label,
      this._detailPhoto,
      this._testPhoto,
      this._diagnosePhoto,
      this._prescriptionPhoto,
      this._prescription,
      this._appointment);

  final MedicalRecordLabel _label;
  final List<String> _detailPhoto;
  final List<String> _testPhoto;
  final List<String> _diagnosePhoto;
  final List<String> _prescriptionPhoto;
  final List<DigitalMedicine> _prescription;
  final MedicalAppointment _appointment;

  MedicalRecordLabel getLabel() => _label;

  List<String> getDetailPhoto() => _detailPhoto;

  List<String> getTestPhoto() => _testPhoto;

  List<String> getDiagnosePhoto() => _diagnosePhoto;

  List<String> getPrescriptionPhoto() => _prescriptionPhoto;

  List<DigitalMedicine> getPrescription() => _prescription;

  MedicalAppointment getAppointment() => _appointment;
}

class DigitalMedicine {
  DigitalMedicine(this._id, this._name, this._quantity, this._unit, this._usage,
      this._dosage, this._repeat, this._note);

  final int _id;
  final String _name;
  final int _quantity;
  final int _unit;
  final int _usage;
  final List<DigitalMedicineDosage> _dosage;
  final int _repeat;
  final String _note;

  int getId() => _id;

  String getName() => _name;

  int getQuantity() => _quantity;

  int getUnit() => _unit;

  int getUsage() => _usage;

  List<DigitalMedicineDosage> getDosage() => _dosage;

  int getRepeat() => _repeat;

  String getNote() => _note;
}

class DigitalMedicineDosage {
  DigitalMedicineDosage(this._index, this._detail, this._dose);

  final int _index;
  final String _detail;
  final int _dose;

  int getIndex() => _index;

  String getDetail() => _detail;

  int getDose() => _dose;
}
