import 'package:flutter/material.dart';
import 'package:my_does/data/models/tag.dart';
import 'package:my_does/ui/input/input.dart';
import 'package:my_does/ui/widgets/todo_card_item.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/HomeScreen';
  final List<Map<String, dynamic>> todoList;

  HomeScreen({this.todoList});

  final List<Tag> _tags = [
    Tag(name: "All tags"),
    Tag(name: "Red tags", color: Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: _tags.length,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 230.0,
              child: _homeTitleWidget(),
            ),
            Expanded(
              child: TabBarView(children: <Widget>[
                _todoListWidget(),
                _todoListWidget(),
              ]),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, InputScreen.routeAddName);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _homeTitleWidget() {
    return Container(
        color: Colors.blue[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            Divider(
              color: Colors.white70,
            ),
            PreferredSize(
              child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.white.withOpacity(0.3),
                indicatorColor: Colors.white,
                tabs: <Tab>[
                  ..._tags.map((tag) =>
                      Tab(
                        child: Text(tag.name),
                        icon: Icon(
                          Icons.lens,
                          color: tag.color,
                        ),
                      )),
                ],
              ),
              preferredSize: Size.fromHeight(30.0),
            ),
          ],
        ));
  }

  Widget _todoListWidget() {
    return ListView.builder(
      itemCount: this.todoList != null ? this.todoList.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        InputScreen(
                          title: 'Edit the todo',
                          todoList: this.todoList,
                          index: index,
                        )));
          },
          child: TodoCardItem(
            key: Key(this.todoList[index]['id']),
            title: this.todoList[index]['title'],
            description: this.todoList[index]['description'],
            date: this.todoList[index]['date'],
            time: this.todoList[index]['time'],
          ),
        );
      },
    );
  }
}
