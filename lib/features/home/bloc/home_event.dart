import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_does/data/repositories/local/db.dart';

@immutable
abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const <dynamic>[]]) : super(props);
}

class GetDataFromLocalDb extends HomeEvent {}

class InsertNote extends HomeEvent {
  final Note note;
  final int index;

  InsertNote({this.note, this.index}) : super([note, index]);
}

class DeleteNote extends HomeEvent {
  final Note note;

  DeleteNote({this.note}) : super([note]);
}
