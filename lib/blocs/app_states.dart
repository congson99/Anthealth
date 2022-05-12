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
  AuthenticatedState(this.token, this.id, this.name, this.avatarPath);

  final String token;
  final String id;
  final String name;
  final String avatarPath;

  @override
  List<Object> get props => [token, id, name, avatarPath];
}

class UnauthenticatedState extends CubitState {
  @override
  List<Object> get props => [];
}
