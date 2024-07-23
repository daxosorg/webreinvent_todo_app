import 'package:get/get.dart';

import '../models/task.dart';

class TodoController extends GetxController {
  var todos = <Task>[].obs;

  void addTask(String title) {
    todos.add(Task(title: title));
  }

  void toggleTaskCompletion(int index) {
    var task = todos[index];
    task.isCompleted = !task.isCompleted;
    todos[index] = task;
  }
}
