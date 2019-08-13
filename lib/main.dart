import 'package:flutter/material.dart';
import 'package:my_does/screens/home/home.dart';
import 'package:my_does/screens/input/input.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InputScreen(title: 'Hello',),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        InputScreen.routeAddName: (context) => InputScreen(title: 'Hello'),
      },
    );
  }
}
