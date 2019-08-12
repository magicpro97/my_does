import 'package:flutter/material.dart';
import 'package:my_does/screens/home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: HomeScreen(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () {}, backgroundColor: Colors.blue[900],
        ),
      ),
      );
  }
}
