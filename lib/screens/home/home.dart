import 'package:flutter/material.dart';
import 'package:my_does/screens/base/background_widget.dart';
import 'package:my_does/screens/home/todo_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(HomeTitle(), TodoList()),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TodoCard(),
        TodoCard(),
        TodoCard(),
        TodoCard(),
      ],
    );
  }
}

class HomeTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
