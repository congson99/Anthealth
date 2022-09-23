import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:anthealth_mobile/services/message/message_define.dart';
import 'package:flutter/cupertino.dart';

class Client {
  Socket? socket;
  String host;
  int port;
  String? _data;
  List<int> tmpBufList;
  int totalRecv = 0;

  Client(this.host, this.port, this.tmpBufList);

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
    debugPrint("---------- Send \"$msgID\" successful ----------");
  }

  /// Socket listener
  void dataHandler(data) {
    Uint8List bdata = data as Uint8List;
    if (totalRecv == 0) {
      totalRecv = ByteData.view(bdata.buffer).getInt32(0) >>
          2; // lấy kích thước dữ liệu
    }
    tmpBufList.addAll(bdata.toList());
    Uint8List tmpBuf = Uint8List.fromList(tmpBufList);
    if (tmpBuf.lengthInBytes >= totalRecv) {
      RMessage rMessage = RMessage(tmpBuf);
      _data = rMessage.toString();
      tmpBufList.clear();
      totalRecv = 0;
    }
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
    if (_data == null) {
      debugPrint("NULL DATA!");
      return tempData;
    }
    tempData = _data.toString();
    removeData();
    debugPrint("---------- Get \"${ServerLogic.getMsg(tempData)}\" successful ----------");
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
