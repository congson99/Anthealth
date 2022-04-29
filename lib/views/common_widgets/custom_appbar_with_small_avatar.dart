import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomAppbarWithSmallAvatar extends StatefulWidget {
  const CustomAppbarWithSmallAvatar(
      {Key? key,
      required this.context,
      required this.name,
      required this.avatarPath,
      this.add})
      : super(key: key);

  final BuildContext context;
  final String name;
  final String avatarPath;
  final VoidCallback? add;

  @override
  State<CustomAppbarWithSmallAvatar> createState() =>
      _CustomAppbarWithSmallAvatarState();
}

class _CustomAppbarWithSmallAvatarState
    extends State<CustomAppbarWithSmallAvatar> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          height: 8,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 48),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)
          ])),
      Container(
          height: 56,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 4, bottom: 12, left: 12),
          child: Row(children: [
            GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16)),
                    alignment: Alignment.center,
                    child: Image.asset(
                        "assets/app_icon/direction/page_back.png",
                        height: 16.0,
                        width: 16.0,
                        fit: BoxFit.cover))),
            SizedBox(width: 8),
            ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.network(widget.avatarPath,
                    width: 40, height: 40, fit: BoxFit.cover)),
            SizedBox(width: 8),
            Expanded(
                child: Text(widget.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: AnthealthColors.black0))),
            if (widget.add != null)
              GestureDetector(
                  onTap: widget.add,
                  child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(
                          left: 8, right: 16, top: 8, bottom: 8),
                      child: Image.asset("assets/app_icon/common/add_pri1.png",
                          height: 22, width: 22, fit: BoxFit.cover)))
          ]))
    ]);
  }
}
