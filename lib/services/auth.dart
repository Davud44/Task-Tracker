import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:task_tracker/screens/view/login.dart';

class AuthService {

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await FirebaseAuth.instance.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      FirebaseAuth.instance.signOut();
      Get.offAll(const Login());
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}