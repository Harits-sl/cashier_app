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
      progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryColor),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        hintStyle: gray2TextStyle.copyWith(
          fontWeight: medium,
          fontSize: 12,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: lightGray2Color, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
