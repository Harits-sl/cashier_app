import 'package:flutter/material.dart';

import 'package:cashier_app/src/core/shared/theme.dart';

class CustomDropdownFormField extends StatelessWidget {
  const CustomDropdownFormField({
    Key? key,
    required this.title,
    required this.listDropdown,
    required this.textValidator,
    this.value,
    this.onChanged,
  }) : super(key: key);

  final String title;
  final List listDropdown;
  final String textValidator;
  final String? value;
  final void Function(Object?)? onChanged;

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
          DropdownButtonFormField(
            dropdownColor: lightGray2Color,
            borderRadius: BorderRadius.circular(16),
            iconEnabledColor: primaryColor,
            value: value,
            hint: Text(listDropdown[0]),
            items: listDropdown.map((unit) {
              return DropdownMenuItem(
                child: Text(
                  unit,
                  style: primaryTextStyle,
                ),
                value: unit,
              );
            }).toList(),
            validator: (value) {
              if (value == null) {
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
