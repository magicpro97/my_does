import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_does/data/repositories/local/db.dart';
import 'package:my_does/ui/home/widgets/home_tab_bar.dart';
import 'package:my_does/ui/home/widgets/home_tab_view.dart';
import 'package:my_does/ui/input/input_page.dart';
import 'package:provider/provider.dart';

import 'bloc/bloc.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/HomeScreen';

  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final homeBloc = Provider.of<HomeBloc>(context);

    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (BuildContext context, HomeState state) {
          return Column(
            children: <Widget>[
              Container(
                color: Colors.blue[900],
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
              ),
              Expanded(
                flex: 4,
                child: _buildContentPage(state),
              ),
            ],
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
              final tabController = TabController(
                vsync: this,
                length: tags.length,
              );

              return StreamBuilder(
                stream: state.listNoteStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final notes = snapshot.data;

                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue[900],
                            ),
                            child: HomeTabBar(
                              tabController: tabController,
                              tags: tags,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: HomeTabView(
                            tags: tags,
                            notes: notes,
                            tabController: tabController,
                          ),
                        )
                      ],
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
}
