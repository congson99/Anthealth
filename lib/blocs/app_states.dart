import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:equatable/equatable.dart';

abstract class CubitState extends Equatable {}

class InitialState extends CubitState {
  @override
  List<Object> get props => [];
}

class ConnectErrorState extends CubitState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends CubitState {
  AuthenticatedState(this.token, this.user);

  final String token;
  final User user;

  @override
  List<Object> get props => [token, user];
}

class UnauthenticatedState extends CubitState {
  @override
  List<Object> get props => [];
}
