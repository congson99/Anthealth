import 'package:anthealth_mobile/theme/colors.dart';
import 'package:flutter/material.dart';

ThemeData anthealthTheme() {
  TextTheme _anthealthTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: TextStyle(
          fontSize: 32,
          letterSpacing: 1,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoRegular'),
      headline2: TextStyle(
          fontSize: 24,
          letterSpacing: 1,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoMedium'),
      headline3: TextStyle(
          fontSize: 24,
          letterSpacing: 1,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoRegular'),
      headline4: TextStyle(
          fontSize: 20,
          letterSpacing: 1,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoMedium'),
      headline5: TextStyle(
          fontSize: 20,
          letterSpacing: 1,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoRegular'),
      subtitle1: TextStyle(
          fontSize: 16,
          letterSpacing: 1,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoMedium'),
      bodyText1: TextStyle(
          fontSize: 16,
          letterSpacing: 1,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoRegular'),
      bodyText2: TextStyle(
          fontSize: 14,
          letterSpacing: 1,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoRegular'),
      button: TextStyle(
          fontSize: 14,
          letterSpacing: 2,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoMedium'),
      caption: TextStyle(
          fontSize: 12,
          letterSpacing: 1,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoMedium'),
      overline: TextStyle(
          fontSize: 12,
          letterSpacing: 5,
          color: AnthealthColors.black2,
          fontFamily: 'RobotoMedium'),
    );
  }

  final ThemeData base = ThemeData(fontFamily: 'RobotoMedium');
  return base.copyWith(
      scaffoldBackgroundColor: Colors.white,
      textTheme: _anthealthTextTheme(base.textTheme));
}
