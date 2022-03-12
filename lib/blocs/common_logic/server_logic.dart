import 'dart:convert';

import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServerLogic {
  ServerLogic._();

  static bool checkMatchMessageID(int id, String data) {
    dynamic jData = jsonDecode(data);
    return (jData["msgID"] == id);
  }

  static dynamic getData(String data) => jsonDecode(data)["msgData"];
}
