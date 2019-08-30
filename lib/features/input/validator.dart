import 'dart:async';

import 'package:my_does/utils/date_time_utils.dart';

class Validator {
  final validateTitle =
      StreamTransformer<String, String>.fromHandlers(handleData: (title, sink) {
    if (title.isEmpty) {
      sink.addError('Type something for your note.');
    } else if (title.length > 5) {
      sink.add(title);
    } else {
      sink.addError('Title is at least 5 charactor.');
    }
  });

  final validateDate = StreamTransformer<DateTime, String>.fromHandlers(
      handleData: (date, sink) {
    try {
      sink.add(DateTimeUtils.dateToString(date));
    } catch (Exception) {
      sink.addError('Wrong date format. Should be dd-MM-yy.');
    }
  });

  final validateTime = StreamTransformer<DateTime, String>.fromHandlers(
      handleData: (time, sink) {
    try {
      sink.add(DateTimeUtils.dateToString(time));
    } catch (Exception) {
      sink.addError('Wrong time format. Should be hh:mm.');
    }
  });
}
