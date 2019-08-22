import 'package:moor_flutter/moor_flutter.dart';
import 'package:my_does/data/repositories/local/db.dart';
import 'package:my_does/data/repositories/local/tables/tags.dart';

part 'tag_dao.g.dart';

@UseDao(tables: [Tags])
class TagDao extends DatabaseAccessor<MoorDatabase> with _$TagDaoMixin {
  final MoorDatabase db;

  TagDao(this.db) : super(db);

  Stream<List<Tag>> watchTags() => select(tags).watch();

  Future<List<Tag>> getTags() => select(tags).get();

  Future insertTag(Tag tag) => into(tags).insert(tag);

  Future updateTag(Tag tag) => update(tags).replace(tag);

  Future deleteTag(Tag tag) => delete(tags).delete(tag);
}
