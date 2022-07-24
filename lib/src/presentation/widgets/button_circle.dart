import 'package:flutter/material.dart';

class ButtonCircle extends StatelessWidget {
  const ButtonCircle({
    Key? key,
    required this.title,
    required this.color,
    required this.textStyle,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final Color color;
  final TextStyle textStyle;
  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: color),
        ),
        child: Center(
          child: Text(title, style: textStyle),
        ),
      ),
    );
  }
}
