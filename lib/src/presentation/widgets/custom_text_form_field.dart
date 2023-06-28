import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cashier_app/src/core/shared/theme.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.title,
    required this.textValidator,
    required this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
  }) : super(key: key);

  final String title;
  final String textValidator;
  final String hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: primaryTextStyle,
          ),
          const SizedBox(height: 8),
          TextFormField(
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(hintText: hintText),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return textValidator;
              }
              return null;
            },
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
