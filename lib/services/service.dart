import 'dart:io';
import 'dart:typed_data';

import 'package:anthealth_mobile/services/client.dart';
import 'package:anthealth_mobile/services/http/http_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CommonService {
  Client? client;
  // Get a non-default Storage bucket
  final storage = FirebaseStorage.instanceFor(bucket: "gs://anthealth-5d362.appspot.com");
  // Use a non-default App
  final storageRef = FirebaseStorage.instance.ref();


  ///send message to server
  Future<void> send(int msgID, String msgData) async {
    if (client == null) {
      _tryConnectServer();
      await Future.delayed(const Duration(seconds: 1), () {});
    }
    client?.send(msgID, msgData);
  }

  String uploadImage(File file)
  {
    try {
      Reference ref = storage.ref().child("Image/");
      UploadTask uploadTask = ref.putFile(file);
      uploadTask.then((res) {
        return res.ref.getDownloadURL();
      });
    } on FirebaseException catch (e) {
      // todo: log error
    }
    return "";
  }

  void _tryConnectServer() {
    var serverInfo = HttpService.instance.getServerInfo();
    client = Client(serverInfo['host'], serverInfo['port']);
    client?.connect();
  }

  /// create a singleton for CommonService
  static CommonService? _instance;

  CommonService._();

  static CommonService get instance => _instance ??= CommonService._();
}
