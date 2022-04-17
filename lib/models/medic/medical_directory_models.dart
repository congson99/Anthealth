import 'package:anthealth_mobile/models/common/gps_models.dart';

class MedicalDirectoryData {
  MedicalDirectoryData(this._name, this._location, this._phoneNumber,
      this._workTime, this._note, this._gps);

  final String _name;
  final String _location;
  final String _phoneNumber;
  final String _workTime;
  final String _note;
  final GPS _gps;

  String getName() => _name;

  String getLocation() => _location;

  String getPhoneNumber() => _phoneNumber;

  String getWorkTime() => _workTime;

  String getNote() => _note;

  GPS getGPS() => _gps;
}
