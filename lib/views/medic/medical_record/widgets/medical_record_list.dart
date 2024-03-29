import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class MedicalRecordLabelComponent extends StatelessWidget {
  const MedicalRecordLabelComponent(
      {Key? key,
      required this.left,
      required this.right,
      required this.isOpen,
      required this.onTap,
      this.isDirection})
      : super(key: key);

  final String left;
  final String right;
  final bool isOpen;
  final VoidCallback onTap;
  final bool? isDirection;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
            height: 36,
            color: Colors.transparent,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width-100)*0.65,
                    child: Text(left,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: AnthealthColors.primary1)),
                  ),
                  Expanded(child: Container()),
                  Container(
                    width: (MediaQuery.of(context).size.width-100)*0.35,
                    alignment: Alignment.centerRight,
                    child: Text(right,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: AnthealthColors.primary1)),
                  ),
                  if (isDirection != false) SizedBox(width: 8),
                  if (isDirection != false)
                    isOpen
                        ? Image.asset("assets/app_icon/direction/down_pri1.png",
                            height: 12, width: 12, fit: BoxFit.cover)
                        : Image.asset(
                            "assets/app_icon/direction/right_pri1.png",
                            height: 12,
                            width: 12,
                            fit: BoxFit.cover)
                ])),
      );
}
