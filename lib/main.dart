import 'package:anthealth_mobile/theme/theme.dart';
import 'package:anthealth_mobile/views/test/test.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: anthealthTheme(),
      home: Test(),
    );
  }
}
