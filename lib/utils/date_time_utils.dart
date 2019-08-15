import 'package:intl/intl.dart';

class DateTimeUtil {
  static final _dateFormat = DateFormat('dd-MM-yyyy');
  static final _timeFormat = DateFormat("HH:mm");

  static String dateToString(DateTime date) => _dateFormat.format(date);

  static String timeToString(DateTime time) => _timeFormat.format(time);
}
