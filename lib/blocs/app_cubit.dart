import 'package:anthealth_mobile/blocs/app_state.dart';
import 'package:anthealth_mobile/blocs/common_logic/server_logic.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCubit extends Cubit<CubitState> {
  AppCubit() : super(InitialState()) {
    checkConnect();
  }

  // Initial State
  connectError() {
    emit(ConnectErrorState());
  }

  unAuthenticate() async {
    removeToken();
    emit(UnauthenticatedState());
  }

  authenticated(String token) {
    emit(AuthenticatedState(token));
  }

  // Local Storage
  Future<void> checkCurrentToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null)
      authenticate(token);
    else
      unAuthenticate();
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      await prefs.remove('token');
      print('Remove token successful!');
    }
  }

  // Authenticate Function
  authenticate(String token) async {
    checkToken(token).then((value) {
      if (value)
        authenticated(token);
      else
        unAuthenticate();
    });
  }

  // Service Function
  Future<void> checkConnect() async {
    await CommonService.instance.send(MessageIDPath.checkConnect(), "");
    CommonService.instance.client!.getData().then((value) {
      if (value == "null")
        connectError();
      else
        checkCurrentToken();
    });
  }

  Future<bool> checkToken(String token) async {
    var valid = false;
    var data = {"token": token};
    await CommonService.instance
        .send(MessageIDPath.checkToken(), data.toString());
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(MessageIDPath.checkToken(), value)) {
        valid = ServerLogic.getData(value)["valid"];
      }
    });
    return valid;
  }
}
