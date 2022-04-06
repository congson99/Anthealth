import 'dart:convert';

class ServerLogic {
  static bool checkMatchMessageID(int id, String data) {
    dynamic jData = jsonDecode(data);
    return (jData["msgID"] == id);
  }

  static dynamic getData(String data) => jsonDecode(data)["msgData"];

  static List<dynamic> formatList(String data) => jsonDecode(data);
}