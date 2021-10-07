import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var titleValidate = false.obs;
  var descriptionValidate = false.obs;
  FirebaseDatabase fb = FirebaseDatabase.instance;
  DatabaseReference? ref;
  var isLoading = false.obs;
  var id = "".obs;

  @override
  void onInit() {
    ref = fb.reference();
    super.onInit();
  }

  bool validate() {
    titleController.text.isEmpty
        ? titleValidate.value = true
        : titleValidate.value = false;
    descriptionController.text.isEmpty
        ? descriptionValidate.value = true
        : descriptionValidate.value = false;
    if (titleValidate.value || descriptionValidate.value) {
      return false;
    } else {
      return true;
    }
  }

  void addData() {
    if (validate()) {
      isLoading.value = true;

      ref!.child('tasks').push().set({
        "title": titleController.text.trim(),
        "description": descriptionController.text.trim(),
        "userId": FirebaseAuth.instance.currentUser!.uid
      }).then((_) {
        isLoading.value = false;
        titleController.clear();
        descriptionController.clear();
        successSnackBar(msg: "Your task updated successfully");
      }).catchError((onError) {
        errorSnackBar(msg: "Error occurred. Please try again");
      });
    }
  }

  void updateData() {
    if (validate()) {
      isLoading.value = true;

      ref!.child("tasks").child(id.value).update({
        "title": titleController.text.trim(),
        "description": descriptionController.text.trim(),
      }).then((_) {
        isLoading.value = false;
        titleController.clear();
        descriptionController.clear();
        successSnackBar(msg: "Your task added successfully");
      }).catchError((onError) {
        errorSnackBar(msg: "Error occurred. Please try again");
      });
      id.value = "";
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

  successSnackBar({required String msg}) {
    return Get.snackbar(
      "Success",
      "$msg",
      backgroundColor: Colors.green[800]!,
      colorText: Colors.white,
      animationDuration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.all(50),
    );
  }
}
