import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_does/data/repositories/local/db.dart';

@immutable
abstract class InputEvent extends Equatable {
  InputEvent([List props = const <dynamic>[]]) : super(props);
}

class InitialPage extends InputEvent {}

class SelectedTagChange extends InputEvent {
  final Tag selectedItem;

  SelectedTagChange({this.selectedItem}) : super([selectedItem]);
}

class DeleteTag extends InputEvent {
  final Tag tag;

  DeleteTag({this.tag}) : super([tag]);
}

class InsertTag extends InputEvent {
  final Tag tag;

  InsertTag({this.tag}) : super([tag]);
}
