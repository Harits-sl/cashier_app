import 'package:flutter/material.dart';

import '../../core/shared/theme.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: blueColor,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: blueColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
    );
  }
}
