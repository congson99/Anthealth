import 'package:anthealth_mobile/blocs/authentication/authetication_states.dart';
import 'package:anthealth_mobile/blocs/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationCubit extends Cubit<CubitState> {
  AuthenticationCubit() : super(InitialState()) {
    checkCurrentUsername();
  }

  // Initial State
  void login(String username, String password) {
    emit(LoginState(username, password));
  }

  void register() {
    emit(RegisterState('', '', '', ''));
  }

  void forgotPassword() {
    emit(ForgotPasswordState());
  }

  // Update state
  void updateLoginState(String username, String password) {
    emit(LoginState(username, password));
  }

  void updateRegisterState(
      String name, String username, String password, String confirmPassword) {
    emit(RegisterState(name, username, password, confirmPassword));
  }

  Future<void> intentLogin(String username, String password) async {
    await SharedPreferences.getInstance();
    login(username, password);
  }

  // Local Storage
  Future<void> checkCurrentUsername() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    if (username == null) username = '';
    login(username, '');
  }

  // Service Function
  String getToken(String username, String password) {
    //Todo: authentication and get token
    if (username == 'congson99vn@gmail.com' && password == '12345678')
      return "token";
    return "null";
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
