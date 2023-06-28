import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.width = double.infinity,
    this.height = 55,
    this.margin = const EdgeInsets.all(defaultMargin),
    required this.color,
    this.borderRadius,
    required this.onPressed,
    required this.text,
    this.textStyle,
    this.isShadowed = false,
    this.border,
  }) : super(key: key);

  final double width;
  final double height;
  final EdgeInsets? margin;
  final Color color;
  final BorderRadius? borderRadius;
  final Function() onPressed;
  final String text;
  final TextStyle? textStyle;
  final bool isShadowed;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(28),
          boxShadow: isShadowed
              ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(.25),
                    offset: const Offset(0, 12),
                    blurRadius: 27,
                    spreadRadius: 4,
                  ),
                ]
              : [],
          border: border,
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle ?? white2TextStyle.copyWith(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
