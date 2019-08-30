import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_does/data/repositories/local/db.dart';
import 'package:my_does/features/home/home_page.dart';
import 'package:my_does/features/input/bloc/bloc.dart';
import 'package:my_does/features/input/input_page.dart';
import 'package:provider/provider.dart';

import 'features/home/bloc/bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        Provider(
          builder: (_) => MoorDatabase(),
        ),
        BlocProvider(
          builder: (_) => HomeBloc(),
        ),
        BlocProvider(
          builder: (_) => InputBloc(),
        ),
      ],
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
