import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker/screens/controller/add_task_controller.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  AddTaskController addTaskController = Get.put(AddTaskController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(()=>Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          titleField(), descriptionField(), saveButton() , if(addTaskController.id.value != "") cancelButton()],
      )),
    );
  }

  TextField titleField() {
    return TextField(
        textInputAction: TextInputAction.next,
        controller: addTaskController.titleController,
        decoration: InputDecoration(
          errorText: addTaskController.titleValidate.value ? 'Title can\'t be empty' : null,
          border:
              const OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
          hintText: "Title",
        ));
  }

  TextField descriptionField() {
    return TextField(
        textInputAction: TextInputAction.done,
        maxLines: 6,
        controller: addTaskController.descriptionController,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          errorText: addTaskController.descriptionValidate.value ? 'Description can\'t be empty' : null,
          border:
              const OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
          hintText: "Description",
        ));
  }

  ElevatedButton saveButton() {
    return ElevatedButton(
        onPressed: () {
          if (addTaskController.id.value == "") {
            addTaskController.addData();
          } else {
            addTaskController.updateData();
          }
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Obx(() => Center(
                child: addTaskController.isLoading.value
                    ? const CircularProgressIndicator(backgroundColor: Colors.white,)
                    : const Text(
                        "Save",
                        style: TextStyle(fontSize: 20),
                      ),
              )),
        ));
  }

  ElevatedButton cancelButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.red),
        onPressed: () {
          addTaskController.titleController.text = "";
          addTaskController.descriptionController.text = "";
          addTaskController.id.value = "";
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: const Center(
            child: Text(
              "Cancel",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ));
  }

}
