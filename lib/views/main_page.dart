import 'package:anthealth_mobile/views/community/community_page.dart';
import 'package:anthealth_mobile/views/family/family_page.dart';
import 'package:anthealth_mobile/views/health/health_page.dart';
import 'package:anthealth_mobile/views/home/home_page.dart';
import 'package:anthealth_mobile/views/medic/medic_page.dart';
import 'package:anthealth_mobile/widgets/bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List _page = [
    FamilyPage(),
    CommunityPage(),
    HomePage(),
    HealthPage(),
    MedicPage()
  ];
  int _currentPage = 2;

  void onBottomNavigationItemTap(index) => setState(() => _currentPage = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          _page[_currentPage],
          BottomNavigaton(
            size: MediaQuery.of(context).size,
            index: _currentPage,
            imagePath: "assets/avatar.png",
            onIndexChange: (int index) => onBottomNavigationItemTap(index),
          )
        ]),
      ),
    );
  }
}
