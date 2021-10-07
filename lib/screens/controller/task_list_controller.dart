import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import 'add_task_controller.dart';
import 'home_controller.dart';

class TaskListController extends GetxController {
  FirebaseDatabase fb = FirebaseDatabase.instance;
  var tasks = [].obs;
  DatabaseReference? ref;
  HomeController homeController = Get.put(HomeController());
  AddTaskController addTaskController = Get.put(AddTaskController());

  @override
  void onInit() {
    ref = fb.reference();
    readData();
    super.onInit();
  }

  void readData() {
    ref!
        .child('tasks')
        .orderByChild('userId')
        .equalTo(FirebaseAuth.instance.currentUser!.uid)
        .onValue
        .listen((data) {
      tasks.clear();
      if(data.snapshot.value != null )
        {
          data.snapshot.value.forEach((key, values) {
            tasks.add({'key' : key , 'values' : values});
          });
        }
      tasks.value = tasks.reversed.toList();
    });
  }

  void deleteTask(var index) {
    var key = tasks[index]['key'];
    ref!.child('tasks').child(key).remove();
  }

  void switchToEdit(var index)
  {
      homeController.currentIndex.value = 0;
      addTaskController.titleController.text = tasks[index]['values']['title'];
      addTaskController.descriptionController.text = tasks[index]['values']['description'];
      addTaskController.id.value = tasks[index]['key'];
  }
}
