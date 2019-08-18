// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class Note extends DataClass implements Insertable<Note> {
  final String id;
  final String title;
  final String description;
  final String tagName;
  final DateTime date;
  final DateTime time;
  final DateTime createdDate;
  final DateTime updatedDate;
  Note(
      {@required this.id,
      this.title,
      this.description,
      this.tagName,
      @required this.date,
      @required this.time,
      @required this.createdDate,
      @required this.updatedDate});
  factory Note.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Note(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      tagName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}tag_name']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      time:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}time']),
      createdDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_date']),
      updatedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_date']),
    );
  }
  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Note(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      tagName: serializer.fromJson<String>(json['tagName']),
      date: serializer.fromJson<DateTime>(json['date']),
      time: serializer.fromJson<DateTime>(json['time']),
      createdDate: serializer.fromJson<DateTime>(json['createdDate']),
      updatedDate: serializer.fromJson<DateTime>(json['updatedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'tagName': serializer.toJson<String>(tagName),
      'date': serializer.toJson<DateTime>(date),
      'time': serializer.toJson<DateTime>(time),
      'createdDate': serializer.toJson<DateTime>(createdDate),
      'updatedDate': serializer.toJson<DateTime>(updatedDate),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Note>>(bool nullToAbsent) {
    return NotesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      tagName: tagName == null && nullToAbsent
          ? const Value.absent()
          : Value(tagName),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      time: time == null && nullToAbsent ? const Value.absent() : Value(time),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      updatedDate: updatedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedDate),
    ) as T;
  }

  Note copyWith(
          {String id,
          String title,
          String description,
          String tagName,
          DateTime date,
          DateTime time,
          DateTime createdDate,
          DateTime updatedDate}) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        tagName: tagName ?? this.tagName,
        date: date ?? this.date,
        time: time ?? this.time,
        createdDate: createdDate ?? this.createdDate,
        updatedDate: updatedDate ?? this.updatedDate,
      );
  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('tagName: $tagName, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedDate: $updatedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      $mrjc(
          $mrjc(
              $mrjc(
                  $mrjc(
                      $mrjc($mrjc($mrjc(0, id.hashCode), title.hashCode),
                          description.hashCode),
                      tagName.hashCode),
                  date.hashCode),
              time.hashCode),
          createdDate.hashCode),
      updatedDate.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == id &&
          other.title == title &&
          other.description == description &&
          other.tagName == tagName &&
          other.date == date &&
          other.time == time &&
          other.createdDate == createdDate &&
          other.updatedDate == updatedDate);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> tagName;
  final Value<DateTime> date;
  final Value<DateTime> time;
  final Value<DateTime> createdDate;
  final Value<DateTime> updatedDate;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.tagName = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedDate = const Value.absent(),
  });
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  final GeneratedDatabase _db;
  final String _alias;
  $NotesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', $tableName, true,
        minTextLength: 0, maxTextLength: 50);
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, true,
        minTextLength: 0, maxTextLength: 255);
  }

  final VerificationMeta _tagNameMeta = const VerificationMeta('tagName');
  GeneratedTextColumn _tagName;
  @override
  GeneratedTextColumn get tagName => _tagName ??= _constructTagName();
  GeneratedTextColumn _constructTagName() {
    return GeneratedTextColumn(
      'tag_name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _timeMeta = const VerificationMeta('time');
  GeneratedDateTimeColumn _time;
  @override
  GeneratedDateTimeColumn get time => _time ??= _constructTime();
  GeneratedDateTimeColumn _constructTime() {
    return GeneratedDateTimeColumn(
      'time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  GeneratedDateTimeColumn _createdDate;
  @override
  GeneratedDateTimeColumn get createdDate =>
      _createdDate ??= _constructCreatedDate();
  GeneratedDateTimeColumn _constructCreatedDate() {
    return GeneratedDateTimeColumn(
      'created_date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _updatedDateMeta =
      const VerificationMeta('updatedDate');
  GeneratedDateTimeColumn _updatedDate;
  @override
  GeneratedDateTimeColumn get updatedDate =>
      _updatedDate ??= _constructUpdatedDate();
  GeneratedDateTimeColumn _constructUpdatedDate() {
    return GeneratedDateTimeColumn(
      'updated_date',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, title, description, tagName, date, time, createdDate, updatedDate];
  @override
  $NotesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'notes';
  @override
  final String actualTableName = 'notes';
  @override
  VerificationContext validateIntegrity(NotesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    if (d.description.present) {
      context.handle(_descriptionMeta,
          description.isAcceptableValue(d.description.value, _descriptionMeta));
    } else if (description.isRequired && isInserting) {
      context.missing(_descriptionMeta);
    }
    if (d.tagName.present) {
      context.handle(_tagNameMeta,
          tagName.isAcceptableValue(d.tagName.value, _tagNameMeta));
    } else if (tagName.isRequired && isInserting) {
      context.missing(_tagNameMeta);
    }
    if (d.date.present) {
      context.handle(
          _dateMeta, date.isAcceptableValue(d.date.value, _dateMeta));
    } else if (date.isRequired && isInserting) {
      context.missing(_dateMeta);
    }
    if (d.time.present) {
      context.handle(
          _timeMeta, time.isAcceptableValue(d.time.value, _timeMeta));
    } else if (time.isRequired && isInserting) {
      context.missing(_timeMeta);
    }
    if (d.createdDate.present) {
      context.handle(_createdDateMeta,
          createdDate.isAcceptableValue(d.createdDate.value, _createdDateMeta));
    } else if (createdDate.isRequired && isInserting) {
      context.missing(_createdDateMeta);
    }
    if (d.updatedDate.present) {
      context.handle(_updatedDateMeta,
          updatedDate.isAcceptableValue(d.updatedDate.value, _updatedDateMeta));
    } else if (updatedDate.isRequired && isInserting) {
      context.missing(_updatedDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Note.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(NotesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.description.present) {
      map['description'] = Variable<String, StringType>(d.description.value);
    }
    if (d.tagName.present) {
      map['tag_name'] = Variable<String, StringType>(d.tagName.value);
    }
    if (d.date.present) {
      map['date'] = Variable<DateTime, DateTimeType>(d.date.value);
    }
    if (d.time.present) {
      map['time'] = Variable<DateTime, DateTimeType>(d.time.value);
    }
    if (d.createdDate.present) {
      map['created_date'] =
          Variable<DateTime, DateTimeType>(d.createdDate.value);
    }
    if (d.updatedDate.present) {
      map['updated_date'] =
          Variable<DateTime, DateTimeType>(d.updatedDate.value);
    }
    return map;
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(_db, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final int id;
  final String name;
  final int color;
  final DateTime createdDate;
  final DateTime updatedDate;
  Tag(
      {@required this.id,
      @required this.name,
      this.color,
      @required this.createdDate,
      @required this.updatedDate});
  factory Tag.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Tag(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      color: intType.mapFromDatabaseResponse(data['${effectivePrefix}color']),
      createdDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_date']),
      updatedDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_date']),
    );
  }
  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<int>(json['color']),
      createdDate: serializer.fromJson<DateTime>(json['createdDate']),
      updatedDate: serializer.fromJson<DateTime>(json['updatedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<int>(color),
      'createdDate': serializer.toJson<DateTime>(createdDate),
      'updatedDate': serializer.toJson<DateTime>(updatedDate),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<Tag>>(bool nullToAbsent) {
    return TagsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      createdDate: createdDate == null && nullToAbsent
          ? const Value.absent()
          : Value(createdDate),
      updatedDate: updatedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedDate),
    ) as T;
  }

  Tag copyWith(
          {int id,
          String name,
          int color,
          DateTime createdDate,
          DateTime updatedDate}) =>
      Tag(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
        createdDate: createdDate ?? this.createdDate,
        updatedDate: updatedDate ?? this.updatedDate,
      );
  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('createdDate: $createdDate, ')
          ..write('updatedDate: $updatedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      $mrjc($mrjc($mrjc($mrjc(0, id.hashCode), name.hashCode), color.hashCode),
          createdDate.hashCode),
      updatedDate.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == id &&
          other.name == name &&
          other.color == color &&
          other.createdDate == createdDate &&
          other.updatedDate == updatedDate);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> color;
  final Value<DateTime> createdDate;
  final Value<DateTime> updatedDate;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.updatedDate = const Value.absent(),
  });
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  final GeneratedDatabase _db;
  final String _alias;
  $TagsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false, hasAutoIncrement: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 0, maxTextLength: 20);
  }

  final VerificationMeta _colorMeta = const VerificationMeta('color');
  GeneratedIntColumn _color;
  @override
  GeneratedIntColumn get color => _color ??= _constructColor();
  GeneratedIntColumn _constructColor() {
    return GeneratedIntColumn(
      'color',
      $tableName,
      true,
    );
  }

  final VerificationMeta _createdDateMeta =
      const VerificationMeta('createdDate');
  GeneratedDateTimeColumn _createdDate;
  @override
  GeneratedDateTimeColumn get createdDate =>
      _createdDate ??= _constructCreatedDate();
  GeneratedDateTimeColumn _constructCreatedDate() {
    return GeneratedDateTimeColumn(
      'created_date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _updatedDateMeta =
      const VerificationMeta('updatedDate');
  GeneratedDateTimeColumn _updatedDate;
  @override
  GeneratedDateTimeColumn get updatedDate =>
      _updatedDate ??= _constructUpdatedDate();
  GeneratedDateTimeColumn _constructUpdatedDate() {
    return GeneratedDateTimeColumn(
      'updated_date',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, color, createdDate, updatedDate];
  @override
  $TagsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tags';
  @override
  final String actualTableName = 'tags';
  @override
  VerificationContext validateIntegrity(TagsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.color.present) {
      context.handle(
          _colorMeta, color.isAcceptableValue(d.color.value, _colorMeta));
    } else if (color.isRequired && isInserting) {
      context.missing(_colorMeta);
    }
    if (d.createdDate.present) {
      context.handle(_createdDateMeta,
          createdDate.isAcceptableValue(d.createdDate.value, _createdDateMeta));
    } else if (createdDate.isRequired && isInserting) {
      context.missing(_createdDateMeta);
    }
    if (d.updatedDate.present) {
      context.handle(_updatedDateMeta,
          updatedDate.isAcceptableValue(d.updatedDate.value, _updatedDateMeta));
    } else if (updatedDate.isRequired && isInserting) {
      context.missing(_updatedDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, name};
  @override
  Tag map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Tag.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TagsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.color.present) {
      map['color'] = Variable<int, IntType>(d.color.value);
    }
    if (d.createdDate.present) {
      map['created_date'] =
          Variable<DateTime, DateTimeType>(d.createdDate.value);
    }
    if (d.updatedDate.present) {
      map['updated_date'] =
          Variable<DateTime, DateTimeType>(d.updatedDate.value);
    }
    return map;
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(_db, alias);
  }
}

abstract class _$MoorDatabase extends GeneratedDatabase {
  _$MoorDatabase(QueryExecutor e)
      : super(const SqlTypeSystem.withDefaults(), e);
  $NotesTable _notes;
  $NotesTable get notes => _notes ??= $NotesTable(this);
  $TagsTable _tags;
  $TagsTable get tags => _tags ??= $TagsTable(this);
  NoteDao _noteDao;
  NoteDao get noteDao => _noteDao ??= NoteDao(this as MoorDatabase);
  TagDao _tagDao;
  TagDao get tagDao => _tagDao ??= TagDao(this as MoorDatabase);
  @override
  List<TableInfo> get allTables => [notes, tags];
}
