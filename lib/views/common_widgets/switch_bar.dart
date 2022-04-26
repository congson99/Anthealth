import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class SwitchBar extends StatelessWidget {
  const SwitchBar({
    Key? key,
    required this.content,
    required this.index,
    required this.onIndexChange,
    required this.colorID,
  }) : super(key: key);

  final List<String> content;
  final int index;
  final Function(int) onIndexChange;
  final int colorID;

  @override
  Widget build(BuildContext context) {
    Color color1 = colorID == 0
        ? AnthealthColors.primary1
        : colorID == 1
            ? AnthealthColors.secondary1
            : colorID == 2
                ? AnthealthColors.warning1
                : AnthealthColors.black1;
    Color color3 = colorID == 0
        ? AnthealthColors.primary3
        : colorID == 1
            ? AnthealthColors.secondary3
            : colorID == 2
                ? AnthealthColors.warning3
                : AnthealthColors.black3;
    Color color4 = colorID == 0
        ? AnthealthColors.primary4
        : colorID == 1
            ? AnthealthColors.secondary4
            : colorID == 2
                ? AnthealthColors.warning4
                : AnthealthColors.black4;
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: color3),
                BoxShadow(
                    color: color4,
                    spreadRadius: -1,
                    blurRadius: 1,
                    offset: Offset(-1, 1))
              ]),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: content.map((value) {
                return GestureDetector(
                    onTap: () => onIndexChange(content.indexOf(value)),
                    child: (value == content[index])
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 1,
                                      offset: Offset(-1, 1))
                                ]),
                            child: Text(value,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: AnthealthColors.black1)))
                        : Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            color: Colors.transparent,
                            child: Text(value,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: color1))));
              }).toList()))
    ]);
  }
}
