import 'package:flutter/material.dart';
import 'package:my_does/screens/base/background_widget.dart';
import 'package:my_does/screens/home/todo_card.dart';
import 'package:my_does/screens/input/input.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/HomeScreen';
  final todoList;

  HomeScreen({this.todoList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
          top: _homeTitleWidget(), bottom: _todoListWidget()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, InputScreen.routeAddName);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _homeTitleWidget() {
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
      itemCount: todoList != null ? todoList.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        InputScreen(
                          title: 'Edit the todo',
                          todoList: todoList,
                          index: index,
                        )));
          },
          child: TodoCardWidget(
            key: Key(todoList[index]['id']),
            title: todoList[index]['title'],
            description: todoList[index]['description'],
            date: todoList[index]['date'],
            time: todoList[index]['time'],
          ),
        );
      },
    );
  }
}
