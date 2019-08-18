import 'package:flutter/material.dart';
import 'package:my_does/data/repositories/local/db.dart';
import 'package:my_does/ui/home/home.dart';
import 'package:my_does/ui/input/input.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      builder: (_) => MoorDatabase(),
      child: MaterialApp(
        home: HomeScreen(),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (_) => HomeScreen(),
          InputScreen.routeAddName: (_) => InputScreen(),
          InputScreen.routeEditName: (_) => InputScreen()
        },
      ),
    );
  }
}
