import 'package:intl/intl.dart';

class Date {
  static int filter(
      {required int subtractDay,
      required DateTime date,
      required DateTime today}) {
    DateFormat format = DateFormat('yyyy-MM-dd');

    int dateCompare = format
        .format(date)
        .compareTo(format.format(today.subtract(Duration(days: subtractDay))));

    return dateCompare;
  }
}