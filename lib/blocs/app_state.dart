import 'package:equatable/equatable.dart';

abstract class CubitState extends Equatable {}

class InitialState extends CubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ConnectErrorState extends CubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthenticatedState extends CubitState {
  AuthenticatedState(this.token, this.name, this.avatarPath);

  final String token;
  final String name;
  final String avatarPath;

  @override
  // TODO: implement props
  List<Object> get props => [token, name, avatarPath];
}

class UnauthenticatedState extends CubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
