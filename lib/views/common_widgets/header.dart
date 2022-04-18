import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.title,
    required this.content,
    required this.isNotification,
    required this.isMessage,
    required this.onSettingsTap,
  }) : super(key: key);

  final String title;
  final String content;
  final bool isNotification;
  final bool isMessage;
  final VoidCallback onSettingsTap;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          height: 82,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: AnthealthColors.black1)),
                SizedBox(height: 4),
                Text(content,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: AnthealthColors.primary0))
              ]),
              buildActions()
            ])
          ]))
    ]);
  }

  // Actions
  Widget buildActions() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(
              isNotification
                  ? "assets/app_icon/common/notification_noti_pri1.png"
                  : "assets/app_icon/common/notification_pri1.png",
              height: 20.0,
              fit: BoxFit.fitHeight),
          SizedBox(width: 16),
          Image.asset(
              isMessage
                  ? "assets/app_icon/common/message_noti_pri1.png"
                  : "assets/app_icon/common/message_pri1.png",
              height: 20.0,
              fit: BoxFit.fitHeight),
          SizedBox(width: 16),
          GestureDetector(
              onTap: onSettingsTap,
              child: Image.asset("assets/app_icon/common/settings_bla2.png",
                  height: 20.0, fit: BoxFit.fitHeight))
        ]);
  }
}
