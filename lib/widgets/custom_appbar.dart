import 'package:anthealth_mobile/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.back,
    this.add,
    this.share,
    this.edit,
    this.settings,
  }) : super(key: key);

  final String title;
  final VoidCallback back;
  final VoidCallback? add;
  final VoidCallback? share;
  final VoidCallback? edit;
  final VoidCallback? settings;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          height: 4,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 60),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)
          ])),
      Container(
          height: 64,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(16),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: back,
                          child: Image.asset(
                              "assets/app_icon/direction/page_back.png",
                              height: 16.0,
                              width: 16.0,
                              fit: BoxFit.cover)),
                      SizedBox(width: 16),
                      Container(
                        width: MediaQuery.of(context).size.width -
                            80 -
                            ((add != null) ? 22 : 0) -
                            ((share != null) ? 44 : 0) -
                            ((edit != null) ? 44 : 0) -
                            ((settings != null) ? 44 : 0),
                        child: Text(title,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: AnthealthColors.black1)),
                      )
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (add != null)
                        GestureDetector(
                            onTap: add,
                            child: Image.asset(
                                "assets/app_icon/common/add_pri1.png",
                                height: 22.0,
                                width: 22.0,
                                fit: BoxFit.cover)),
                      if (share != null) SizedBox(width: 22),
                      if (share != null)
                        GestureDetector(
                            onTap: share,
                            child: Image.asset(
                                "assets/app_icon/common/share_sec1.png",
                                height: 22.0,
                                width: 22.0,
                                fit: BoxFit.cover)),
                      if (edit != null) SizedBox(width: 22),
                      if (edit != null)
                        GestureDetector(
                            onTap: edit,
                            child: Image.asset(
                                "assets/app_icon/common/edit_war1.png",
                                height: 22.0,
                                width: 22.0,
                                fit: BoxFit.cover)),
                      if (settings != null) SizedBox(width: 22),
                      if (settings != null)
                        GestureDetector(
                            onTap: settings,
                            child: Image.asset(
                                "assets/app_icon/common/settings_bla1.png",
                                height: 22.0,
                                width: 22.0,
                                fit: BoxFit.cover))
                    ])
              ]))
    ]);
  }
}