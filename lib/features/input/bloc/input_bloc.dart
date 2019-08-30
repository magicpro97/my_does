import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:my_does/data/repositories/local/daos/note_dao.dart';
import 'package:my_does/data/repositories/local/daos/tag_dao.dart';
import 'package:my_does/data/repositories/local/db.dart';
import 'package:my_does/features/input/validator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import './bloc.dart';

class InputBloc extends Bloc<InputEvent, InputState> with Validator {
  TagDao tagDao;
  NoteDao noteDao;
  Tag tag;
  Tag _preTag;

  final _titleController = BehaviorSubject<String>();
  final _descriptionController = BehaviorSubject<String>();
  final _dateController = BehaviorSubject<DateTime>();
  final _timeController = BehaviorSubject<DateTime>();

  Stream<String> get title => _titleController.stream.transform(validateTitle);

  Stream<String> get description => _descriptionController.stream;

  Stream<String> get dateString =>
      _dateController.stream.transform(validateDate);

  Stream<String> get timeString =>
      _timeController.stream.transform(validateTime);

  Stream<bool> get submitValid =>
      Observable.combineLatest3(
          dateString, timeString, title, (dateString, timeString,
          title) => true);

  Function(String) get changeTitle => _titleController.sink.add;

  Function(String) get changeDescription => _descriptionController.sink.add;

  Function(DateTime) get changeDate => _dateController.sink.add;

  Function(DateTime) get changeTime => _timeController.sink.add;

  InputBloc({this.tagDao, this.noteDao});

  @override
  InputState get initialState => InitialState();

  @override
  Stream<InputState> mapEventToState(InputEvent event,) async* {
    if (event is InitialPage) {
      yield InitialTagFieldState(listTagStream: tagDao.watchTags());
    } else if (event is SelectedTagChange) {
      _changeSelectedTag(event.selectedItem);
    } else if (event is DeleteTag) {
      _changeSelectedTag(_preTag);
      tagDao.deleteTag(event.tag);
    } else if (event is InsertTag) {
      _changeSelectedTag(event.tag);
      tagDao.insertTag(event.tag);
    } else if (event is InsertNote) {
      _insertNote();
    } else if (event is UpdateNote) {
      _updateNote(event.note);
    }
  }

  void _insertNote() {
    final note = Note(
      id: Uuid().v1(),
      tagName: tag.name,
      title: _titleController.value,
      description: _descriptionController.value,
      date: _dateController.value,
      time: _timeController.value,
      createdDate: DateTime.now(),
      updatedDate: DateTime.now(),
    );
    noteDao.insertNote(note);
  }

  void _updateNote(Note note) {
    final newNote = Note(
      id: note.id,
      tagName: tag.name,
      title: _titleController.value,
      description: _descriptionController.value,
      date: _dateController.value,
      time: _timeController.value,
      createdDate: note.createdDate,
      updatedDate: DateTime.now(),
    );
    noteDao.updateNote(newNote);
  }

  void _changeSelectedTag(Tag newItem) {
    _preTag = tag;
    tag = newItem;
  }

  @override
  void dispose() {
    _titleController.close();
    _descriptionController.close();
    _dateController.close();
    _timeController.close();
    super.dispose();
  }
}
