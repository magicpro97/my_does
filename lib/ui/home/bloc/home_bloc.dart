import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:my_does/data/repositories/local/daos/note_dao.dart';
import 'package:my_does/data/repositories/local/daos/tag_dao.dart';

import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TagDao tagDao;
  final NoteDao noteDao;

  HomeBloc({this.noteDao, this.tagDao});

  @override
  HomeState get initialState =>
      InitialState(listTagStream: tagDao.watchTags(),
          listNoteStream: noteDao.watchNotes());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetDataFromLocalDb) {
      yield InitialState(listTagStream: tagDao.watchTags(),
          listNoteStream: noteDao.watchNotes());
    } else if (event is DeleteNote) {
      noteDao.deleteNote(event.note);
    }
  }
}
