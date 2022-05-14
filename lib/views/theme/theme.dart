import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

ThemeData anthealthTheme() {
  TextTheme _anthealthTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: TextStyle(
          fontSize: 32,
          letterSpacing: 0.4,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoRegular'),
      headline2: TextStyle(
          fontSize: 24,
          letterSpacing: 0.5,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoMedium'),
      headline3: TextStyle(
          fontSize: 24,
          letterSpacing: 0.5,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoRegular'),
      headline4: TextStyle(
          fontSize: 20,
          letterSpacing: 0.7,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoMedium'),
      headline5: TextStyle(
          fontSize: 20,
          letterSpacing: 0.5,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoRegular'),
      subtitle1: TextStyle(
          fontSize: 18,
          letterSpacing: 0.5,
          height: 1.2,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoMedium'),
      subtitle2: TextStyle(
          fontSize: 16,
          letterSpacing: 0.4,
          height: 1.2,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoMedium'),
      bodyText1: TextStyle(
          fontSize: 16,
          letterSpacing: 0.5,
          height: 1.25,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoRegular'),
      bodyText2: TextStyle(
          fontSize: 14,
          letterSpacing: 0.5,
          height: 1.25,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoRegular'),
      button: TextStyle(
          fontSize: 14,
          letterSpacing: 1.2,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoMedium'),
      caption: TextStyle(
          fontSize: 14,
          letterSpacing: 0.6,
          height: 1.2,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoMedium'),
      overline: TextStyle(
          fontSize: 12,
          letterSpacing: 0.6,
          height: 1.3,
          color: AnthealthColors.black0,
          fontFamily: 'RobotoRegular'),
    );
  }

  final ThemeData base = ThemeData(
      fontFamily: 'RobotoMedium', scaffoldBackgroundColor: Colors.white);
  return base.copyWith(textTheme: _anthealthTextTheme(base.textTheme));
}
