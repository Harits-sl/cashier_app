import 'package:flutter/material.dart';

class Go {
  static void to(BuildContext context, page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static void back(BuildContext context, Widget widget) {
    Navigator.pop(context);
  }
}
