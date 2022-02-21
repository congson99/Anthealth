
import 'package:anthealth_mobile/services/message/message_define.dart';

class Handler{

  void invoke(RMessage message){
    //TODO:mở UI
  }


  /// create a singleton for Handler
  static Handler? _instance;
  Handler._();
  static Handler get instance => _instance ??= Handler._();
}