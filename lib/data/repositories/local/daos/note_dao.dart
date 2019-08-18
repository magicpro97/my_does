import 'package:moor_flutter/moor_flutter.dart';
import 'package:my_does/data/repositories/local/db.dart';
import 'package:my_does/data/repositories/local/tables/notes.dart';

part 'note_dao.g.dart';

@UseDao(tables: [Notes])
class NoteDao extends DatabaseAccessor<MoorDatabase> with _$NoteDaoMixin {
  final MoorDatabase db;

  NoteDao(this.db) : super(db);

  Stream<List<Note>> watchNotes() => select(notes).watch();

  Future insertNote(Note note) => into(notes).insert(note);

  Future updateNote(Note note) => update(notes).replace(note);

  Future deleteNote(Note note) => delete(notes).delete(note);
}
