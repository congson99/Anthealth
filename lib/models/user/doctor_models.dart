class Doctor {
  Doctor(this.id, this.name, this.avatarPath, this.phoneNumber, this.email,
      this.highlight, this.description);

  final String id;
  final String name;
  final String avatarPath;
  final String phoneNumber;
  final String email;
  final String highlight;
  final String description;
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

  final String id;
  final String doctorId;
  final String patientId;
  final String doctorName;
  final String patientName;
  final String doctorImagePath;
  final String patientImagePath;
  final String content;
  final DateTime time;
  final String note;
}
