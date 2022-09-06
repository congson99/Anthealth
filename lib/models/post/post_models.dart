import 'dart:convert';

import 'package:flutter/services.dart';

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

  static Future<Post> fromJson(String jsonFile) async {
    var jsonText = await rootBundle.loadString(jsonFile);
    Map<String, dynamic> data = json.decode(jsonText);
    List<String> content = [];
    for (dynamic x in data["content"]) content.add(x.toString());
    Post result = Post.generate(
        postKey: data["postKey"] ?? "",
        coverImage: data["coverImage"],
        title: data["title"] ?? "",
        content: content);
    return result;
  }
}
