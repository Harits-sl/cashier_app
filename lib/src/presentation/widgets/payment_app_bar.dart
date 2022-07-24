import 'package:flutter/material.dart';

import '../../core/shared/theme.dart';
import '../../core/utils/string_helper.dart';

class PaymentAppBar extends StatelessWidget {
  const PaymentAppBar({
    Key? key,
    required this.title,
    required this.orderId,
    required this.total,
  }) : super(key: key);

  /// varibel untuk judul app bar
  final String title;

  /// variabel untuk order id
  final String orderId;

  /// variabel untuk total bill
  final int total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title.toUpperCase(),
          style: blackTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 18,
          ),
        ),
        SizedBox(height: defaultMargin),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order ID',
              style: grayTextStyle.copyWith(
                fontWeight: regular,
                fontSize: 12,
              ),
            ),
            Text(
              orderId,
              style: blackTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total bill',
              style: grayTextStyle.copyWith(
                fontWeight: regular,
                fontSize: 12,
              ),
            ),
            Text(
              'Rp. ${StringHelper.addComma(total)}',
              style: darkBlueTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
