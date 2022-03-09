import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NextPreviousBar extends StatelessWidget {
  const NextPreviousBar({
    Key? key,
    required this.content,
    required this.index,
    required this.increse,
    required this.decrese,
  }) : super(key: key);

  final List<String> content;
  final int index;
  final Function(int) increse;
  final Function(int) decrese;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      GestureDetector(
        onTap: () => decrese(index == content.length - 1 ? index : index + 1),
        child: Image.asset("assets/app_icon/direction/left_bla2.png",
            height: 12.0, width: 12.0, fit: BoxFit.cover),
      ),
      SizedBox(width: 8),
      Text(content[index],
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: AnthealthColors.black0)),
      SizedBox(width: 8),
      GestureDetector(
        onTap: () => increse(index == 0 ? index : index - 1),
        child: Image.asset("assets/app_icon/direction/right_bla2.png",
            height: 12.0, width: 12.0, fit: BoxFit.cover),
      )
    ]);
  }
}
