import 'package:flutter/material.dart';
import 'package:my_does/ui/home/home.dart';
import 'package:my_does/ui/input/input.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _todoList = [
    {
      'id': '0',
      'title': 'Hello',
      'description': 'Go go go',
      'date': '10-10-2019',
      'time': '4:50'
    },
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
