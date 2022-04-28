class FamilyMemberLabelData {
  FamilyMemberLabelData(this.id, this.name, this.avatarPath);

  final String id;
  final String name;
  final String avatarPath;
}

class FamilyMemberData {
  FamilyMemberData(this.id, this.name, this.avatarPath, this.phoneNumber,
      this.email, this.permission);

  final String id;
  final String name;
  final String avatarPath;
  final String phoneNumber;
  final String email;
  final List<int> permission;
}
