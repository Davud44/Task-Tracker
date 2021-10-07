import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker/screens/controller/home_controller.dart';
import 'package:task_tracker/widgets/app_bar.dart';

import 'add_task.dart';
import 'list_of_tasks.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(() => Scaffold(
              appBar: appBar(homeController.appBarTitles.elementAt(homeController.currentIndex.value)),
              body: IndexedStack(
                index: homeController.currentIndex.value,
                children: const [
                  AddTask(),
                  ListOfTasks()
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: homeController.currentIndex.value,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add_task), label: "Add task"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list), label: "Task list")
                ],
                onTap: (index) {
                  homeController.currentIndex.value = index;
                },
              ),
            )));
  }

}
