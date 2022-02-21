
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:convert';

import 'package:anthealth_mobile/services/message/message_define.dart';
class Client {
  Socket? socket;
  String host;
  int port;
  Client(this.host,this.port);

  void connect(){
    Socket.connect(host, port).then((Socket sock) {
      socket = sock;
      socket?.listen(dataHandler,
          onError: _errorHandler,
          onDone: _doneHandler,
          cancelOnError: false);
    }).catchError((AsyncError e) {
      print("can not connect to server");
      exit(0);
    });

    stdin.listen((data) {
      if(String.fromCharCodes(data).trim() == "exit"){
        _bye_server();
      }
      else{
        SMessage ?m;
        var sMSGID = String.fromCharCodes(data).trim();
        switch (sMSGID) {
          case "211":
            m = Test211();
            break;
          case "212":
            m = Test212();
            break;
          case "221":
            m = Test221();
            break;
          case "222":
            m = Test222();
            break;
          default:
        }
        socket?.add(m!.toByteBuf());
      }
    });
  }

  void send(int msgID, dynamic msgData){
    // print("msgData = ${msgData.toString()}");
    var m = SMessage(msgID,msgData.toString());
    socket?.add(m.toByteBuf());
  }

  void dataHandler(data){
    // print("in dataHandler data(${data.runtimeType})");
    Uint8List bdata = data as Uint8List;
    // print("lenght = ${bdata.lengthInBytes}");
    RMessage rMessage = RMessage(bdata);
    // print("Receive: ${rMessage.toString()}");
  }

  void _errorHandler(error, StackTrace trace){
    print(error);
    _bye_server();
  }

  void _doneHandler(){
    print("Disconnected to server ${host}:${port}");
  }
  void _bye_server(){
    socket?.close();
    exit(0);
  }
  ///đăng kí ng dùng mới
  SMessage Test211(){
    var j = {
      "account":"ttvucse@gmail.com",
      "password":'"123456"',
      "name":"Trần Tiến Vũ"
    };
    SMessage m = SMessage(2110,j.toString());
    return m;
  }

  ///đăng nhập
  SMessage Test212(){
    var j = {
      "account":"ttvucse@gmail.com",
      "password":'"123456"'
    };
    SMessage m = SMessage(2120,j.toString());
    return m;
  }

  ///thêm chỉ số
  SMessage Test221(){
    var j = {
      "type":1,
      "value":'"170"',
      "creator":10001
    };
    SMessage m = SMessage(2210,j.toString());
    return m;
  }

  ///lấy thông tin chỉ số
  SMessage Test222(){
    var j = {
      "type":1,
      "start_time":DateTime.now().millisecondsSinceEpoch - 5*24*3600,
      "end_time":DateTime.now().millisecondsSinceEpoch
    };
    SMessage m = SMessage(2220,j.toString());
    return m;
  }
}
