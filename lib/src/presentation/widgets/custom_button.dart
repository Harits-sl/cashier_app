import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.width = double.infinity,
    this.height = 50,
    this.margin,
    required this.color,
    this.borderRadius,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final double width;
  final double height;
  final EdgeInsets? margin;
  final Color color;
  final BorderRadius? borderRadius;
  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: whiteTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
