import 'package:anthealth_mobile/blocs/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<CubitState> {
  AppCubit() : super(InitialState()) {
    authenticate('');
  }

  authenticate(String token) {
    if (checkToken(token))
      authenticated(token);
    else
      emit(UnauthenticatedState());
  }

  authenticated(String token) {
    emit(AuthenticatedState(token));
  }

  bool checkToken(String token) {
    //Todo: check token
    if (token == 'token')
      return true;
    else
      return false;
  }
}
