class DoctorGroup {
  DoctorGroup(this.name, this.doctors, this.isOpening);

  String name;
  List<Doctor> doctors;
  bool isOpening;
}

class Doctor {
  Doctor(this.id, this.name, this.avatarPath, this.phoneNumber, this.email,
      this.highlight, this.description, this.favorite);

  String id;
  String name;
  String avatarPath;
  String phoneNumber;
  String email;
  String highlight;
  String description;
  bool favorite;
}

class DoctorAppointment {
  DoctorAppointment(
      this.id,
      this.doctorId,
      this.patientId,
      this.doctorName,
      this.patientName,
      this.doctorImagePath,
      this.patientImagePath,
      this.content,
      this.time,
      this.note);

  String id;
  String doctorId;
  String patientId;
  String doctorName;
  String patientName;
  String doctorImagePath;
  String patientImagePath;
  String content;
  DateTime time;
  String note;
}
