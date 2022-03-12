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
  AuthenticatedState(this.token);

  final String token;

  @override
  // TODO: implement props
  List<Object> get props => [token];
}

class UnauthenticatedState extends CubitState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
