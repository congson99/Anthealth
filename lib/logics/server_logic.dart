import 'dart:convert';

class ServerLogic {
  static bool checkMatchMessageID(int id, String data) {
    if (data == '{"msgID":0,"msgData":}') return false;
    dynamic jData = jsonDecode(data);
    return (jData["msgID"] == id);
  }

  static dynamic getData(String data) => jsonDecode(data)["msgData"];

  static List<dynamic> formatList(String data) => jsonDecode(data);
}
