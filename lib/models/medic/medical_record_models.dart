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
