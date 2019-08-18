import 'package:moor_flutter/moor_flutter.dart';
import 'package:my_does/data/repositories/local/daos/note_dao.dart';
import 'package:my_does/data/repositories/local/daos/tag_dao.dart';
import 'package:my_does/data/repositories/local/tables/notes.dart';
import 'package:my_does/data/repositories/local/tables/tags.dart';

part 'db.g.dart';

@UseMoor(tables: [Notes, Tags], daos: [NoteDao, TagDao])
class MoorDatabase extends _$MoorDatabase {
  MoorDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;
}
