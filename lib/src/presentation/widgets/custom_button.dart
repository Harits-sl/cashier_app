import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.width = double.infinity,
    this.height = 55,
    this.margin,
    required this.color,
    this.borderRadius,
    required this.onPressed,
    required this.text,
    this.textStyle,
  }) : super(key: key);

  final double width;
  final double height;
  final EdgeInsets? margin;
  final Color color;
  final BorderRadius? borderRadius;
  final Function() onPressed;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.all(defaultMargin),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(.25),
              offset: const Offset(0, 12),
              blurRadius: 27,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: white2TextStyle.copyWith(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
