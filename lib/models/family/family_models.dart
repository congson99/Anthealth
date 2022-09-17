class FamilyMemberData {
  FamilyMemberData(this.id, this.name, this.avatarPath, this.phoneNumber,
      this.email, this.admin, this.permission, this.yob);

  final String id;
  final String name;
  final String avatarPath;
  final String phoneNumber;
  final String email;
  bool admin;
  List<bool> permission;
  final int yob;
}

class Invitation {
  Invitation(this.familyID, this.inviter);

  final String familyID;
  final String inviter;
}
