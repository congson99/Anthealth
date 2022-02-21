import 'package:anthealth_mobile/services/client.dart';
import 'package:anthealth_mobile/services/http/http_service.dart';

class CommonService{
  Client? client;
  bool _bConnected = false;

  ///send message to server
  void send(int msgID,String msgData){
    if(client == null){
      _tryConnectServer();
    }
    if(client != null || !_bConnected)
      client?.send(msgID, msgData);
    else
      print("error client connection not found");
  }

  void _tryConnectServer(){
    var serverInfo = HttpService.instance.getServerInfo();
    try{
      client = Client(serverInfo['host'], serverInfo['port']);
      client?.connect();
      _bConnected = true;

    }
    catch(e){
      _bConnected = false;
    }
  }

  /// create a singleton for CommonService
  static CommonService? _instance;
  CommonService._();
  static CommonService get instance => _instance ??= CommonService._();

}