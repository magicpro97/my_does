import 'package:my_does/data/models/tag.dart';

class Todo {
  String title;
  String description;
  DateTime date;
  DateTime time;
  Tag tag;

  Todo({this.title, this.description, this.date, this.time, this.tag});
}
