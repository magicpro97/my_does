import 'package:moor_flutter/moor_flutter.dart';

class Notes extends Table {
  TextColumn get id => text()();

  TextColumn get title => text().nullable().withLength(min: 0, max: 50)();

  TextColumn get description =>
      text().nullable().withLength(min: 0, max: 255)();

  TextColumn get tagName => text().nullable()();

  DateTimeColumn get date => dateTime()();

  DateTimeColumn get time => dateTime()();

  DateTimeColumn get createdDate => dateTime()();

  DateTimeColumn get updatedDate => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
