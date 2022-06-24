import 'package:block_stady/add_todo.dart';
import 'package:block_stady/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box todobox = Hive.box<Todo>('todo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyTodo'),
        centerTitle: true,
      ),

      //flottingactionbutton to adding todo....
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.task),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTodo(),
              ),
            );
          }),
      body: ValueListenableBuilder(
          valueListenable: todobox.listenable(),
          builder: (context, Box box, widget) {
            if (box.isEmpty) {
              return const Center(
                child: Text('no Items'),
              );
            } else {
              return ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    //show the list of todo......box.getAt()
                    Todo todo = box.getAt(index);
                    return ListTile(
                      title: Text(
                        todo.title,
                        style: TextStyle(
                            color: todo.isComplieted
                                ? Colors.green
                                : Colors.black),
                      ),
                      leading: Checkbox(
                          value: (todo.isComplieted),
                          onChanged: (value) {
                            Todo newtodo =
                                Todo(title: todo.title, isComplieted: value!);

                            box.putAt(index, newtodo);
                          }),
                      trailing: Wrap(
                        children: [
                          IconButton(
                              onPressed: () {
                                TextEditingController newtext =
                                    TextEditingController(text: todo.title);
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: TextField(
                                          controller: newtext,
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {},
                                              child: const Text('Cancel')),
                                          TextButton(
                                              onPressed: () {
                                                //udate...........
                                                box.putAt(
                                                  index,
                                                  Todo(
                                                      title: newtext.text,
                                                      isComplieted: false),
                                                );
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Ok')),
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Do You want Delet?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel")),
                                          TextButton(
                                              onPressed: () {

                                                //delete...................
                                                box.deleteAt(index);
                                                Navigator.pop(context);

                                                // ignore: unnecessary_const
                                              },
                                              child: const Text(
                                                'Delete',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ))
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
}
