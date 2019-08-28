import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_does/data/repositories/local/db.dart';
import 'package:my_does/ui/home/bloc/home_bloc.dart';
import 'package:my_does/ui/home/home_page.dart';
import 'package:my_does/ui/input/input_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) {
        final localDb = MoorDatabase();
        final tagDao = localDb.tagDao;
        final noteDao = localDb.noteDao;

        return HomeBloc(tagDao: tagDao, noteDao: noteDao);
      },
      child: _buildApp(),
    );
  }

  Widget _buildApp() {
    return MaterialApp(
      home: HomePage(),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (_) => HomePage(),
        InputPage.routeAddName: (_) => InputPage(),
        InputPage.routeEditName: (_) => InputPage()
      },
    );
  }
}
