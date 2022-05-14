class Post {
  Post(this.id, this.owner, this.like, this.comment, this.isLike, this.content,
      this.attach, this.image,
      [this.source]);

  final String id;
  final PostAuthor owner;
  final PostAuthor? source;
  final List<String> like;
  final List<PostComment> comment;
  bool isLike;
  String content;
  final List<Attach> attach;
  final String image;
}

class PostAuthor {
  PostAuthor(this.id, this.name, this.avatarPath, this.postTime);

  final String id;
  final String name;
  final String avatarPath;
  final DateTime postTime;
}

class PostComment {
  PostComment(this.name, this.content);

  final String name;
  final String content;
}

class Attach {
  Attach(this.ownerID, this.ownerName, this.ownerAvatar, this.type, this.dataID,
      this.dataDescription);

  final String ownerID;
  final String ownerName;
  final String ownerAvatar;
  final int type;
  final String dataID;
  final String dataDescription;
}

/// -1: open Medical Records
///  1: height
///  2: weight
///  3: heart rate
///  4: temperature
///  5: blood pressure
///  6: spo2
///  7: calo
///  8: water
///  9: steps
///  10: Medical record
///  11: family member
