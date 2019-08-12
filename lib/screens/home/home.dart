import 'package:flutter/material.dart';
import 'package:my_does/screens/home/todo_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 200,
          color: Colors.blue[900],
          child: Column(
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
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 150),
          child: Column(
            children: <Widget>[
              TodoCard(),
              TodoCard(),
              TodoCard(),
              TodoCard(),
            ],
          ),
        ),
      ],
    );
  }
}
