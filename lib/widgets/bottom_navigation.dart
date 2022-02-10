import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomNavigaton extends StatelessWidget {
  const BottomNavigaton(
      {Key? key,
      required this.size,
      required this.index,
      required this.imagePath,
      required this.onIndexChange})
      : super(key: key);

  final Size size;
  final int index;
  final String imagePath;
  final Function(int) onIndexChange;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 0,
        bottom: 0,
        width: size.width,
        height: 110,
        child: Stack(children: [
          Container(
              margin: const EdgeInsets.only(top: 30),
              height: 60,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)
              ]),
              child: CustomPaint(
                  size: Size(size.width, 60),
                  painter: BottomNavigationCustomPaint())),
          Container(
              margin: const EdgeInsets.only(top: 90),
              height: 20,
              color: Colors.white),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            margin: const EdgeInsets.only(top: 30),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BottomNavigationItem(
                  size: size,
                  onIndexChange: onIndexChange,
                  currentIndex: index,
                  itemIndex: 0,
                  selectIconPath:
                      "assets/app_icon/bottom_navigation/family_pri1.png",
                  unSelectIconPath:
                      "assets/app_icon/bottom_navigation/family_bla3.png",
                  title: S.of(context).Family,
                ),
                BottomNavigationItem(
                  size: size,
                  onIndexChange: onIndexChange,
                  currentIndex: index,
                  itemIndex: 1,
                  selectIconPath:
                      "assets/app_icon/bottom_navigation/community_pri1.png",
                  unSelectIconPath:
                      "assets/app_icon/bottom_navigation/community_bla3.png",
                  title: S.of(context).Community,
                ),
                BottomNavigationItem(
                  size: size,
                  onIndexChange: onIndexChange,
                  currentIndex: index,
                  itemIndex: 2,
                  selectIconPath: "",
                  unSelectIconPath: "",
                  title: S.of(context).Home,
                ),
                BottomNavigationItem(
                  size: size,
                  onIndexChange: onIndexChange,
                  currentIndex: index,
                  itemIndex: 3,
                  selectIconPath:
                      "assets/app_icon/bottom_navigation/health_pri1.png",
                  unSelectIconPath:
                      "assets/app_icon/bottom_navigation/health_bla3.png",
                  title: S.of(context).Health,
                ),
                BottomNavigationItem(
                  size: size,
                  onIndexChange: onIndexChange,
                  currentIndex: index,
                  itemIndex: 4,
                  selectIconPath:
                      "assets/app_icon/bottom_navigation/medic_pri1.png",
                  unSelectIconPath:
                      "assets/app_icon/bottom_navigation/medic_bla3.png",
                  title: S.of(context).Medic,
                ),
              ],
            ),
          ),
          Container(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () => onIndexChange(2),
                child: Container(
                    height: 76.0,
                    width: 76.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: index == 2
                            ? AnthealthColors.primary1
                            : Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8)
                        ]),
                    child: Container(
                      height: 68.0,
                      width: 68.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(34),
                          child: Image.asset(
                            imagePath,
                            height: 68.0,
                            width: 68.0,
                            fit: BoxFit.cover,
                          )),
                    )),
              ))
        ]));
  }
}

class BottomNavigationItem extends StatelessWidget {
  const BottomNavigationItem(
      {Key? key,
      required this.size,
      required this.onIndexChange,
      required this.currentIndex,
      required this.itemIndex,
      required this.selectIconPath,
      required this.unSelectIconPath,
      required this.title})
      : super(key: key);

  final Size size;
  final Function(int p1) onIndexChange;
  final int currentIndex;
  final int itemIndex;
  final String selectIconPath;
  final String unSelectIconPath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 44,
        width: itemIndex == 2 ? size.width * 0.2 + 4 : size.width * 0.2 - 16,
        child: GestureDetector(
            onTap: () => onIndexChange(itemIndex),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  itemIndex == 2
                      ? Container()
                      : Image.asset(
                          currentIndex == itemIndex
                              ? selectIconPath
                              : unSelectIconPath,
                          height: 24.0,
                          fit: BoxFit.fitHeight,
                        ),
                  Text(title,
                      style: itemIndex == currentIndex
                          ? Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 10,
                              color: AnthealthColors.primary1,
                              fontFamily: 'RobotoMedium')
                          : Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 10))
                ])));
  }
}

class BottomNavigationCustomPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 0);
    path.lineTo(size.width * 0.5 - 51, 0);
    path.quadraticBezierTo(size.width * 0.5 - 44, 2, size.width * 0.5 - 43, 8);
    path.arcToPoint(Offset(size.width * 0.5 + 43, 8),
        radius: Radius.circular(10), clockwise: false);
    path.quadraticBezierTo(size.width * 0.5 + 44, 2, size.width * 0.5 + 51, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
