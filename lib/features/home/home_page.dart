import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_does/data/repositories/local/db.dart';
import 'package:my_does/features/home/widgets/home_tab_bar.dart';
import 'package:my_does/features/home/widgets/home_tab_view.dart';
import 'package:my_does/features/input/input_page.dart';
import 'package:provider/provider.dart';

import 'bloc/bloc.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    final homeBloc = Provider.of<HomeBloc>(context);
    final db = Provider.of<MoorDatabase>(context);
    homeBloc.noteDao = db.noteDao;
    homeBloc.tagDao = db.tagDao;
    Future.delayed(
        Duration(seconds: 3), () => homeBloc.dispatch(GetDataFromLocalDb()));

    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (BuildContext context, HomeState state) {
          return OrientationBuilder(
            builder: (context, orientation) =>
                Column(
                  children: <Widget>[
                    Expanded(
                        flex: orientation == Orientation.landscape ? 1 : 2,
                        child: _buildAppLabel()),
                    Divider(),
                    Expanded(
                      flex: orientation == Orientation.landscape ? 2 : 6,
                      child: state is InitialState
                          ? _buildContentPage(state)
                          : _buildLoadingContent(state),
                    )
                  ],
                ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, InputPage.routeAddName);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildAppLabel() {
    return Container(
      color: Colors.blue[900],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
            child: Center(
              child: Text(
                'My Does',
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
          ),
          Center(
            child: Text(
              'Finish Them Quickly Today',
              style: TextStyle(color: Colors.white30, fontSize: 20),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }

  Tag defaultTag() {
    return Tag(
      name: "All tags",
      color: Colors.white.value,
      createdDate: null,
      updatedDate: null,
    );
  }

  Widget _buildContentPage(InitialState state) =>
      StreamBuilder(
          stream: state.listTagStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<Tag> tags = snapshot.data;
              if (!tags.contains(defaultTag())) {
                tags.insert(0, defaultTag());
              }

              return StreamBuilder(
                stream: state.listNoteStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final notes = snapshot.data;

                    return DefaultTabController(
                      length: tags.length,
                      child: OrientationBuilder(
                        builder: (context, orientation) =>
                            Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue[900],
                            ),
                            child: HomeTabBar(
                              tags: tags,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: orientation == Orientation.portrait ? 7 : 4,
                          child: HomeTabView(
                            tags: tags,
                            notes: notes,
                          ),
                        )
                      ],
                            ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              );
            } else {
              return Container();
            }
          });

  Widget _buildLoadingContent(HomeState state) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              CircularProgressIndicator(),
              Text('Loading...'),
            ],
          ),
        ),
      );
}
