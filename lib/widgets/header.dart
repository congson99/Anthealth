import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
    required this.title,
    required this.content,
    required this.isNotification,
    required this.isMessage,
  }) : super(key: key);

  final String title;
  final String content;
  final bool isNotification;
  final bool isMessage;

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool isShowMenu = false;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.only(bottom: 16),
          height: 90,
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: AnthealthColors.black1)),
                        SizedBox(height: 4),
                        Text(widget.content,
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: AnthealthColors.primary0))
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset(
                          widget.isNotification
                              ? "assets/app_icon/common/notification_noti_pri1.png"
                              : "assets/app_icon/common/notification_pri1.png",
                          height: 20.0,
                          fit: BoxFit.fitHeight,
                        ),
                        SizedBox(width: 16),
                        Image.asset(
                          widget.isMessage
                              ? "assets/app_icon/common/message_noti_pri1.png"
                              : "assets/app_icon/common/message_pri1.png",
                          height: 20.0,
                          fit: BoxFit.fitHeight,
                        ),
                        SizedBox(width: 16),
                        GestureDetector(
                            onTap: () => setState(
                                  () => isShowMenu = true,
                                ),
                            child: Image.asset(
                              "assets/app_icon/common/menu_bla2.png",
                              height: 20.0,
                              fit: BoxFit.fitHeight,
                            ))
                      ])
                ])
          ])),
      isShowMenu ? buildMenu(context) : Container()
    ]);
  }

  Container buildMenu(BuildContext context) {
    return Container(
        child: Stack(children: [
      GestureDetector(
        onTap: () => setState(
              () => isShowMenu = false,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black.withOpacity(0.5),
        ),
      ),
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => setState(
                        () => isShowMenu = false,
                  ),
                  child: Image.asset(
                    "assets/app_icon/common/menu_bla5.png",
                    height: 20.0,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 16),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              "assets/app_icon/common/settings_bla2.png",
                                              height: 22.0,
                                              fit: BoxFit.fitHeight),
                                          SizedBox(width: 12),
                                          Text(S.of(context).settings,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                      color: AnthealthColors
                                                          .black2))
                                        ])),
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 16),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                              "assets/app_icon/common/doctor_bla2.png",
                                              height: 22.0,
                                              fit: BoxFit.fitHeight),
                                          SizedBox(width: 12),
                                          Text(S.of(context).doctor_page,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                      color: AnthealthColors
                                                          .black2))
                                        ]))
                              ]))
                    ])
              ])),
      Container(
          margin: const EdgeInsets.only(top: 113, left: 205, right: 16),
          child: Divider(height: 0.5, color: AnthealthColors.black2))
    ]));
  }
}
