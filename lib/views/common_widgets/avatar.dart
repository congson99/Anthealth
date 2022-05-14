import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key, required this.imagePath, this.size})
      : super(key: key);

  final String imagePath;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size,
        width: size,
        child: (imagePath != "")
            ? CircleAvatar(backgroundImage: NetworkImage(imagePath))
            : CircleAvatar(
                backgroundImage: AssetImage("assets/no_avatar.png")));
  }
}
