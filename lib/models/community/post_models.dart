class Post {
  Post(this.owner, this.like, this.comment, this.content, [this.source]);

  final PostAuthor owner;
  final PostAuthor? source;
  final List<String> like;
  final List<PostComment> comment;
  final String content;
}

class PostAuthor {
  PostAuthor(this.id, this.name, this.avatarPath, this.postTime);

  final String id;
  final String name;
  final String avatarPath;
  final DateTime postTime;
}

class PostComment {
  PostComment(this.owner, this.content);

  final PostAuthor owner;
  final String content;
}
