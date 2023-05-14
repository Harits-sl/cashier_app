import 'package:flutter/material.dart';

import '../../core/shared/theme.dart';
import '../../core/utils/string_helper.dart';

class CustomRadioPaymentAmount extends StatefulWidget {
  const CustomRadioPaymentAmount({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,

    // required this.controller,
  }) : super(key: key);

  /// variabel untuk text dan juga nilai yang diberikan
  final int value;
  final int groupValue;
  final ValueChanged<int> onChanged;

  // final CustomRadioController controller;

  @override
  State<CustomRadioPaymentAmount> createState() =>
      _CustomRadioPaymentAmountState();
}

class _CustomRadioPaymentAmountState extends State<CustomRadioPaymentAmount> {
  @override
  Widget build(BuildContext context) {
    int _value = widget.value;

    return GestureDetector(
      onTap: () {
        widget.onChanged(widget.value);
        setState(() {
          _value = widget.value;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _value != widget.groupValue ? gray2Color : primaryColor,
            width: _value != widget.groupValue ? 1 : 2,
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            StringHelper.addComma(_value),
            style: primaryTextStyle.copyWith(
              fontWeight: medium,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomRadioController {
  bool isSelected;
  final int payment;

  CustomRadioController({
    required this.isSelected,
    required this.payment,
  });
}
