import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/todo_controller.dart';

class HomeScreen extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());
  final TextEditingController _taskController = TextEditingController();

  HomeScreen({super.key});

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Todo'),
          content: TextField(controller: _taskController, decoration: const InputDecoration(hintText: 'Enter Todo title')),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                if (_taskController.text.isNotEmpty) {
                  todoController.addTask(_taskController.text);
                  _taskController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do List',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        elevation: 4.0,
        centerTitle: true,
      ),
      body: Obx(() {
        if (todoController.todos.isEmpty) {
          return const Center(child: Text('No todo available. Add some todos!'));
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: todoController.todos.length,
            itemBuilder: (context, index) {
              final task = todoController.todos[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(8.0)),
                child: ListTile(
                  leading: Icon(
                    task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: task.isCompleted ? Colors.green : Colors.grey,
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none),
                  ),
                  subtitle: Text(
                    task.isCompleted ? 'Done' : 'Pending',
                    style: TextStyle(color: task.isCompleted ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
                  ),
                  onTap: () => todoController.toggleTaskCompletion(index),
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        backgroundColor: Colors.teal,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
