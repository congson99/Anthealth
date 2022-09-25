import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/logics/medicine_logic.dart';
import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:anthealth_mobile/models/notification/notification_service.dart';
import 'package:anthealth_mobile/models/notification/warning.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCubit extends Cubit<CubitState> {
  AppCubit() : super(InitialState()) {
    startApp();
  }

  void startApp() async {
    emit(InitialState());
    await Firebase.initializeApp();
    String token = "";
    await isConnect().then((isConnect) {
      if (!isConnect) {
        connectError();
        return;
      }
    });
    await getLocalToken().then((localToken) {
      if (localToken == null) {
        debugPrint("Null local token");
        unAuthenticated();
        return;
      }
      token = localToken;
    });
    if (token != "")
      checkToken(token).then((checkTokenResult) {
        if (!checkTokenResult) {
          debugPrint("Invalid token");
          unAuthenticated();
          return;
        }
        authenticated(token);
      });
  }

  /// Handle states
  void unAuthenticated() {
    emit(UnauthenticatedState());
  }

  void authenticated(String token, [String? languageID]) async {
    NotificationService notificationService = NotificationService();
    notificationService.initializePlatformNotifications();
    notificationService.clear();

    bool review = false;

    await CommonService.instance.send(999, {});
    await CommonService.instance.client!.getData(waitSeconds: 30).then((value) {
      if (ServerLogic.checkMatchMessageID(999, value)) {
        if (value != "null") {
          review = ServerLogic.getData(value)["test"];
        }
      }
    });
    DateTime now = DateTime.now();
    Map<String, dynamic> data = {
      "startTime": DateFormat("yyyy-MM-dd HH:mm:ss").format(now),
      "endTime": DateFormat("yyyy-MM-dd").format(now.add(Duration(days: 1))) +
          " 23:59:59"
    };
    await CommonService.instance
        .send(MessageIDPath.getDurationReminder(), data);
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getDurationReminder(), value)) {
        if (ServerLogic.getData(value) != null) {
          for (dynamic x in ServerLogic.getData(value)["data"]) {
            if (DateTime.fromMillisecondsSinceEpoch(x["time"] * 1000)
                    .difference(now)
                    .inSeconds >=
                0) {
              notificationService.showScheduledLocalNotification(
                  id: 1,
                  title: x["name"] +
                      " " +
                      x["need_amount"].toString() +
                      " " +
                      MedicineLogic.getUnitNoContext(int.parse(x["unit"])),
                  body: "",
                  payload: "",
                  seconds: DateTime.fromMillisecondsSinceEpoch(x["time"] * 1000)
                      .difference(now)
                      .inSeconds);
            }
          }
        }
      }
    });

    List<Warning> warning = [];
    await CommonService.instance.send(MessageIDPath.getFamilyWarning(), {});
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getFamilyWarning(), value)) {
        if (value != "null") {
          List<dynamic> data = ServerLogic.getData(value)["data"];
          for (Map<String, dynamic> x in data) {
            if (x["name"] != null) {
              int type = x["type"];
              String typeContent = (type == 2)
                  ? "Nhịp tim"
                  : ((type == 3)
                      ? "Nhiệt độ"
                      : ((type == 4) ? "Huyết áp" : ("Spo2")));
              notificationService.showLocalNotification(
                  id: 0,
                  title: " Cảnh báo " + typeContent + " của " + x["name"],
                  body: x["notice"],
                  payload: x["notice"]);
              warning.add(Warning(
                  x["uid"].toString(),
                  x["name"],
                  DateTime.fromMillisecondsSinceEpoch(x["time"] * 1000),
                  x["avatar"],
                  x["type"],
                  0.0 + x["value"],
                  x["notice"]));
            }
          }
        }
      }
    });
    await CommonService.instance.send(MessageIDPath.getUserBaseData(), {});
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getUserBaseData(), value)) {
        emit(AuthenticatedState(
            token,
            User(
                ServerLogic.getData(value)["uid"].toString(),
                ServerLogic.getData(value)["name"],
                ServerLogic.getData(value)["avatar"],
                ServerLogic.getData(value)["phone"],
                ServerLogic.getData(value)["email"],
                true,
                ServerLogic.getData(value)["birthday"],
                ServerLogic.getData(value)["sex"]),
            true,
            warning));
      }
    });
  }

  void login(String token, String username) async {
    checkToken(token).then((checkTokenResult) {
      if (checkTokenResult) {
        removeToken();
        saveUsername(username);
        authenticated(token);
        saveToken(token);
      } else
        unAuthenticated();
    });
  }

  void logout() async {
    await CommonService.instance.send(MessageIDPath.logout(), {});
    removeToken();
    emit(UnauthenticatedState());
  }

  void removeAccount() async {
    await CommonService.instance.send(MessageIDPath.removeAccount(), {});
    removeToken();
    emit(UnauthenticatedState());
  }

  Future<bool> outFamily() async {
    bool result = false;
    await CommonService.instance.send(MessageIDPath.outFamily(), {});
    await CommonService.instance.client!.getData().then((value) {
      if (value != "null") if (ServerLogic.checkMatchMessageID(
          MessageIDPath.outFamily(), value)) {
        result = ServerLogic.getData(value)["status"];
      }
    });
    return result;
  }

  Future<bool> updatePermission(String uid, List<bool> permissions) async {
    bool result = false;
    Map<String, dynamic> data = {"uid": uid, "permissions": permissions};
    await CommonService.instance.send(MessageIDPath.updatePermission(), data);
    await CommonService.instance.client!.getData().then((value) {
      if (value != "null") if (ServerLogic.checkMatchMessageID(
          MessageIDPath.updatePermission(), value)) {
        result = ServerLogic.getData(value)["status"];
      }
    });
    return result;
  }

  void connectError() {
    emit(ConnectErrorState());
  }

  Future<bool> updateProfile(
      User user, BuildContext context, String avatar) async {
    var data = {
      "avatar": avatar,
      "name": user.name,
      "phone": user.phoneNumber,
      "birthday": user.yOB,
      "sex": user.sex
    };
    bool valid = false;
    await CommonService.instance.send(MessageIDPath.updateProfile(), data);
    await CommonService.instance.client!.getData().then((value) {
      if (value == 'null') valid = false;
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.updateProfile(), value)) {
        valid = ServerLogic.getData(value)["status"];
      }
    });
    return valid;
  }

  /// Service Functions
  Future<bool> isConnect() async {
    bool result = false;
    await CommonService.instance.send(MessageIDPath.checkConnect(), {});
    await CommonService.instance.client!.getData(waitSeconds: 30).then((value) {
      if (value != "null") result = true;
    });
    return result;
  }

  Future<bool> checkToken(String token) async {
    bool valid = false;
    var sendData = {"token": token};
    await CommonService.instance.send(MessageIDPath.checkToken(), sendData);
    await CommonService.instance.client!.getData().then((value) {
      if (value == 'null') valid = false;
      if (ServerLogic.checkMatchMessageID(MessageIDPath.checkToken(), value)) {
        valid = ServerLogic.getData(value)["valid"];
      }
    });
    return valid;
  }

  /// Local Storage
  Future<dynamic> getLocalToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");
    return token;
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    debugPrint('Save token successful!');
  }

  Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    debugPrint('Save username successful!');
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      await prefs.remove('token');
      debugPrint('Remove token successful!');
    }
  }
}
