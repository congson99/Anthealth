import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:anthealth_mobile/services/message/message_define.dart';

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
      print("can not connect to server: " + e);
      exit(0);
    });
  }

  // Server
  void send(int msgID, dynamic msgData) {
    var m = SMessage(msgID, msgData.toString());
    socket?.add(m.toByteBuf());
  }

  // Socket listener
  void dataHandler(data) {
    Uint8List bdata = data as Uint8List;
    RMessage rMessage = RMessage(bdata);
    _data = rMessage.toString();
  }

  void _errorHandler(error, StackTrace trace) {
    print(error);
    socket?.close();
    exit(0);
  }

  void _doneHandler() {
    print("Disconnected to server ${host}:${port}");
  }

  // Handle data
  Future<String> getData() async {
    var tempData = "null";
    await waitData(0);
    if (_data == null) print("NULL DATA!");
    tempData = _data.toString();
    removeData();
    return tempData;
  }

  Future<void> waitData(int count) async {
    // wait 0.1s
    // Max: 0.1x50 = 5s
    await Future.delayed(const Duration(milliseconds: 100), () => {});
    if (_data == null && count < 50) await waitData(count + 1);
  }

  void removeData() {
    _data = null;
  }
}
