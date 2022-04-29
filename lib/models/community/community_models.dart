class CommunityGroup {
  CommunityGroup(this.groupName, this.listCommunity, this.isOpening);

  final String groupName;
  final List<CommunityData> listCommunity;
  bool isOpening;
}

class CommunityData {
  CommunityData(this.id, this.name, this.description, this.avatarPath,
      this.members, this.join, this.posts);

  final String id;
  final String name;
  final String description;
  final String avatarPath;
  final int members;
  final bool join;
  final List<String> posts;
}
