import 'package:anthealth_mobile/views/common_widgets/avatar.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomAppbarWithAvatar extends StatefulWidget {
  const CustomAppbarWithAvatar(
      {Key? key,
      required this.context,
      required this.name,
      required this.avatarPath,
      this.firstTitle,
      this.secondTitle,
      this.favorite,
      this.add})
      : super(key: key);

  final BuildContext context;
  final String name;
  final String avatarPath;
  final String? firstTitle;
  final String? secondTitle;
  final bool? favorite;
  final VoidCallback? add;

  @override
  State<CustomAppbarWithAvatar> createState() => _CustomAppbarWithAvatarState();
}

class _CustomAppbarWithAvatarState extends State<CustomAppbarWithAvatar> {
  bool isShowMenu = false;
  bool favorite = false;

  @override
  void initState() {
    super.initState();
    if (widget.favorite != null) favorite = widget.favorite!;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          height: 8,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 72),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)
          ])),
      Container(
          height: 80,
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
            Avatar(imagePath: widget.avatarPath, size: 64),
            SizedBox(width: 8),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  if (widget.firstTitle != null)
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(widget.firstTitle!,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: AnthealthColors.black2))),
                  Text(widget.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: AnthealthColors.black0)),
                  if (widget.secondTitle != null) SizedBox(height: 2),
                  if (widget.secondTitle != null)
                    Text(widget.secondTitle!,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: AnthealthColors.black2))
                ])),
            if (widget.add != null)
              GestureDetector(
                  onTap: widget.add,
                  child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(
                          left: 4, right: 16, top: 16, bottom: 16),
                      child: Image.asset("assets/app_icon/common/add_pri1.png",
                          height: 22, width: 22, fit: BoxFit.cover))),
            if (widget.favorite != null)
              GestureDetector(
                  onTap: () => setState(() => favorite = !favorite),
                  child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(
                          left: 4, right: 16, top: 16, bottom: 16),
                      child: Image.asset(
                          favorite
                              ? "assets/app_icon/small_icons/favorite.png"
                              : "assets/app_icon/small_icons/unfavorite.png",
                          height: 28,
                          width: 28,
                          fit: BoxFit.cover)))
          ]))
    ]);
  }
}
