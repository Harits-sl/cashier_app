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

  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
