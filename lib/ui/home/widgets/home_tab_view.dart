import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_does/data/repositories/local/db.dart';
import 'package:my_does/ui/home/bloc/bloc.dart';
import 'package:my_does/ui/input/input_page.dart';
import 'package:my_does/ui/widgets/note_card_item.dart';
import 'package:provider/provider.dart';

class HomeTabView extends StatelessWidget {
  final List<Note> notes;
  final List<Tag> tags;
  final TabController tabController;

  HomeTabView({this.notes, this.tags, @required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: <Widget>[
        ...tags.map((tag) => _buildTabView()).toList(),
      ],
    );
  }

  Widget _buildTabView() {
    return Container(
      child: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (BuildContext context, int index) {
          return Slidable(
            controller: SlidableController(),
            actionPane: SlidableDrawerActionPane(),
            secondaryActions: <Widget>[
              IconSlideAction(
                  caption: 'Edit',
                  color: Colors.blue,
                  icon: Icons.edit,
                  onTap: () => _editNoteAction(context, notes[index])),
              IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () => _deleteNoteAction(context, notes[index], index)),
            ],
            child: NoteCardItem(
              note: notes[index],
              tag: tags.firstWhere(
                      (tag) => (tag.name ?? '') == notes[index].tagName,
                  orElse: () => null),
            ),
          );
        },
      ),
    );
  }

  void _deleteNoteAction(BuildContext context, Note note, int index) {
    final homeBloc = Provider.of<HomeBloc>(context);
    homeBloc.dispatch(DeleteNote(note: note));
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () =>
              homeBloc.dispatch(
                InsertNote(note: note, index: index),
              ),
        ),
      ),
    );
  }

  void _editNoteAction(BuildContext context, Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            InputPage(
              note: note,
            ),
      ),
    );
  }
}
