import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:anthealth_mobile/services/message/message_define.dart';
import 'package:flutter/cupertino.dart';

class Client {
  Socket? socket;
  String host;
  int port;
  String? _data;

  Client(this.host, this.port);

  void connect() {
    Socket.connect(host, port).then((Socket sock) {
      socket = sock;
      socket?.listen(dataHandler,
          onError: _errorHandler, onDone: _doneHandler, cancelOnError: false);
    }).catchError((e) {
      debugPrint("can not connect to server: " + e.toString());
      exit(0);
    });
  }

  /// Server
  void send(int msgID, dynamic msgData) {
    var m = SMessage(msgID, msgData.toString());
    socket?.add(m.toByteBuf());
  }

  /// Socket listener
  void dataHandler(data) {
    Uint8List bdata = data as Uint8List;
    RMessage rMessage = RMessage(bdata);
    _data = rMessage.toString();
  }

  void _errorHandler(error, StackTrace trace) {
    debugPrint(error);
    socket?.close();
    exit(0);
  }

  void _doneHandler() {
    debugPrint("Disconnected to server $host:$port");
  }

  /// Handle data
  Future<String> getData({int? waitSeconds}) async {
    var tempData = "null";
    await waitData(0, waitSeconds);
    if (_data == null) debugPrint("NULL DATA!");
    tempData = _data.toString();
    removeData();
    return tempData;
  }

  Future<void> waitData(int count, [int? waitSeconds]) async {
    /// Wait 0.1x50 = 5s (default)
    int times = (waitSeconds ?? 5) * 10;
    await Future.delayed(const Duration(milliseconds: 100));
    if (_data == null && count < times) await waitData(count + 1, waitSeconds);
  }

  void removeData() {
    _data = null;
  }
}
