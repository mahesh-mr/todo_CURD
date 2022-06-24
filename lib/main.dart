// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:block_stady/home_screen.dart';
import 'package:block_stady/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationSupportDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>('todo');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
