import 'package:anthealth_mobile/blocs/authentication/authetication_states.dart';
import 'package:anthealth_mobile/blocs/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationCubit extends Cubit<CubitState> {
  AuthenticationCubit() : super(InitialState()) {
    login('', '');
  }

  void login(String username, String password) {
    emit(LoginState(username, password));
  }

  void register() {
    emit(RegisterState());
  }

  void forgotPassword() {
    emit(ForgotPasswordState());
  }

  void updateLoginState(String username, String password) {
    emit(LoginState(username, password));
  }

  String getToken(String username, String password) {
    //Todo: authentication and get token
    if (username == 'congson99vn@gmail.com' && password == '12345678') return "token";
    return "null";
  }
}
