import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<CubitState> {
  LanguageCubit() : super(InitialState()) {
    start();
  }

  void start() async {
    await getLanguage().then((value) {
      emit(LanguageState(value));
    });
  }

  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? language = prefs.getString("language");
    return language ?? "vi";
  }

  void updateLanguage(String languageID, BuildContext context) async {
    emit(InitialState());
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", languageID);
    start();
  }
}

class LanguageState extends CubitState {
  LanguageState(this.language);

  final String language;

  @override
  List<Object> get props => [language];
}
