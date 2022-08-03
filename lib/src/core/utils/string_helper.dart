class StringHelper {
  /// menambahkan koma pada tiga angka belakang
  ///
  /// ```dart
  /// int total = 100000
  /// print(StringHelper.addComma(total)); // 100.000
  /// ```
  static String addComma(int value) {
    return value.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }
}
