import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class InputBloc extends Bloc<InputEvent, InputState> {
  @override
  InputState get initialState => InitialInputState();

  @override
  Stream<InputState> mapEventToState(InputEvent event,
  ) async* {
    
  }
}
