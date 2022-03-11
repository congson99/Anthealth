import 'package:anthealth_mobile/blocs/app_state.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCubit extends Cubit<CubitState> {
  AppCubit() : super(InitialState()) {
    fakeLoading().whenComplete(() => checkCurrentToken());
  }

  // Fake loading
  Future<void> fakeLoading() {
    return Future.delayed(
        const Duration(seconds: 2), () => print('Loading complete!'));
  }

  // Initial State
  unAuthenticate() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      await prefs.remove('token');
      print('Remove token successful!');
    }
    emit(UnauthenticatedState());
  }

  authenticated(String token) {
    emit(AuthenticatedState(token));
  }

  // Local Storage
  Future<void> checkCurrentToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null && checkToken(token))
      authenticated(token);
    else
      unAuthenticate();
  }

  // Authenticate Function
  authenticate(String token, String username) async {
    var msg = {
      "account": "ttvucse@gmail.com",
      "password": '"123456"',
      "name": "Trần Tiến Vũ"
    };
    CommonService.instance.send(2110, msg.toString());
    CommonService.instance.client!.getData().then((value) => print(value));
    // if (checkToken(token)) {
    //   final prefs = await SharedPreferences.getInstance();
    //   await prefs.setString('token', token);
    //   await prefs.setString('username', username);
    //   authenticated(token);
    // } else
    //   unAuthenticate();
  }

  // Service Function
  bool checkToken(String token) {
    //Todo: check token
    if (token == 'token')
      return true;
    else
      return false;
  }
}
