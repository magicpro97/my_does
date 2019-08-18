import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_does/data/repositories/local/daos/note_dao.dart';
import 'package:my_does/data/repositories/local/db.dart';
import 'package:my_does/ui/input/input.dart';
import 'package:my_does/ui/widgets/note_card_item.dart';
import 'package:my_does/utils/date_time_utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/HomeScreen';

  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final moorDb = Provider.of<MoorDatabase>(context);
    final noteDao = moorDb.noteDao;
    final tagDao = moorDb.tagDao;

    return Scaffold(
      body: StreamBuilder<List<Tag>>(
          stream: tagDao.watchTags(),
          builder: (BuildContext context, AsyncSnapshot<List<Tag>> snapshot) {
            final List<Tag> _tags = [
              Tag(
                  id: 0,
                  name: 'All',
                  color: Colors.white.value,
                  createdDate: DateTime.now(),
                  updatedDate: DateTime.now())
            ];
            if (snapshot.hasData) {
              _tags.addAll(snapshot.data);
            }
            return DefaultTabController(
              initialIndex: 0,
              length: _tags.length,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 230.0,
                    child: _homeTitleWidget(_tags),
                  ),
                  Expanded(
                    child: TabBarView(children: <Widget>[
                      ..._tags.map((tag) => _noteListWidget(noteDao)),
                    ]),
                  )
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, InputScreen.routeAddName);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _homeTitleWidget(List<Tag> tags) {
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
                  ...tags.map((tag) =>
                      Tab(
                        child: Text(tag.name),
                        icon: Icon(
                          Icons.lens,
                          color: Color(tag.color),
                        ),
                      )),
                ],
              ),
              preferredSize: Size.fromHeight(30.0),
            ),
          ],
        ));
  }

  Widget _noteListWidget(NoteDao noteDao) {
    return StreamBuilder<List<Note>>(
        stream: noteDao.watchNotes(),
        builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
          List<Note> _notes;
          if (snapshot.hasData) {
            _notes = snapshot.data;
          } else {
            _notes = [];
          }

          return ListView.builder(
            itemCount: _notes.length,
            itemBuilder: (BuildContext context, int index) {
              return Slidable(
                controller: SlidableController(),
                actionPane: SlidableDrawerActionPane(),
                secondaryActions: <Widget>[
                  IconSlideAction(
                      caption: 'Edit',
                      color: Colors.blue,
                      icon: Icons.edit,
                      onTap: () => _editNoteAction(context, _notes[index])),
                  IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () =>
                          _deleteNoteAction(
                              context, noteDao, _notes[index], index)),
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
        });
  }

  void _deleteNoteAction(BuildContext context, NoteDao noteDao, Note note,
      int index) {
    noteDao.deleteNote(note);
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Deleted'),
        action: SnackBarAction(
            label: 'Undo', onPressed: () => noteDao.insertNote(note))));
  }

  void _editNoteAction(BuildContext context, Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) =>
              InputScreen(
                note: note,
              )),
    );
  }
}
