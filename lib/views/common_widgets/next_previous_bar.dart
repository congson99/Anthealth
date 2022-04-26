import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class NextPreviousBar extends StatelessWidget {
  const NextPreviousBar({
    Key? key,
    required this.content,
    required this.increase,
    required this.decrease,
  }) : super(key: key);

  final String content;
  final VoidCallback increase;
  final VoidCallback decrease;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      GestureDetector(
          onTap: decrease,
          child: Container(
              height: 22.0,
              width: 22.0,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(11)),
              alignment: Alignment.center,
              child: Image.asset("assets/app_icon/direction/left_bla2.png",
                  height: 12.0, width: 12.0, fit: BoxFit.cover))),
      SizedBox(width: 4),
      Text(content,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: AnthealthColors.black0)),
      SizedBox(width: 4),
      GestureDetector(
          onTap: increase,
          child: Container(
              height: 22.0,
              width: 22.0,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(11)),
              alignment: Alignment.center,
              child: Image.asset("assets/app_icon/direction/right_bla2.png",
                  height: 12.0, width: 12.0, fit: BoxFit.cover)))
    ]);
  }
}
