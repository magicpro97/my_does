import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class InputState extends Equatable {
  InputState([List props = const <dynamic>[]]) : super(props);
}

class InitialInputState extends InputState {}
