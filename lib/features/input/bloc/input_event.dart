import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class InputEvent extends Equatable {
  InputEvent([List props = const <dynamic>[]]) : super(props);
}
