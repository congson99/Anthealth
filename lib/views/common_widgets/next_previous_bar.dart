import 'package:anthealth_mobile/views/theme/colors.dart';
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
          child: Container(
            height: 22.0,
            width: 22.0,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(11)),
            alignment: Alignment.center,
            child: Image.asset("assets/app_icon/direction/left_bla2.png",
                height: 12.0, width: 12.0, fit: BoxFit.cover)
          )),
      SizedBox(width: 4),
      Text(content,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: AnthealthColors.black0)),
      SizedBox(width: 4),
      GestureDetector(
          onTap: increse,
          child: Container(
            height: 22.0,
            width: 22.0,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(11)),
            alignment: Alignment.center,
            child: Image.asset("assets/app_icon/direction/right_bla2.png",
                height: 12.0, width: 12.0, fit: BoxFit.cover)
          ))
    ]);
  }
}
