import 'package:anthealth_mobile/blocs/app_state.dart';

class LoginState extends CubitState {
  LoginState(this.username, this.password);

  final String username;
  final String password;

  @override
  // TODO: implement props
  List<Object> get props => [username, password];
}

class RegisterState extends CubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ForgotPasswordState extends CubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
