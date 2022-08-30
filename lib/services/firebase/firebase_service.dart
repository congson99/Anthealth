
import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
class FirebaseService
{
  // Get a non-default Storage bucket
  final storage = FirebaseStorage.instanceFor(bucket: "gs://anthealth-5d362.appspot.com");
  // Use a non-default App
  final storageRef = FirebaseStorage.instance.ref();

  late UserCredential userCredential ;

  Future<bool> signIn() async
  {
    try
    {
      userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
          print(e.code);
      }
    }
    return false;
  }

  String generateRandomString() {
    var r = Random();
    String randomString =String.fromCharCodes(List.generate(16, (index)=> r.nextInt(33) + 89));
    return randomString;
  }

  Future<String> uploadImage(File file) async
  {
    await signIn();
    // file.rename(generateRandomString());
    TaskSnapshot task = await storageRef.child("Image/" + generateRandomString() + ".jpg").putFile(file);
    if (task.state == TaskState.success)
    {
      return task.ref.getDownloadURL();
    }
    else
    {
      return "";
    }
  }

  static FirebaseService? _instance;
  FirebaseService._();
  static FirebaseService get instance => _instance ?? FirebaseService._();

}