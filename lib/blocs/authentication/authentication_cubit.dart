import 'package:anthealth_mobile/blocs/authentication/authetication_states.dart';
import 'package:anthealth_mobile/blocs/app_state.dart';
import 'package:anthealth_mobile/blocs/common_logic/server_logic.dart';
import 'package:anthealth_mobile/models/authentication/authentication_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationCubit extends Cubit<CubitState> {
  AuthenticationCubit() : super(InitialState()) {
    checkCurrentUsername();
  }

  // Initial State
  void login(LoginData loginData) {
    emit(LoginState(loginData));
  }

  void register() {
    emit(RegisterState('', '', '', ''));
  }

  void forgotPassword() {
    emit(ForgotPasswordState());
  }

  // Update state
  void updateLoginState(LoginData loginData) {
    emit(LoginState(loginData));
  }

  void updateRegisterState(
      String name, String username, String password, String confirmPassword) {
    emit(RegisterState(name, username, password, confirmPassword));
  }

  Future<void> intentLogin(LoginData loginData) async {
    await SharedPreferences.getInstance();
    login(loginData);
  }

  // Local Storage
  Future<void> checkCurrentUsername() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    if (username == null) username = '';
    login(LoginData(username, ''));
  }

  // Service Function
  Future<String> getToken(LoginData data) async {
    var token = "null";
    await CommonService.instance.send(MessageIDPath.getToken(),
        LoginData.getStringObject(data));
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(MessageIDPath.getToken(), value)) {
        if (ServerLogic.getData(value)["token"] != "")
          token = ServerLogic.getData(value)["token"];
      }
    });
    return token;
  }

  bool checkRegisteredAccount(String username) {
    //Todo: check registered account
    if (username == 'congson99vn@gmail.com') return false;
    return true;
  }

  bool registerAccount(String name, String username, String password) {
    //Todo: register account
    if (username == 'congson99vn@gmail.com') {
      checkCurrentUsername();
      return true;
    }
    return false;
  }
}
