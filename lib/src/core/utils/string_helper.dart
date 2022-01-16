class StringHelper {
  /// menambahkan koma pada tiga angka belakang
  /* 
    var value = 10000
    addComma(value)
    hasilnya = 10.000
  */
  static addComma(int value) {
    return value.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }
}
