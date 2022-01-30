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

  /// `------------------------------------------`
  String get Main {
    return Intl.message(
      '------------------------------------------',
      name: 'Main',
      desc: '',
      args: [],
    );
  }

  /// `Family`
  String get family {
    return Intl.message(
      'Family',
      name: 'family',
      desc: '',
      args: [],
    );
  }

  /// `Community`
  String get community {
    return Intl.message(
      'Community',
      name: 'community',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Health`
  String get health {
    return Intl.message(
      'Health',
      name: 'health',
      desc: '',
      args: [],
    );
  }

  /// `Medic`
  String get medic {
    return Intl.message(
      'Medic',
      name: 'medic',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Doctor page`
  String get doctor_page {
    return Intl.message(
      'Doctor page',
      name: 'doctor_page',
      desc: '',
      args: [],
    );
  }

  /// `------------------------------------------`
  String get HealthPage {
    return Intl.message(
      '------------------------------------------',
      name: 'HealthPage',
      desc: '',
      args: [],
    );
  }

  /// `Health records`
  String get health_record {
    return Intl.message(
      'Health records',
      name: 'health_record',
      desc: '',
      args: [],
    );
  }

  /// `Hight`
  String get height {
    return Intl.message(
      'Hight',
      name: 'height',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `Heart rate`
  String get heart_rate {
    return Intl.message(
      'Heart rate',
      name: 'heart_rate',
      desc: '',
      args: [],
    );
  }

  /// `Temperature`
  String get temperature {
    return Intl.message(
      'Temperature',
      name: 'temperature',
      desc: '',
      args: [],
    );
  }

  /// `Blood Pressure`
  String get blood_pressure {
    return Intl.message(
      'Blood Pressure',
      name: 'blood_pressure',
      desc: '',
      args: [],
    );
  }

  /// `SPO2`
  String get spo2 {
    return Intl.message(
      'SPO2',
      name: 'spo2',
      desc: '',
      args: [],
    );
  }

  /// `Calo`
  String get calo {
    return Intl.message(
      'Calo',
      name: 'calo',
      desc: '',
      args: [],
    );
  }

  /// `Water`
  String get water {
    return Intl.message(
      'Water',
      name: 'water',
      desc: '',
      args: [],
    );
  }

  /// `Steps`
  String get steps {
    return Intl.message(
      'Steps',
      name: 'steps',
      desc: '',
      args: [],
    );
  }

  /// `Health indicator`
  String get health_indicator {
    return Intl.message(
      'Health indicator',
      name: 'health_indicator',
      desc: '',
      args: [],
    );
  }

  /// `Activity`
  String get activity {
    return Intl.message(
      'Activity',
      name: 'activity',
      desc: '',
      args: [],
    );
  }

  /// `Period`
  String get period {
    return Intl.message(
      'Period',
      name: 'period',
      desc: '',
      args: [],
    );
  }

  /// `Latest record`
  String get latest_record {
    return Intl.message(
      'Latest record',
      name: 'latest_record',
      desc: '',
      args: [],
    );
  }

  /// `Record time`
  String get record_time {
    return Intl.message(
      'Record time',
      name: 'record_time',
      desc: '',
      args: [],
    );
  }

  /// `Record time`
  String get record_hour {
    return Intl.message(
      'Record time',
      name: 'record_hour',
      desc: '',
      args: [],
    );
  }

  /// `Record date`
  String get record_date {
    return Intl.message(
      'Record date',
      name: 'record_date',
      desc: '',
      args: [],
    );
  }

  /// `Edit height data`
  String get edit_height {
    return Intl.message(
      'Edit height data',
      name: 'edit_height',
      desc: '',
      args: [],
    );
  }

  /// `Edit weight data`
  String get edit_weight {
    return Intl.message(
      'Edit weight data',
      name: 'edit_weight',
      desc: '',
      args: [],
    );
  }

  /// `Edit heart rate data`
  String get edit_heart_rate {
    return Intl.message(
      'Edit heart rate data',
      name: 'edit_heart_rate',
      desc: '',
      args: [],
    );
  }

  /// `Edit temperature data`
  String get edit_temperature {
    return Intl.message(
      'Edit temperature data',
      name: 'edit_temperature',
      desc: '',
      args: [],
    );
  }

  /// `Edit blood Pressure data`
  String get edit_blood_pressure {
    return Intl.message(
      'Edit blood Pressure data',
      name: 'edit_blood_pressure',
      desc: '',
      args: [],
    );
  }

  /// `Edit SPO2 data`
  String get edit_spo2 {
    return Intl.message(
      'Edit SPO2 data',
      name: 'edit_spo2',
      desc: '',
      args: [],
    );
  }

  /// `Add height data`
  String get add_height {
    return Intl.message(
      'Add height data',
      name: 'add_height',
      desc: '',
      args: [],
    );
  }

  /// `Add weight data`
  String get add_weight {
    return Intl.message(
      'Add weight data',
      name: 'add_weight',
      desc: '',
      args: [],
    );
  }

  /// `Add heart rate data`
  String get add_heart_rate {
    return Intl.message(
      'Add heart rate data',
      name: 'add_heart_rate',
      desc: '',
      args: [],
    );
  }

  /// `Add temperature data`
  String get add_temperature {
    return Intl.message(
      'Add temperature data',
      name: 'add_temperature',
      desc: '',
      args: [],
    );
  }

  /// `Add blood Pressure data`
  String get add_blood_pressure {
    return Intl.message(
      'Add blood Pressure data',
      name: 'add_blood_pressure',
      desc: '',
      args: [],
    );
  }

  /// `Add SPO2 data`
  String get add_spo2 {
    return Intl.message(
      'Add SPO2 data',
      name: 'add_spo2',
      desc: '',
      args: [],
    );
  }

  /// `Delete height data`
  String get delete_height {
    return Intl.message(
      'Delete height data',
      name: 'delete_height',
      desc: '',
      args: [],
    );
  }

  /// `Delete weight data`
  String get delete_weight {
    return Intl.message(
      'Delete weight data',
      name: 'delete_weight',
      desc: '',
      args: [],
    );
  }

  /// `Delete heart rate data`
  String get delete_heart_rate {
    return Intl.message(
      'Delete heart rate data',
      name: 'delete_heart_rate',
      desc: '',
      args: [],
    );
  }

  /// `Delete temperature data`
  String get delete_temperature {
    return Intl.message(
      'Delete temperature data',
      name: 'delete_temperature',
      desc: '',
      args: [],
    );
  }

  /// `Delete blood Pressure data`
  String get delete_blood_pressure {
    return Intl.message(
      'Delete blood Pressure data',
      name: 'delete_blood_pressure',
      desc: '',
      args: [],
    );
  }

  /// `Delete SPO2 data`
  String get delete_spo2 {
    return Intl.message(
      'Delete SPO2 data',
      name: 'delete_spo2',
      desc: '',
      args: [],
    );
  }

  /// `------------------------------------------`
  String get DateTime {
    return Intl.message(
      '------------------------------------------',
      name: 'DateTime',
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

  /// `---------------------------------------------`
  String get Common {
    return Intl.message(
      '---------------------------------------------',
      name: 'Common',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get detail {
    return Intl.message(
      'Detail',
      name: 'detail',
      desc: '',
      args: [],
    );
  }

  /// `Unit`
  String get unit {
    return Intl.message(
      'Unit',
      name: 'unit',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `All time`
  String get all_time {
    return Intl.message(
      'All time',
      name: 'all_time',
      desc: '',
      args: [],
    );
  }

  /// `Add by`
  String get add_by {
    return Intl.message(
      'Add by',
      name: 'add_by',
      desc: '',
      args: [],
    );
  }

  /// `Learn more`
  String get learn_more {
    return Intl.message(
      'Learn more',
      name: 'learn_more',
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

  /// `---------------------------------------------`
  String get Button {
    return Intl.message(
      '---------------------------------------------',
      name: 'Button',
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
  String get warning_delete_data {
    return Intl.message(
      'Are you sure you want to delete this data?',
      name: 'warning_delete_data',
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
