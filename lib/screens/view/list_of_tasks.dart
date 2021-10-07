import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker/screens/controller/task_list_controller.dart';

class ListOfTasks extends StatefulWidget {
  const ListOfTasks({Key? key}) : super(key: key);

  @override
  _ListOfTasksState createState() => _ListOfTasksState();
}

class _ListOfTasksState extends State<ListOfTasks> {

  TaskListController taskListController = Get.put(TaskListController());


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(()=>ListView.builder(
          itemCount: taskListController.tasks.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context , index){
        return Container(margin: const EdgeInsets.all(10), child:
        Row(
          children: [
            Expanded(
              child: ExpansionTile(
                title: Text(taskListController.tasks[index]['values']['title']),
                controlAffinity: ListTileControlAffinity.leading,
                children: <Widget>[
                  ListTile(title: Text(taskListController.tasks[index]['values']['description'])),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Edit task',
              onPressed: () {
                taskListController.switchToEdit(index);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Delete task',
              onPressed: () {
                  showDeleteAlert(context , index);
              },
            ),
          ],
        ),);
      })),
    );
  }

  showDeleteAlert(BuildContext context , var index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete task'),
          content: const Text("Are you sure want to delete ?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                taskListController.deleteTask(index);
              },
            ),
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
