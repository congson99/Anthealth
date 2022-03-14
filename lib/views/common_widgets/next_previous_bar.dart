import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NextPreviousBar extends StatelessWidget {
  const NextPreviousBar({
    Key? key,
    required this.content,
    required this.increse,
    required this.decrese,
  }) : super(key: key);

  final String content;
  final VoidCallback increse;
  final VoidCallback decrese;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      GestureDetector(
          onTap: decrese,
          child: Image.asset("assets/app_icon/direction/left_bla2.png",
              height: 12.0, width: 12.0, fit: BoxFit.cover)),
      SizedBox(width: 8),
      Text(content,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: AnthealthColors.black0)),
      SizedBox(width: 8),
      GestureDetector(
          onTap: increse,
          child: Image.asset("assets/app_icon/direction/right_bla2.png",
              height: 12.0, width: 12.0, fit: BoxFit.cover))
    ]);
  }
}
