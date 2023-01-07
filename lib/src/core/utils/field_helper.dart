import 'package:flutter/widgets.dart';

class FieldHelper {
  static void number({
    required TextEditingController controller,
    required String value,
    required Function setState,
  }) {
    if (value == '') {
      controller = TextEditingController(text: '0');

      // set cursor textfield jadi paling ujung
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
      setState(controller);
    }

    /// jika karakter value onChanged lebih dari 1, lalu jika
    /// karakter value pertama sama dengan 0 maka set nilai
    /// _priceController menjadi karakter kedua dari value
    /// e.g: _priceController.text = 01 diubah menjadi
    /// _priceController.text = 1
    if (value.length > 1) {
      if (value[0] == '0') {
        controller = TextEditingController(text: value.substring(1));

        // set cursor textfield jadi paling ujung
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
        setState(controller);
      }
    }
  }
}
