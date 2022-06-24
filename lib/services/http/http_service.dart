import 'dart:convert';
import 'package:http/http.dart';

class HttpService {
  /// điều chỉnh host về đúng địa chỉ host của server hiện tại
  final String _masterHost = "127.0.0.1";
  final int _masterPort = 8090;
  // final String _serverHost = "192.168.1.8";
  final String _serverHost = "192.168.15.138";
  final int _serverPort = 8888;
  final _headers = {'Content-Type': 'application/json'};
  final _encoding = Encoding.getByName('utf-8');

  Uri _getMaterUri() {
    return Uri.parse("$_masterHost:$_masterPort");
  }

  Map<String, dynamic> getServerInfo() {
    ///request đến master để lấy thông tin server
    return {"host": _serverHost, "port": _serverPort};
  }

  dynamic doPost(Map<String, dynamic> map) async {
    String jsonBody = json.encode(map);
    Response response = await post(_getMaterUri(),
        headers: _headers, body: jsonBody, encoding: _encoding);
    return {"err_code": response.statusCode, "data": response.body};
  }

  /// create a singleton for HttpService
  static HttpService? _instance;

  HttpService._();

  static HttpService get instance => _instance ??= HttpService._();
}
