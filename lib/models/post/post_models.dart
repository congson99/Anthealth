class Post {
  Post(this.postKey, this.coverImage, this.title, this.content);

  final String postKey;
  final String coverImage;
  final String title;
  final List<String> content;

  static Post generate(
          {required String postKey,
          String? coverImage,
          required String title,
          required List<String> content}) =>
      Post(postKey, coverImage ?? "", title, content);
}
