import 'package:flutter/material.dart';

import '../../core/shared/theme.dart';
import '../../core/utils/string_helper.dart';

class CustomRadioPayment extends StatefulWidget {
  const CustomRadioPayment({
    Key? key,
    required this.value,
  }) : super(key: key);

  /// variabel untuk text dan juga nilai yang diberikan
  final int value;

  @override
  _CustomRadioPaymentState createState() => _CustomRadioPaymentState();
}

class _CustomRadioPaymentState extends State<CustomRadioPayment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        border: Border.all(color: grayColor),
      ),
      child: Center(
        child: Text(
          StringHelper.addComma(widget.value),
          style: blackTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
