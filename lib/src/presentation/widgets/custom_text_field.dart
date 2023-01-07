import 'package:flutter/material.dart';

import '../../core/shared/theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.title,
    required this.controller,
    required this.keyboardType,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: blackTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: blackTextStyle.copyWith(
            fontSize: 16,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              gapPadding: 0,
              borderRadius: BorderRadius.circular(
                defaultBorderRadius,
              ),
              borderSide: BorderSide(
                color: grayColor,
              ),
            ),
          ),
          onChanged: (value) {
            onChanged(value);
          },
        ),
      ],
    );
  }
}
