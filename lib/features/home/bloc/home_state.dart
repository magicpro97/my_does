import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_does/data/repositories/local/db.dart';

@immutable
abstract class HomeState extends Equatable {
  HomeState([List props = const <dynamic>[]]) : super(props);
}

class LoadingState extends HomeState {}

class InitialState extends HomeState {
  final Stream<List<Tag>> listTagStream;
  final Stream<List<Note>> listNoteStream;

  InitialState({this.listNoteStream, this.listTagStream})
      : super([listNoteStream, listTagStream]);
}

class LoadedFailState extends HomeState {}
