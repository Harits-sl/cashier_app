import 'package:flutter/material.dart';

class ButtonCircle extends StatelessWidget {
  const ButtonCircle({
    Key? key,
    required this.title,
    required this.color,
    required this.textStyle,
  }) : super(key: key);

  final String title;
  final Color color;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color),
      ),
      child: Center(
        child: Text(title, style: textStyle),
      ),
    );
  }
}
