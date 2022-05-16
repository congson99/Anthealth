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
  AuthenticatedState(this.token, this.user, this.languageID);

  final String token;
  final User user;
  final String languageID;

  @override
  List<Object> get props => [token, user, languageID];
}

class UnauthenticatedState extends CubitState {
  @override
  List<Object> get props => [];
}

class UpdateLanguageState extends CubitState {
  UpdateLanguageState(this.languageID);

  final String languageID;

  @override
  List<Object> get props => [languageID];
}
