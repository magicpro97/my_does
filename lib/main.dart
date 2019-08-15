import 'package:flutter/material.dart';
import 'package:my_does/data/models/todo.dart';
import 'package:my_does/ui/home/home.dart';
import 'package:my_does/ui/input/input.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Todo> _todoList = [
    Todo(
      id: '0',
      title: 'Hello',
      description: 'Go go go',
      date: DateTime(2019, 10, 10),
      time: DateTime(2019, 10, 10, 4, 50),
    ),
    Todo(
      id: '0',
      title: 'Hello',
      description: 'Go go go',
      date: DateTime(2019, 10, 10),
      time: DateTime(2019, 10, 10, 4, 50),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(
        todoList: _todoList,
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) =>
            HomeScreen(
              todoList: _todoList,
            ),
        InputScreen.routeAddName: (context) =>
            InputScreen(
              title: 'Create a new',
              todoList: _todoList,
            ),
      },
    );
  }
}
