import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Version: DEV 1.0.0 (02.03.2022)", style: Theme.of(context).textTheme.subtitle1),
        SizedBox(height: 16),
        Text("Completed features:", style: Theme.of(context).textTheme.bodyText2),
        SizedBox(height: 8),
        Text("1. Authentication:", style: Theme.of(context).textTheme.bodyText2),
        Text("    - Login", style: Theme.of(context).textTheme.bodyText2),
        Text("    - Logout", style: Theme.of(context).textTheme.bodyText2),
        Text("    - Register", style: Theme.of(context).textTheme.bodyText2),
        SizedBox(height: 8),
        Text("2. Health:", style: Theme.of(context).textTheme.bodyText2),
        Text("    - Indicator tracking", style: Theme.of(context).textTheme.bodyText2),
      ],
    ));
  }
}
