import 'package:anthealth_mobile/views/common_widgets/avatar.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomAppbarWithSmallAvatar extends StatelessWidget {
  const CustomAppbarWithSmallAvatar(
      {Key? key,
      required this.context,
      required this.name,
      required this.avatarPath,
      this.avatarTap,
      this.add})
      : super(key: key);

  final BuildContext context;
  final String name;
  final String avatarPath;
  final VoidCallback? avatarTap;
  final VoidCallback? add;

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
            GestureDetector(
                onTap: avatarTap,
                child: Avatar(imagePath: avatarPath, size: 40)),
            SizedBox(width: 8),
            Expanded(
                child: GestureDetector(
              onTap: avatarTap,
              child: Text(name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: AnthealthColors.black0)),
            )),
            if (add != null)
              GestureDetector(
                  onTap: add,
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
