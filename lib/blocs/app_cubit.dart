import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCubit extends Cubit<CubitState> {
  AppCubit() : super(InitialState()) {
    startApp();
  }

  void startApp() async {
    emit(InitialState());
    await Firebase.initializeApp();
    String token = "";
    await isConnect().then((isConnect) {
      if (!isConnect) {
        connectError();
        return;
      }
    });
    await getLocalToken().then((localToken) {
      if (localToken == null) {
        unAuthenticated();
        return;
      }
      token = localToken;
    });
    checkToken(token).then((checkTokenResult) {
      if (!checkTokenResult) {
        unAuthenticated();
        return;
      }
      authenticated(token);
    });
  }

  /// Handle states
  void unAuthenticated() {
    emit(UnauthenticatedState());
  }

  void authenticated(String token, [String? languageID]) async {
    await CommonService.instance.send(MessageIDPath.getUserBaseData(), {});
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getUserBaseData(), value)) {
        emit(AuthenticatedState(
            token,
            User(
                "123",
                ServerLogic.getData(value)["name"],
                ServerLogic.getData(value)["avatar"],
                ServerLogic.getData(value)["phone"],
                ServerLogic.getData(value)["email"],
                true,
                ServerLogic.getData(value)["birthday"],
                ServerLogic.getData(value)["sex"])));
      }
    });
  }

  void login(String token, String username) async {
    checkToken(token).then((checkTokenResult) {
      if (checkTokenResult) {
        removeToken();
        saveUsername(username);
        authenticated(token);
        saveToken(token);
      } else
        unAuthenticated();
    });
  }

  void logout() async {
    await CommonService.instance.send(MessageIDPath.logout(), {});
    removeToken();
    emit(UnauthenticatedState());
  }

  void removeAccount() async {
    await CommonService.instance.send(MessageIDPath.removeAccount(), {});
    removeToken();
    emit(UnauthenticatedState());
  }

  void connectError() {
    emit(ConnectErrorState());
  }

  Future<bool> updateProfile(User user, BuildContext context) async {
    var data = {
      "name": user.name,
      "phone": user.phoneNumber,
      "birthday": user.yOB
    };
    bool valid = false;
    await CommonService.instance.send(MessageIDPath.updateProfile(), data);
    await CommonService.instance.client!.getData().then((value) {
      if (value == 'null') valid = false;
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.updateProfile(), value)) {
        valid = ServerLogic.getData(value)["status"];
      }
    });
    return valid;
  }

  /// Service Functions
  Future<bool> isConnect() async {
    bool result = false;
    await CommonService.instance.send(MessageIDPath.checkConnect(), {});
    await CommonService.instance.client!.getData(waitSeconds: 30).then((value) {
      if (value != "null") result = true;
    });
    return result;
  }

  Future<bool> checkToken(String token) async {
    bool valid = false;
    var sendData = {"token": token};
    await CommonService.instance.send(MessageIDPath.checkToken(), sendData);
    await CommonService.instance.client!.getData().then((value) {
      if (value == 'null') valid = false;
      if (ServerLogic.checkMatchMessageID(MessageIDPath.checkToken(), value)) {
        valid = ServerLogic.getData(value)["valid"];
      }
    });
    return valid;
  }

  /// Local Storage
  Future<dynamic> getLocalToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");
    return token;
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print('Save token successful!');
  }

  Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    print('Save username successful!');
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      await prefs.remove('token');
      print('Remove token successful!');
    }
  }
}
