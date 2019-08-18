import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_does/data/models/note.dart';
import 'package:my_does/data/models/tag.dart';
import 'package:my_does/ui/input/input.dart';
import 'package:my_does/ui/widgets/note_card_item.dart';
import 'package:my_does/utils/date_time_utils.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/HomeScreen';

  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Tag> _tags = [
    Tag(name: "All tags"),
    Tag(name: "Red tags", color: Colors.red),
  ];

  List<Note> _notes;

  @override
  void initState() {
    _notes = [];
    super.initState();
  }

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
    final SlidableController slidableController = SlidableController();

    return ListView.builder(
      itemCount: _notes.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return Slidable(
          controller: slidableController,
          actionPane: SlidableDrawerActionPane(),
          secondaryActions: <Widget>[
            IconSlideAction(
                caption: 'Edit',
                color: Colors.blue,
                icon: Icons.edit,
                onTap: () => _editTodoAction(context, _notes[index], index)),
            IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => _deleteTodoAction(context, _notes[index], index)),
          ],
          child: NoteCardItem(
            key: Key(_notes[index].id),
            title: _notes[index].title,
            description: _notes[index].description,
            date: DateTimeUtils.dateToString(_notes[index].date),
            time: DateTimeUtils.timeToString(_notes[index].time),
          ),
        );
      },
    );
  }

  void _deleteTodoAction(BuildContext context, Note todo, int index) {
    setState(() {
      _notes.remove(todo);
    });
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Deleted'),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _notes.insert(index, todo);
            });
          }),
    ));
  }

  void _editTodoAction(BuildContext context, Note not, int index) {
    Navigator.pushNamed(context, InputScreen.routeEditName);
  }
}
