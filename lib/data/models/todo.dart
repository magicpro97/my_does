import 'package:meta/meta.dart';
import 'package:my_does/data/models/tag.dart';

class Todo {
  String id;
  String title;
  String description;
  DateTime date;
  DateTime time;
  Tag tagName;

  Todo({@required this.id,
    @required this.title,
    this.description,
    this.date,
    this.time,
    this.tagName});
}
