import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker/screens/controller/login_controller.dart';
import 'package:task_tracker/widgets/app_bar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar:AppBar(
          title: const Center(
            child: Text("Sign in"),
          )),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            loginController.signIn();
          },
          child: SizedBox(
            height: 50,
            width: 200,
            child: Obx(
              () => Center(
                  child: loginController.isLoading.value
                      ? const CircularProgressIndicator(backgroundColor: Colors.white)
                      : const Text("Sign in")),
            ),
          ),
        ),
      ),
    ));
  }
}
