import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/models/authentication/authentication_models.dart';

class LoginState extends CubitState {
  LoginState(this.loginData);

  final LoginData loginData;

  @override
  List<Object> get props => [loginData];
}

class RegisterState extends CubitState {
  RegisterState(this.registerData);

  final RegisterData registerData;

  @override
  List<Object> get props => [registerData];
}

class ForgotPasswordState extends CubitState {
  @override
  List<Object> get props => [];
}
