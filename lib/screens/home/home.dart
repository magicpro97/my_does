import 'package:flutter/material.dart';
import 'package:my_does/screens/base/background_widget.dart';
import 'package:my_does/screens/home/todo_card.dart';
import 'package:my_does/screens/input/input.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/HomeScreen';
  final todos;

  HomeScreen({this.todos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(top: _homeTitle(), bottom: _todoListWidget()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, InputScreen.routeAddName);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _homeTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'My Does',
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        Text(
          'Finish Them Quickly Today',
          style: TextStyle(color: Colors.white30, fontSize: 20),
        ),
        SizedBox(
          height: 20.0,
        ),
        Divider(
          color: Colors.white70,
        )
      ],
    );
  }

  Widget _todoListWidget() {
    return ListView.builder(
      itemCount: todos != null ? todos.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        InputScreen(
                          title: 'Edit the todo',
                          todos: todos,
                          index: index,
                        )));
          },
          child: TodoCardWidget(
            key: Key(todos[index]['id']),
            title: todos[index]['title'],
            description: todos[index]['description'],
            date: todos[index]['date'],
            time: todos[index]['time'],
          ),
        );
      },
    );
  }
}
