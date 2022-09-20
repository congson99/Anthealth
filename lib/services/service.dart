import 'dart:convert';

import 'package:anthealth_mobile/services/client.dart';
import 'package:anthealth_mobile/services/http/http_service.dart';

class CommonService {
  Client? client;

  ///send message to server
  Future<void> send(int msgID, Map<String, dynamic> msgData) async {
    if (client == null) {
      _tryConnectServer();
      await Future.delayed(const Duration(seconds: 1), () {});
    }
    if (msgID != 100) client?.send(100, jsonEncode({}));
    await Future.delayed(Duration(milliseconds: 100));
    client?.send(msgID, jsonEncode(msgData));
  }

  void _tryConnectServer() {
    var serverInfo = HttpService.instance.getServerInfo();
    client = Client(serverInfo['host'], serverInfo['port']);
    client?.connect();
  }

  /// create a singleton for CommonService
  static CommonService? _instance;

  CommonService._();

  static CommonService get instance => _instance ??= CommonService._();
}
