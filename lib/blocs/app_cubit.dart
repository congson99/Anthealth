import 'package:anthealth_mobile/blocs/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCubit extends Cubit<CubitState> {
  AppCubit() : super(InitialState()) {
    fakeLoading().whenComplete(() => checkCurrentToken());
  }

  authenticate(String token, String username) async {
    if (checkToken(token)) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('username', username);
      authenticated(token);
    } else
      unAuthenticate();
  }

  authenticated(String token) {
    emit(AuthenticatedState(token));
  }

  unAuthenticate() async {
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove('token');
    print('Remove token ' + (success ? 'successful!' : 'false!'));
    emit(UnauthenticatedState());
  }

  Future<void> fakeLoading() {
    return Future.delayed(const Duration(seconds: 2), () => print('Loading complete!'));
  }

  Future<void> checkCurrentToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null && checkToken(token))
      authenticated(token);
    else
      unAuthenticate();
  }

  bool checkToken(String token) {
    //Todo: check token
    if (token == 'token')
      return true;
    else
      return false;
  }
}
