import 'package:anthealth_mobile/blocs/authentication/authetication_states.dart';
import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:anthealth_mobile/models/authentication/authentication_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationCubit extends Cubit<CubitState> {
  AuthenticationCubit() : super(InitialState()) {
    startAuthentication();
  }

  void startAuthentication() async {
    LoginData loginData = LoginData("", "");
    await getLocalUsername().then((username) {
      loginData.username = username ?? "";
    });
    login(loginData);
  }

  /// Handle States
  void login(LoginData loginData) {
    emit(LoginState(loginData));
  }

  void register(RegisterData registerData) {
    emit(RegisterState(registerData));
  }

  void forgotPassword() {
    emit(ForgotPasswordState());
  }

  Future<void> intentToLogin(LoginData loginData) async {
    await Future.delayed(const Duration(milliseconds: 100), () => {});
    login(loginData);
  }

  /// Service Function
  Future<dynamic> getToken(LoginData data) async {
    var token = "";
    await CommonService.instance
        .send(MessageIDPath.getToken(), LoginData.getStringObject(data));
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(MessageIDPath.getToken(), value)) {
        token = ServerLogic.getData(value)["token"];
      }
    });
    if (token == "") return null;
    return token;
  }

  Future<int> registerAccount(RegisterData data) async {
    var result = 2;
    await CommonService.instance
        .send(MessageIDPath.register(), RegisterData.getStringObject(data));
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(MessageIDPath.register(), value))
        result = ServerLogic.getData(value)["result"];
    });
    return result.toInt();
  }

  /// Local Storage
  Future<dynamic> getLocalUsername() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    return username;
  }
}
