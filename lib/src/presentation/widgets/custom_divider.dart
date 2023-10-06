import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedLine(
      direction: Axis.horizontal,
      lineLength: double.infinity,
      lineThickness: 1.0,
      dashLength: 4.0,
      dashGapLength: 4.0,
      dashColor: gray2Color,
      dashRadius: 0.0,
      dashGapColor: Colors.transparent,
    );
  }
}
