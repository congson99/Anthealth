import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
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

  Future<bool> updateProfile(User user, BuildContext context) async {
    print(user.name);
    var data = {
      "name": user.name,
      "phone": user.phoneNumber,
      "birthday": user.yOB
    };
    bool valid = false;
    await CommonService.instance
        .send(MessageIDPath.updateProfile(), data.toString());
    await CommonService.instance.client!.getData().then((value) {
      if (value == 'null') valid = false;
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.updateProfile(), value)) {
        valid = ServerLogic.getData(value)["status"];
        print(value);
        if (valid) {
          emit(InitialState());
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
          start();
        }
      }
    });
    return valid;
  }
}

class LanguageState extends CubitState {
  LanguageState(this.language);

  final String language;

  @override
  List<Object> get props => [language];
}
