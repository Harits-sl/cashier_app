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

    // debugPrint(
    //     'today.subtract(Duration(days: subtractDay)): ${today.subtract(Duration(days: subtractDay))}');
    // debugPrint('dateCompare: ${dateCompare}');
    return dateCompare;
  }

  static String format(DateTime date) {
    DateFormat format = DateFormat('dd/MM/yyyy');
    return format.format(date);
  }
}
