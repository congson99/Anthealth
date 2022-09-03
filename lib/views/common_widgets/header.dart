import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SizedBox(height: 12),
      Text(title,
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: AnthealthColors.black1)),
      SizedBox(height: 4),
      Text(content,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: AnthealthColors.primary0)),
      SizedBox(height: 12),
    ]);
  }
}
