import 'package:intl/intl.dart';

class StringHelper {
  /// menambahkan koma pada tiga angka belakang
  ///
  /// Example
  /// ```dart
  /// int total = 100000
  /// print(StringHelper.addComma(total)); // 100.000
  /// ```
  static String addComma(int value) {
    return value.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }

  static String capitalize(String s) {
    return s[0].toUpperCase() + s.substring(1);
  }

  static String titleCase(String s) {
    return s
        .replaceAll(RegExp(' +'), ' ')
        .split('-')
        .map((str) => capitalize(str))
        .join('-');
  }

  static String dateFormat(DateTime date) {
    var format = DateFormat('d MMM, yyyy');
    return format.format(date);
  }

  static String removeComma(String value) {
    return value.replaceAll(RegExp('[^A-Za-z0-9]'), '');
  }
}
