import 'package:intl/intl.dart';

class DateTimeUtils {
  static final dateFormat = DateFormat('dd-MM-yyyy');
  static final timeFormat = DateFormat("HH:mm");

  static String dateToString(DateTime date) => dateFormat.format(date);

  static String timeToString(DateTime time) => timeFormat.format(time);
}
