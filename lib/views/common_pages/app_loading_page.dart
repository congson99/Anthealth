import 'dart:math';

import 'package:flutter/material.dart';

class AppLoadingPage extends StatelessWidget {
  const AppLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Scaffold(backgroundColor: Colors.white, body: buildLogo(context));

  Widget buildLogo(BuildContext context) => Center(
      child: Container(
          width: min(MediaQuery.of(context).size.width * 0.5, 350),
          child: Image.asset("assets/app_text_logo_slogan.png",
              fit: BoxFit.fitWidth)));
}
