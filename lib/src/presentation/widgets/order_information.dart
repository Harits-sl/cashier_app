import 'package:flutter/material.dart';

import '../../core/shared/theme.dart';
import '../../core/utils/string_helper.dart';

class OrderInformation extends StatelessWidget {
  const OrderInformation({
    Key? key,
    this.title,
    required this.orderId,
    required this.total,
  }) : super(key: key);

  /// varibel untuk judul app bar
  final String? title;

  /// variabel untuk order id
  final String orderId;

  /// variabel untuk total bill
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order ID',
                style: gray2TextStyle.copyWith(
                  fontWeight: light,
                  fontSize: 11,
                ),
              ),
              Text(
                orderId,
                style: primaryTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: gray2TextStyle.copyWith(
                  fontWeight: light,
                  fontSize: 11,
                ),
              ),
              Text(
                'Rp. ${StringHelper.addComma(total)}',
                style: secondaryTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
