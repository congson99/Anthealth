// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `-----------------------------Main-----------------------------`
  String get _Main {
    return Intl.message(
      '-----------------------------Main-----------------------------',
      name: '_Main',
      desc: '',
      args: [],
    );
  }

  /// `Family`
  String get Family {
    return Intl.message(
      'Family',
      name: 'Family',
      desc: '',
      args: [],
    );
  }

  /// `Community`
  String get Community {
    return Intl.message(
      'Community',
      name: 'Community',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Health`
  String get Health {
    return Intl.message(
      'Health',
      name: 'Health',
      desc: '',
      args: [],
    );
  }

  /// `Medic`
  String get Medic {
    return Intl.message(
      'Medic',
      name: 'Medic',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `Doctor page`
  String get Doctor_page {
    return Intl.message(
      'Doctor page',
      name: 'Doctor_page',
      desc: '',
      args: [],
    );
  }

  /// `-----------------------------Common-----------------------------`
  String get _Common {
    return Intl.message(
      '-----------------------------Common-----------------------------',
      name: '_Common',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get Detail {
    return Intl.message(
      'Detail',
      name: 'Detail',
      desc: '',
      args: [],
    );
  }

  /// `Unit`
  String get Unit {
    return Intl.message(
      'Unit',
      name: 'Unit',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get Year {
    return Intl.message(
      'Year',
      name: 'Year',
      desc: '',
      args: [],
    );
  }

  /// `All time`
  String get All_time {
    return Intl.message(
      'All time',
      name: 'All_time',
      desc: '',
      args: [],
    );
  }

  /// `Add by`
  String get Add_by {
    return Intl.message(
      'Add by',
      name: 'Add_by',
      desc: '',
      args: [],
    );
  }

  /// `Learn more`
  String get Learn_more {
    return Intl.message(
      'Learn more',
      name: 'Learn_more',
      desc: '',
      args: [],
    );
  }

  /// `successfully`
  String get successfully {
    return Intl.message(
      'successfully',
      name: 'successfully',
      desc: '',
      args: [],
    );
  }

  /// `-----------------------------Authentication-----------------------------`
  String get _Authentication {
    return Intl.message(
      '-----------------------------Authentication-----------------------------',
      name: '_Authentication',
      desc: '',
      args: [],
    );
  }

  /// `Your name`
  String get Your_name {
    return Intl.message(
      'Your name',
      name: 'Your_name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get Email {
    return Intl.message(
      'Email',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get Confirm_password {
    return Intl.message(
      'Confirm password',
      name: 'Confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get Forgot_password {
    return Intl.message(
      'Forgot password?',
      name: 'Forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `You are new User?`
  String get You_are_new_user {
    return Intl.message(
      'You are new User?',
      name: 'You_are_new_user',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get Register {
    return Intl.message(
      'Register',
      name: 'Register',
      desc: '',
      args: [],
    );
  }

  /// `Register now`
  String get Register_now {
    return Intl.message(
      'Register now',
      name: 'Register_now',
      desc: '',
      args: [],
    );
  }

  /// `Fill in information`
  String get Fill_in_information {
    return Intl.message(
      'Fill in information',
      name: 'Fill_in_information',
      desc: '',
      args: [],
    );
  }

  /// `Authenticate`
  String get Authenticate {
    return Intl.message(
      'Authenticate',
      name: 'Authenticate',
      desc: '',
      args: [],
    );
  }

  /// `Authentication code`
  String get Authentication_code {
    return Intl.message(
      'Authentication code',
      name: 'Authentication_code',
      desc: '',
      args: [],
    );
  }

  /// `Set a new password`
  String get Set_new_password {
    return Intl.message(
      'Set a new password',
      name: 'Set_new_password',
      desc: '',
      args: [],
    );
  }

  /// `-----------------------------Health-----------------------------`
  String get _Health {
    return Intl.message(
      '-----------------------------Health-----------------------------',
      name: '_Health',
      desc: '',
      args: [],
    );
  }

  /// `Health records`
  String get Health_record {
    return Intl.message(
      'Health records',
      name: 'Health_record',
      desc: '',
      args: [],
    );
  }

  /// `Hight`
  String get Height {
    return Intl.message(
      'Hight',
      name: 'Height',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get Weight {
    return Intl.message(
      'Weight',
      name: 'Weight',
      desc: '',
      args: [],
    );
  }

  /// `Heart rate`
  String get Heart_rate {
    return Intl.message(
      'Heart rate',
      name: 'Heart_rate',
      desc: '',
      args: [],
    );
  }

  /// `Temperature`
  String get Temperature {
    return Intl.message(
      'Temperature',
      name: 'Temperature',
      desc: '',
      args: [],
    );
  }

  /// `Blood Pressure`
  String get Blood_pressure {
    return Intl.message(
      'Blood Pressure',
      name: 'Blood_pressure',
      desc: '',
      args: [],
    );
  }

  /// `SPO2`
  String get Spo2 {
    return Intl.message(
      'SPO2',
      name: 'Spo2',
      desc: '',
      args: [],
    );
  }

  /// `Calo`
  String get Calo {
    return Intl.message(
      'Calo',
      name: 'Calo',
      desc: '',
      args: [],
    );
  }

  /// `Water`
  String get Water {
    return Intl.message(
      'Water',
      name: 'Water',
      desc: '',
      args: [],
    );
  }

  /// `Steps`
  String get Steps {
    return Intl.message(
      'Steps',
      name: 'Steps',
      desc: '',
      args: [],
    );
  }

  /// `Health indicator`
  String get Health_indicator {
    return Intl.message(
      'Health indicator',
      name: 'Health_indicator',
      desc: '',
      args: [],
    );
  }

  /// `Activity`
  String get Activity {
    return Intl.message(
      'Activity',
      name: 'Activity',
      desc: '',
      args: [],
    );
  }

  /// `Period`
  String get Period {
    return Intl.message(
      'Period',
      name: 'Period',
      desc: '',
      args: [],
    );
  }

  /// `Edit height data`
  String get Edit_height {
    return Intl.message(
      'Edit height data',
      name: 'Edit_height',
      desc: '',
      args: [],
    );
  }

  /// `Edit weight data`
  String get Edit_weight {
    return Intl.message(
      'Edit weight data',
      name: 'Edit_weight',
      desc: '',
      args: [],
    );
  }

  /// `Edit heart rate data`
  String get Edit_heart_rate {
    return Intl.message(
      'Edit heart rate data',
      name: 'Edit_heart_rate',
      desc: '',
      args: [],
    );
  }

  /// `Edit temperature data`
  String get Edit_temperature {
    return Intl.message(
      'Edit temperature data',
      name: 'Edit_temperature',
      desc: '',
      args: [],
    );
  }

  /// `Edit blood Pressure data`
  String get Edit_blood_pressure {
    return Intl.message(
      'Edit blood Pressure data',
      name: 'Edit_blood_pressure',
      desc: '',
      args: [],
    );
  }

  /// `Edit SPO2 data`
  String get Edit_spo2 {
    return Intl.message(
      'Edit SPO2 data',
      name: 'Edit_spo2',
      desc: '',
      args: [],
    );
  }

  /// `Add height data`
  String get Add_height {
    return Intl.message(
      'Add height data',
      name: 'Add_height',
      desc: '',
      args: [],
    );
  }

  /// `Add weight data`
  String get Add_weight {
    return Intl.message(
      'Add weight data',
      name: 'Add_weight',
      desc: '',
      args: [],
    );
  }

  /// `Add heart rate data`
  String get Add_heart_rate {
    return Intl.message(
      'Add heart rate data',
      name: 'Add_heart_rate',
      desc: '',
      args: [],
    );
  }

  /// `Add temperature data`
  String get Add_temperature {
    return Intl.message(
      'Add temperature data',
      name: 'Add_temperature',
      desc: '',
      args: [],
    );
  }

  /// `Add blood Pressure data`
  String get Add_blood_pressure {
    return Intl.message(
      'Add blood Pressure data',
      name: 'Add_blood_pressure',
      desc: '',
      args: [],
    );
  }

  /// `Add SPO2 data`
  String get Add_spo2 {
    return Intl.message(
      'Add SPO2 data',
      name: 'Add_spo2',
      desc: '',
      args: [],
    );
  }

  /// `Delete height data`
  String get Delete_height {
    return Intl.message(
      'Delete height data',
      name: 'Delete_height',
      desc: '',
      args: [],
    );
  }

  /// `Delete weight data`
  String get Delete_weight {
    return Intl.message(
      'Delete weight data',
      name: 'Delete_weight',
      desc: '',
      args: [],
    );
  }

  /// `Delete heart rate data`
  String get Delete_heart_rate {
    return Intl.message(
      'Delete heart rate data',
      name: 'Delete_heart_rate',
      desc: '',
      args: [],
    );
  }

  /// `Delete temperature data`
  String get Delete_temperature {
    return Intl.message(
      'Delete temperature data',
      name: 'Delete_temperature',
      desc: '',
      args: [],
    );
  }

  /// `Delete blood Pressure data`
  String get Delete_blood_pressure {
    return Intl.message(
      'Delete blood Pressure data',
      name: 'Delete_blood_pressure',
      desc: '',
      args: [],
    );
  }

  /// `Delete SPO2 data`
  String get Delete_spo2 {
    return Intl.message(
      'Delete SPO2 data',
      name: 'Delete_spo2',
      desc: '',
      args: [],
    );
  }

  /// `-----------------------------Button-----------------------------`
  String get _Button {
    return Intl.message(
      '-----------------------------Button-----------------------------',
      name: '_Button',
      desc: '',
      args: [],
    );
  }

  /// `LOGIN`
  String get button_login {
    return Intl.message(
      'LOGIN',
      name: 'button_login',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get button_ok {
    return Intl.message(
      'OK',
      name: 'button_ok',
      desc: '',
      args: [],
    );
  }

  /// `CANCEL`
  String get button_cancel {
    return Intl.message(
      'CANCEL',
      name: 'button_cancel',
      desc: '',
      args: [],
    );
  }

  /// `DELETE`
  String get button_delete {
    return Intl.message(
      'DELETE',
      name: 'button_delete',
      desc: '',
      args: [],
    );
  }

  /// `CLOSE`
  String get button_close {
    return Intl.message(
      'CLOSE',
      name: 'button_close',
      desc: '',
      args: [],
    );
  }

  /// `EDIT`
  String get button_edit {
    return Intl.message(
      'EDIT',
      name: 'button_edit',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this data?`
  String get Warning_delete_data {
    return Intl.message(
      'Are you sure you want to delete this data?',
      name: 'Warning_delete_data',
      desc: '',
      args: [],
    );
  }

  /// `-----------------------------Error-----------------------------`
  String get _Error {
    return Intl.message(
      '-----------------------------Error-----------------------------',
      name: '_Error',
      desc: '',
      args: [],
    );
  }

  /// `Wrong email!`
  String get Wrong_email {
    return Intl.message(
      'Wrong email!',
      name: 'Wrong_email',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password!`
  String get Wrong_password {
    return Intl.message(
      'Wrong password!',
      name: 'Wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `Wrong authentication code!`
  String get Wrong_authentication_code {
    return Intl.message(
      'Wrong authentication code!',
      name: 'Wrong_authentication_code',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get Enter_name {
    return Intl.message(
      'Please enter your name',
      name: 'Enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get Enter_email {
    return Intl.message(
      'Please enter your email',
      name: 'Enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get Enter_password {
    return Intl.message(
      'Please enter your password',
      name: 'Enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get Enter_confirm_password {
    return Intl.message(
      'Please enter your password',
      name: 'Enter_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email!`
  String get Invalid_email {
    return Intl.message(
      'Invalid email!',
      name: 'Invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least 8 characters`
  String get Invalid_password {
    return Intl.message(
      'Password must contain at least 8 characters',
      name: 'Invalid_password',
      desc: '',
      args: [],
    );
  }

  /// `This email is not registered!`
  String get Not_registered_email {
    return Intl.message(
      'This email is not registered!',
      name: 'Not_registered_email',
      desc: '',
      args: [],
    );
  }

  /// `The email was registered!`
  String get Registered_email {
    return Intl.message(
      'The email was registered!',
      name: 'Registered_email',
      desc: '',
      args: [],
    );
  }

  /// `The passwords didn’t match!`
  String get Not_match_password {
    return Intl.message(
      'The passwords didn’t match!',
      name: 'Not_match_password',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, something wrong!`
  String get something_wrong {
    return Intl.message(
      'Sorry, something wrong!',
      name: 'something_wrong',
      desc: '',
      args: [],
    );
  }

  /// `-----------------------------Time-----------------------------`
  String get _Time {
    return Intl.message(
      '-----------------------------Time-----------------------------',
      name: '_Time',
      desc: '',
      args: [],
    );
  }

  /// `Latest record`
  String get Latest_record {
    return Intl.message(
      'Latest record',
      name: 'Latest_record',
      desc: '',
      args: [],
    );
  }

  /// `Record time`
  String get Record_time {
    return Intl.message(
      'Record time',
      name: 'Record_time',
      desc: '',
      args: [],
    );
  }

  /// `Record time`
  String get Record_hour {
    return Intl.message(
      'Record time',
      name: 'Record_hour',
      desc: '',
      args: [],
    );
  }

  /// `Record date`
  String get Record_date {
    return Intl.message(
      'Record date',
      name: 'Record_date',
      desc: '',
      args: [],
    );
  }

  /// `JAN`
  String get jan {
    return Intl.message(
      'JAN',
      name: 'jan',
      desc: '',
      args: [],
    );
  }

  /// `FEB`
  String get feb {
    return Intl.message(
      'FEB',
      name: 'feb',
      desc: '',
      args: [],
    );
  }

  /// `MAR`
  String get mar {
    return Intl.message(
      'MAR',
      name: 'mar',
      desc: '',
      args: [],
    );
  }

  /// `APR`
  String get apr {
    return Intl.message(
      'APR',
      name: 'apr',
      desc: '',
      args: [],
    );
  }

  /// `MAY`
  String get may {
    return Intl.message(
      'MAY',
      name: 'may',
      desc: '',
      args: [],
    );
  }

  /// `JUN`
  String get jun {
    return Intl.message(
      'JUN',
      name: 'jun',
      desc: '',
      args: [],
    );
  }

  /// `JUL`
  String get jul {
    return Intl.message(
      'JUL',
      name: 'jul',
      desc: '',
      args: [],
    );
  }

  /// `AUG`
  String get aug {
    return Intl.message(
      'AUG',
      name: 'aug',
      desc: '',
      args: [],
    );
  }

  /// `SEP`
  String get sep {
    return Intl.message(
      'SEP',
      name: 'sep',
      desc: '',
      args: [],
    );
  }

  /// `OCT`
  String get oct {
    return Intl.message(
      'OCT',
      name: 'oct',
      desc: '',
      args: [],
    );
  }

  /// `NOV`
  String get nov {
    return Intl.message(
      'NOV',
      name: 'nov',
      desc: '',
      args: [],
    );
  }

  /// `DEC`
  String get dec {
    return Intl.message(
      'DEC',
      name: 'dec',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
