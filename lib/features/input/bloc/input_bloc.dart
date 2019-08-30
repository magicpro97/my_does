import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:my_does/data/repositories/local/daos/tag_dao.dart';
import 'package:my_does/data/repositories/local/db.dart';

import './bloc.dart';

class InputBloc extends Bloc<InputEvent, InputState> {
  TagDao tagDao;
  Tag tag;

  InputBloc({this.tagDao, this.tag});

  @override
  InputState get initialState => InitialTagFieldState();

  @override
  Stream<InputState> mapEventToState(InputEvent event,) async* {
    if (event is InitialPage) {
      yield InitialTagFieldState(listTagStream: tagDao.watchTags());
    } else if (event is SelectedTagChange) {
      _tagChipItemChange(event.selectedItem);
    } else if (event is DeleteTag) {
      tagDao.deleteTag(event.tag);
    } else if (event is InsertTag) {
      tagDao.insertTag(event.tag);
    }
  }

  void _tagChipItemChange(Tag newItem) {
    tag = newItem;
  }
}
