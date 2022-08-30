import 'dart:io';
import 'dart:typed_data';

import 'package:anthealth_mobile/services/client.dart';
import 'package:anthealth_mobile/services/http/http_service.dart';


class CommonService {
  Client? client;

  ///send message to server
  Future<void> send(int msgID, String msgData) async {
    if (client == null) {
      _tryConnectServer();
      await Future.delayed(const Duration(seconds: 1), () {});
    }
    client?.send(msgID, msgData);
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
