import 'package:block_stady/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class AddTodo extends StatelessWidget {
  AddTodo({Key? key}) : super(key: key);
  TextEditingController titleController = TextEditingController();

  Box todobox = Hive.box<Todo>('todo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      //   centerTitle: true,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'task',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ConstrainedBox(
                constraints: const BoxConstraints.expand(
                  height: 40,
                ),
                child: ElevatedButton(
                    onPressed: () {
                      // ignore: unrelated_type_equality_checks
                      if (titleController != "") {
                        Todo newTodo = Todo(
                            title: titleController.text, isComplieted: false);
                        //add...............................
                        todobox.add(newTodo);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add')))
          ],
        ),
      ),
    );
  }
}
