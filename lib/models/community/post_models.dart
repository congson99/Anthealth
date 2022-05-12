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
  final String content;
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
  Attach(this.ownerID, this.type, this.dataID);

  final String ownerID;
  final int type;
  final int dataID;
}
