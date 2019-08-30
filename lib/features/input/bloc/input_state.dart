import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_does/data/repositories/local/db.dart';

@immutable
abstract class InputState extends Equatable {
  InputState([List props = const <dynamic>[]]) : super(props);
}

class InitialTagFieldState extends InputState {
  final Stream<List<Tag>> listTagStream;

  InitialTagFieldState({this.listTagStream}) : super([listTagStream]);
}
