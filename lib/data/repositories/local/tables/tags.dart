import 'package:moor_flutter/moor_flutter.dart';

class Tags extends Table {
  IntColumn get id => integer().autoIncrement().nullable()();

  TextColumn get name => text().withLength(min: 0, max: 20)();

  IntColumn get color => integer()();

  DateTimeColumn get createdDate => dateTime()();

  DateTimeColumn get updatedDate => dateTime()();

  @override
  Set<Column> get primaryKey => {id, name};
}
