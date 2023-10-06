import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.width = double.infinity,
    this.height = 55,
    this.margin,
    this.padding,
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
  final EdgeInsets? padding;
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
        margin: margin ?? const EdgeInsets.all(defaultMargin),
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: defaultMargin),
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius ?? BorderRadius.circular(28),
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

class CustomButtonWithIcon extends CustomButton {
  const CustomButtonWithIcon({
    required this.iconUrl,
    required this.iconText,
    required this.iconColor,
    Key? key,
    super.width = double.infinity,
    super.height = 55,
    super.margin,
    super.padding,
    required super.color,
    super.borderRadius,
    required super.onPressed,
    required super.text,
    super.textStyle,
    super.isShadowed = false,
    super.border,
  }) : super(key: key);

  final String iconUrl;
  final String iconText;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        margin: margin ?? const EdgeInsets.all(defaultMargin),
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: defaultMargin),
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius ?? BorderRadius.circular(28),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: textStyle,
            ),
            Row(
              children: [
                Image.asset(
                  iconUrl,
                  width: 18,
                  color: iconColor,
                ),
                const SizedBox(width: 8),
                Text(
                  iconText,
                  style: textStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
