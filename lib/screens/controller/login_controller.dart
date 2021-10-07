import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker/screens/view/home.dart';
import 'package:task_tracker/services/auth.dart';

class LoginController extends GetxController {
  AuthService authService = AuthService();
  var isLoading = false.obs;

  void signIn() async {
    isLoading.value = true;
    dynamic result = await authService.signInAnon();

    isLoading.value = false;

    if (result == null) {
      errorSnackBar(msg: "Error occurred. Please try again");
    } else {
      Get.offAll(const Home());
    }
  }

  errorSnackBar({required String msg}) {
    return Get.snackbar(
      "Error",
      "$msg",
      backgroundColor: Colors.red[800]!,
      colorText: Colors.white,
      animationDuration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.all(50),
    );
  }
}
