import 'dart:io';

import 'package:flutter/material.dart';

class UpdateLanguagePage extends StatelessWidget {
  const UpdateLanguagePage({Key? key, required this.languageID})
      : super(key: key);

  final String languageID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(getLoadingContent(languageID),
                style: Theme.of(context).textTheme.headline5)));
  }

  String getLoadingContent(String languageID) {
    String language =
        (languageID == "") ? Platform.localeName.substring(0, 2) : languageID;
    switch (language) {
      case "vi":
        return "Đang cập nhật ngôn ngữ...";
      default:
        return "Updating language...";
    }
  }
}
