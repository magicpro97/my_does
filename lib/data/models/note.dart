import 'package:meta/meta.dart';
import 'package:my_does/data/models/tag.dart';

class Note {
  String id;
  String title;
  String description;
  DateTime date;
  DateTime time;
  Tag tagName;

  Note({@required this.id,
    this.title,
    this.description,
    this.date,
    this.time,
    this.tagName});
}
