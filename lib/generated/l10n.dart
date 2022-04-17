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

  /// `Hour`
  String get Hour {
    return Intl.message(
      'Hour',
      name: 'Hour',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get Day {
    return Intl.message(
      'Day',
      name: 'Day',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get Month {
    return Intl.message(
      'Month',
      name: 'Month',
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

  /// `Directory`
  String get Directory {
    return Intl.message(
      'Directory',
      name: 'Directory',
      desc: '',
      args: [],
    );
  }

  /// `General information`
  String get General_information {
    return Intl.message(
      'General information',
      name: 'General_information',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get Quantity {
    return Intl.message(
      'Quantity',
      name: 'Quantity',
      desc: '',
      args: [],
    );
  }

  /// `Photo view`
  String get Photo_view {
    return Intl.message(
      'Photo view',
      name: 'Photo_view',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get Content {
    return Intl.message(
      'Content',
      name: 'Content',
      desc: '',
      args: [],
    );
  }

  /// `Required content`
  String get Required_content {
    return Intl.message(
      'Required content',
      name: 'Required_content',
      desc: '',
      args: [],
    );
  }

  /// `You have not filled in the required content`
  String get required_fill {
    return Intl.message(
      'You have not filled in the required content',
      name: 'required_fill',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get Note {
    return Intl.message(
      'Note',
      name: 'Note',
      desc: '',
      args: [],
    );
  }

  /// `Repeat`
  String get Repeat {
    return Intl.message(
      'Repeat',
      name: 'Repeat',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get Update {
    return Intl.message(
      'Update',
      name: 'Update',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get Delete {
    return Intl.message(
      'Delete',
      name: 'Delete',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message(
      'Name',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get Address {
    return Intl.message(
      'Address',
      name: 'Address',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get Phone_number {
    return Intl.message(
      'Phone number',
      name: 'Phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Member`
  String get Member {
    return Intl.message(
      'Member',
      name: 'Member',
      desc: '',
      args: [],
    );
  }

  /// `Add member`
  String get Add_member {
    return Intl.message(
      'Add member',
      name: 'Add_member',
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

  /// `Logout`
  String get Logout {
    return Intl.message(
      'Logout',
      name: 'Logout',
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

  /// `You have no records during this period`
  String get no_indicator_record {
    return Intl.message(
      'You have no records during this period',
      name: 'no_indicator_record',
      desc: '',
      args: [],
    );
  }

  /// `Your BMI Index is `
  String get Your_bmi {
    return Intl.message(
      'Your BMI Index is ',
      name: 'Your_bmi',
      desc: '',
      args: [],
    );
  }

  /// `You are `
  String get You_are {
    return Intl.message(
      'You are ',
      name: 'You_are',
      desc: '',
      args: [],
    );
  }

  /// `thinness`
  String get thinness {
    return Intl.message(
      'thinness',
      name: 'thinness',
      desc: '',
      args: [],
    );
  }

  /// `normal`
  String get normal {
    return Intl.message(
      'normal',
      name: 'normal',
      desc: '',
      args: [],
    );
  }

  /// `overweight`
  String get overweight {
    return Intl.message(
      'overweight',
      name: 'overweight',
      desc: '',
      args: [],
    );
  }

  /// `obese class I`
  String get obese_class_I {
    return Intl.message(
      'obese class I',
      name: 'obese_class_I',
      desc: '',
      args: [],
    );
  }

  /// `obese class II`
  String get obese_class_II {
    return Intl.message(
      'obese class II',
      name: 'obese_class_II',
      desc: '',
      args: [],
    );
  }

  /// `obese class III`
  String get obese_class_III {
    return Intl.message(
      'obese class III',
      name: 'obese_class_III',
      desc: '',
      args: [],
    );
  }

  /// `-----------------------------Medic-----------------------------`
  String get _Medic {
    return Intl.message(
      '-----------------------------Medic-----------------------------',
      name: '_Medic',
      desc: '',
      args: [],
    );
  }

  /// `Records`
  String get Record {
    return Intl.message(
      'Records',
      name: 'Record',
      desc: '',
      args: [],
    );
  }

  /// `Medic records`
  String get Medic_record {
    return Intl.message(
      'Medic records',
      name: 'Medic_record',
      desc: '',
      args: [],
    );
  }

  /// `Medical records`
  String get Medical_record {
    return Intl.message(
      'Medical records',
      name: 'Medical_record',
      desc: '',
      args: [],
    );
  }

  /// `Medical record detail`
  String get Medical_record_detail {
    return Intl.message(
      'Medical record detail',
      name: 'Medical_record_detail',
      desc: '',
      args: [],
    );
  }

  /// `Add medical record`
  String get Add_medical_record {
    return Intl.message(
      'Add medical record',
      name: 'Add_medical_record',
      desc: '',
      args: [],
    );
  }

  /// `Update medical record`
  String get Update_medical_record {
    return Intl.message(
      'Update medical record',
      name: 'Update_medical_record',
      desc: '',
      args: [],
    );
  }

  /// `Medical history`
  String get Medical_history {
    return Intl.message(
      'Medical history',
      name: 'Medical_history',
      desc: '',
      args: [],
    );
  }

  /// `Medical appointments`
  String get Medical_appointment {
    return Intl.message(
      'Medical appointments',
      name: 'Medical_appointment',
      desc: '',
      args: [],
    );
  }

  /// `Medicine`
  String get Medicine {
    return Intl.message(
      'Medicine',
      name: 'Medicine',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Box Management`
  String get Medicine_box_management {
    return Intl.message(
      'Medicine Box Management',
      name: 'Medicine_box_management',
      desc: '',
      args: [],
    );
  }

  /// `Add a new medicine box`
  String get Add_medicine_box {
    return Intl.message(
      'Add a new medicine box',
      name: 'Add_medicine_box',
      desc: '',
      args: [],
    );
  }

  /// `Add a medicine`
  String get Add_medicine {
    return Intl.message(
      'Add a medicine',
      name: 'Add_medicine',
      desc: '',
      args: [],
    );
  }

  /// `Update medicine`
  String get Update_medicine {
    return Intl.message(
      'Update medicine',
      name: 'Update_medicine',
      desc: '',
      args: [],
    );
  }

  /// `Delete medicine`
  String get Delete_medicine {
    return Intl.message(
      'Delete medicine',
      name: 'Delete_medicine',
      desc: '',
      args: [],
    );
  }

  /// `Medical directory`
  String get Medical_directory {
    return Intl.message(
      'Medical directory',
      name: 'Medical_directory',
      desc: '',
      args: [],
    );
  }

  /// `Doctor directory`
  String get Doctor_directory {
    return Intl.message(
      'Doctor directory',
      name: 'Doctor_directory',
      desc: '',
      args: [],
    );
  }

  /// `You have no medical records`
  String get no_medical_record {
    return Intl.message(
      'You have no medical records',
      name: 'no_medical_record',
      desc: '',
      args: [],
    );
  }

  /// `Number of record`
  String get Number_of_record {
    return Intl.message(
      'Number of record',
      name: 'Number_of_record',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get Previous_medical_record {
    return Intl.message(
      'Previous',
      name: 'Previous_medical_record',
      desc: '',
      args: [],
    );
  }

  /// `You have not added any data for this section`
  String get no_section_data {
    return Intl.message(
      'You have not added any data for this section',
      name: 'no_section_data',
      desc: '',
      args: [],
    );
  }

  /// `Record name`
  String get Record_name {
    return Intl.message(
      'Record name',
      name: 'Record_name',
      desc: '',
      args: [],
    );
  }

  /// `Sick`
  String get Hint_record_name {
    return Intl.message(
      'Sick',
      name: 'Hint_record_name',
      desc: '',
      args: [],
    );
  }

  /// `Re-check the disease`
  String get Hint_re_examination {
    return Intl.message(
      'Re-check the disease',
      name: 'Hint_re_examination',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get Medical_location {
    return Intl.message(
      'Location',
      name: 'Medical_location',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get Medical_date {
    return Intl.message(
      'Date',
      name: 'Medical_date',
      desc: '',
      args: [],
    );
  }

  /// `Test`
  String get Medical_test {
    return Intl.message(
      'Test',
      name: 'Medical_test',
      desc: '',
      args: [],
    );
  }

  /// `Diagnose`
  String get Diagnose {
    return Intl.message(
      'Diagnose',
      name: 'Diagnose',
      desc: '',
      args: [],
    );
  }

  /// `Prescription`
  String get Prescription {
    return Intl.message(
      'Prescription',
      name: 'Prescription',
      desc: '',
      args: [],
    );
  }

  /// `Re-examination`
  String get Re_examination {
    return Intl.message(
      'Re-examination',
      name: 'Re_examination',
      desc: '',
      args: [],
    );
  }

  /// `Usage`
  String get Usage {
    return Intl.message(
      'Usage',
      name: 'Usage',
      desc: '',
      args: [],
    );
  }

  /// `Choose medicine`
  String get Choose_medicine {
    return Intl.message(
      'Choose medicine',
      name: 'Choose_medicine',
      desc: '',
      args: [],
    );
  }

  /// `Dosage`
  String get Dosage {
    return Intl.message(
      'Dosage',
      name: 'Dosage',
      desc: '',
      args: [],
    );
  }

  /// `Hospital Information`
  String get Hospital_info {
    return Intl.message(
      'Hospital Information',
      name: 'Hospital_info',
      desc: '',
      args: [],
    );
  }

  /// `-----------------------------Medicine-----------------------------`
  String get _Medicine {
    return Intl.message(
      '-----------------------------Medicine-----------------------------',
      name: '_Medicine',
      desc: '',
      args: [],
    );
  }

  /// `pill`
  String get pill {
    return Intl.message(
      'pill',
      name: 'pill',
      desc: '',
      args: [],
    );
  }

  /// `phial`
  String get phial {
    return Intl.message(
      'phial',
      name: 'phial',
      desc: '',
      args: [],
    );
  }

  /// `pack`
  String get pack {
    return Intl.message(
      'pack',
      name: 'pack',
      desc: '',
      args: [],
    );
  }

  /// `Drink`
  String get drink {
    return Intl.message(
      'Drink',
      name: 'drink',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Chew`
  String get chew {
    return Intl.message(
      'Chew',
      name: 'chew',
      desc: '',
      args: [],
    );
  }

  /// `Inject`
  String get inject {
    return Intl.message(
      'Inject',
      name: 'inject',
      desc: '',
      args: [],
    );
  }

  /// `Drops`
  String get drops {
    return Intl.message(
      'Drops',
      name: 'drops',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get daily {
    return Intl.message(
      'Daily',
      name: 'daily',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get weekly {
    return Intl.message(
      'Weekly',
      name: 'weekly',
      desc: '',
      args: [],
    );
  }

  /// `Once every `
  String get custom_repeat_left {
    return Intl.message(
      'Once every ',
      name: 'custom_repeat_left',
      desc: '',
      args: [],
    );
  }

  /// ` days`
  String get custom_day_repeat_right {
    return Intl.message(
      ' days',
      name: 'custom_day_repeat_right',
      desc: '',
      args: [],
    );
  }

  /// ` weeks`
  String get custom_week_repeat_right {
    return Intl.message(
      ' weeks',
      name: 'custom_week_repeat_right',
      desc: '',
      args: [],
    );
  }

  /// `Every few days`
  String get Every_few_days {
    return Intl.message(
      'Every few days',
      name: 'Every_few_days',
      desc: '',
      args: [],
    );
  }

  /// `Customized by week`
  String get Customized_by_week {
    return Intl.message(
      'Customized by week',
      name: 'Customized_by_week',
      desc: '',
      args: [],
    );
  }

  /// `Add a customized dose`
  String get Add_customized_dose {
    return Intl.message(
      'Add a customized dose',
      name: 'Add_customized_dose',
      desc: '',
      args: [],
    );
  }

  /// `Other (Fill in the note)`
  String get other_repeat {
    return Intl.message(
      'Other (Fill in the note)',
      name: 'other_repeat',
      desc: '',
      args: [],
    );
  }

  /// `Medicine box name`
  String get Medicine_box_name {
    return Intl.message(
      'Medicine box name',
      name: 'Medicine_box_name',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Hint_medicine_box {
    return Intl.message(
      'Home',
      name: 'Hint_medicine_box',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get Done_medicine_box {
    return Intl.message(
      'Done',
      name: 'Done_medicine_box',
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

  /// `YES`
  String get button_yes {
    return Intl.message(
      'YES',
      name: 'button_yes',
      desc: '',
      args: [],
    );
  }

  /// `NO`
  String get button_no {
    return Intl.message(
      'NO',
      name: 'button_no',
      desc: '',
      args: [],
    );
  }

  /// `DONE`
  String get button_done {
    return Intl.message(
      'DONE',
      name: 'button_done',
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

  /// `Are you sure you want to delete this photo?`
  String get Warning_delete_photo {
    return Intl.message(
      'Are you sure you want to delete this photo?',
      name: 'Warning_delete_photo',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this record?`
  String get Warning_cancel_record {
    return Intl.message(
      'Are you sure you want to cancel this record?',
      name: 'Warning_cancel_record',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this record?`
  String get Warning_delete_record {
    return Intl.message(
      'Are you sure you want to delete this record?',
      name: 'Warning_delete_record',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this medicine?`
  String get Warning_delete_medicine {
    return Intl.message(
      'Are you sure you want to delete this medicine?',
      name: 'Warning_delete_medicine',
      desc: '',
      args: [],
    );
  }

  /// `Add photo`
  String get Add_photo {
    return Intl.message(
      'Add photo',
      name: 'Add_photo',
      desc: '',
      args: [],
    );
  }

  /// `Delete photo`
  String get Delete_photo {
    return Intl.message(
      'Delete photo',
      name: 'Delete_photo',
      desc: '',
      args: [],
    );
  }

  /// `Pick Gallery`
  String get Pick_gallery {
    return Intl.message(
      'Pick Gallery',
      name: 'Pick_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Pick Camera`
  String get Pick_camera {
    return Intl.message(
      'Pick Camera',
      name: 'Pick_camera',
      desc: '',
      args: [],
    );
  }

  /// `Add record`
  String get Add_record {
    return Intl.message(
      'Add record',
      name: 'Add_record',
      desc: '',
      args: [],
    );
  }

  /// `Delete record`
  String get Delete_record {
    return Intl.message(
      'Delete record',
      name: 'Delete_record',
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

  /// `Wrong email or password!`
  String get Wrong_email_or_password {
    return Intl.message(
      'Wrong email or password!',
      name: 'Wrong_email_or_password',
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

  /// `Cannot connect to server! Please check your network connection and try again`
  String get Cannot_connect {
    return Intl.message(
      'Cannot connect to server! Please check your network connection and try again',
      name: 'Cannot_connect',
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

  /// `Time`
  String get Time {
    return Intl.message(
      'Time',
      name: 'Time',
      desc: '',
      args: [],
    );
  }

  /// `Latest`
  String get Latest {
    return Intl.message(
      'Latest',
      name: 'Latest',
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

  /// `January`
  String get January {
    return Intl.message(
      'January',
      name: 'January',
      desc: '',
      args: [],
    );
  }

  /// `February`
  String get February {
    return Intl.message(
      'February',
      name: 'February',
      desc: '',
      args: [],
    );
  }

  /// `March`
  String get March {
    return Intl.message(
      'March',
      name: 'March',
      desc: '',
      args: [],
    );
  }

  /// `April`
  String get April {
    return Intl.message(
      'April',
      name: 'April',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get May {
    return Intl.message(
      'May',
      name: 'May',
      desc: '',
      args: [],
    );
  }

  /// `June`
  String get June {
    return Intl.message(
      'June',
      name: 'June',
      desc: '',
      args: [],
    );
  }

  /// `July`
  String get July {
    return Intl.message(
      'July',
      name: 'July',
      desc: '',
      args: [],
    );
  }

  /// `August`
  String get August {
    return Intl.message(
      'August',
      name: 'August',
      desc: '',
      args: [],
    );
  }

  /// `September`
  String get September {
    return Intl.message(
      'September',
      name: 'September',
      desc: '',
      args: [],
    );
  }

  /// `October`
  String get October {
    return Intl.message(
      'October',
      name: 'October',
      desc: '',
      args: [],
    );
  }

  /// `November`
  String get November {
    return Intl.message(
      'November',
      name: 'November',
      desc: '',
      args: [],
    );
  }

  /// `December`
  String get December {
    return Intl.message(
      'December',
      name: 'December',
      desc: '',
      args: [],
    );
  }

  /// `mon`
  String get mon {
    return Intl.message(
      'mon',
      name: 'mon',
      desc: '',
      args: [],
    );
  }

  /// `tue`
  String get tue {
    return Intl.message(
      'tue',
      name: 'tue',
      desc: '',
      args: [],
    );
  }

  /// `wed`
  String get wed {
    return Intl.message(
      'wed',
      name: 'wed',
      desc: '',
      args: [],
    );
  }

  /// `thu`
  String get thu {
    return Intl.message(
      'thu',
      name: 'thu',
      desc: '',
      args: [],
    );
  }

  /// `fri`
  String get fri {
    return Intl.message(
      'fri',
      name: 'fri',
      desc: '',
      args: [],
    );
  }

  /// `sat`
  String get sat {
    return Intl.message(
      'sat',
      name: 'sat',
      desc: '',
      args: [],
    );
  }

  /// `sun`
  String get sun {
    return Intl.message(
      'sun',
      name: 'sun',
      desc: '',
      args: [],
    );
  }

  /// `morning`
  String get morning {
    return Intl.message(
      'morning',
      name: 'morning',
      desc: '',
      args: [],
    );
  }

  /// `noon`
  String get noon {
    return Intl.message(
      'noon',
      name: 'noon',
      desc: '',
      args: [],
    );
  }

  /// `afternoon`
  String get afternoon {
    return Intl.message(
      'afternoon',
      name: 'afternoon',
      desc: '',
      args: [],
    );
  }

  /// `night`
  String get night {
    return Intl.message(
      'night',
      name: 'night',
      desc: '',
      args: [],
    );
  }

  /// `day`
  String get day {
    return Intl.message(
      'day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Repeat after`
  String get Repeat_after {
    return Intl.message(
      'Repeat after',
      name: 'Repeat_after',
      desc: '',
      args: [],
    );
  }

  /// `Choose one or more days`
  String get Choose_one_or_more_days {
    return Intl.message(
      'Choose one or more days',
      name: 'Choose_one_or_more_days',
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
