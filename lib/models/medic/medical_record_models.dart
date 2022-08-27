class MedicalRecordPageData {
  MedicalRecordPageData(this.listYearLabel, this.listAppointment);

  final List<MedicalRecordYearLabel> listYearLabel;
  final List<MedicalAppointment> listAppointment;

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
        if (temp.dateTime.year == year)
          yearLabel.last.addMedicalRecordLabel(temp);
        else {
          yearLabel
              .add(MedicalRecordYearLabel(temp.dateTime, 1, [temp], false));
          year = temp.dateTime.year;
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
}

class MedicalRecordYearLabel {
  MedicalRecordYearLabel(
      this.dateTime, this.quantity, this.data, this.openingState);

  final DateTime dateTime;
  int quantity;
  final List<MedicalRecordLabel> data;
  bool openingState;

  void addMedicalRecordLabel(MedicalRecordLabel medicalRecordLabel) {
    data.add(medicalRecordLabel);
    quantity++;
  }
}

class MedicalRecordLabel {
  MedicalRecordLabel(this.id, this.dateTime, this.location, this.name);

  String id;
  DateTime dateTime;
  String location;
  String name;
}

class MedicalAppointment {
  MedicalAppointment(this.dateTime, this.location, this.lastTime, this.name);

  DateTime dateTime;
  String location;
  DateTime lastTime;
  String name;

  static formatData(dynamic data, DateTime lastTime) {
    if (data == null || data == false || data["time"] == null)
      return MedicalAppointment(DateTime.now(), "", DateTime.now(), "");
    return MedicalAppointment(
        DateTime.fromMillisecondsSinceEpoch(data["time"] * 1000),
        data["place"],
        lastTime,
        data["content"]);
  }
}

class MedicalRecordDetailData {
  MedicalRecordDetailData(
      this.label,
      this.detailPhoto,
      this.testPhoto,
      this.diagnosePhoto,
      this.prescriptionPhoto,
      this.prescription,
      this.appointment);

  MedicalRecordLabel label;
  List<String> detailPhoto;
  List<String> testPhoto;
  List<String> diagnosePhoto;
  List<String> prescriptionPhoto;
  List<DigitalMedicine> prescription;
  MedicalAppointment appointment;

  static MedicalRecordDetailData formatData(dynamic data) {
    final List<String> detailPhoto = [];
    final List<String> testPhoto = [];
    final List<String> diagnosePhoto = [];
    final List<String> prescriptionPhoto = [];
    print(data.toString());
    if (data["detailsImage"].length != 0)
      for (dynamic x in data["detailsImage"]) detailPhoto.add(x.toString());
    if (data["diagnoseImage"].length != 0)
      for (dynamic x in data["diagnoseImage"]) detailPhoto.add(x.toString());
    if (data["medicineImage"].length != 0)
      for (dynamic x in data["medicineImage"]) detailPhoto.add(x.toString());
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
}

class MedicineData {
  MedicineData(this._id, this._name, this._quantity, this._unit, this._usage,
      this._imagePath, this._url, this._note);

  final String _id;
  final String _name;
  final double _quantity;
  final int _unit;
  final int _usage;
  final String _note;
  final String _imagePath;
  final String _url;

  String getId() => _id;

  String getName() => _name;

  double getQuantity() => _quantity;

  int getUnit() => _unit;

  int getUsage() => _usage;

  String getNote() => _note;

  String getImagePath() => _imagePath;

  String getURL() => _url;

  static MedicineData updateQuantity(MedicineData data, double quantity) {
    return MedicineData(data.getId(), data.getName(), quantity, data.getUnit(),
        data.getUsage(), data.getImagePath(), data.getURL(), data.getNote());
  }

  static MedicineData updateNote(MedicineData data, String value) {
    return MedicineData(
        data.getId(),
        data.getName(),
        data.getQuantity(),
        data.getUnit(),
        data.getUsage(),
        data.getImagePath(),
        data.getURL(),
        value);
  }

  static MedicineData formatFromDigitalMedicine(DigitalMedicine data) {
    return MedicineData(data.id, data.name, data.quantity, data.unit,
        data.usage, data.imagePath, data.url, data.note);
  }
}

class DigitalMedicine {
  DigitalMedicine(
      this.id,
      this.name,
      this.quantity,
      this.unit,
      this.usage,
      this.dosage,
      this.customDosage,
      this.repeat,
      this.imagePath,
      this.url,
      this.note);

  String id;
  String name;
  double quantity;
  int unit;
  int usage;
  List<double> dosage;
  List<DigitalCustomMedicineDosage> customDosage;
  int repeat;
  String note;
  String imagePath;
  String url;
}

class DigitalCustomMedicineDosage {
  DigitalCustomMedicineDosage(this.time, this.quantity, this.isUse);

  String time;
  double quantity;
  bool isUse;
}
