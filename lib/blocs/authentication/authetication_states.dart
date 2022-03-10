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
  RegisterState(this.name, this.username, this.password, this.confirmPassword);

  final String name;
  final String username;
  final String password;
  final String confirmPassword;

  @override
  // TODO: implement props
  List<Object> get props => [name, username, password, confirmPassword];
}

class ForgotPasswordState extends CubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
