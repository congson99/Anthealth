import 'package:anthealth_mobile/blocs/app_state.dart';
import 'package:anthealth_mobile/models/authentication/authentication_models.dart';

class LoginState extends CubitState {
  LoginState(this.loginData);

  final LoginData loginData;

  @override
  // TODO: implement props
  List<Object> get props => [loginData];
}

class RegisterState extends CubitState {
  RegisterState(this.registerData);

  final RegisterData registerData;

  @override
  // TODO: implement props
  List<Object> get props => [registerData];
}

class ForgotPasswordState extends CubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
