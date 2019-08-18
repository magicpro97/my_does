import 'package:flutter/material.dart';
import 'package:my_does/ui/home/home.dart';
import 'package:my_does/ui/input/input.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        InputScreen.routeAddName: (context) => InputScreen(),
        InputScreen.routeEditName: (context) => InputScreen()
      },
    );
  }
}
