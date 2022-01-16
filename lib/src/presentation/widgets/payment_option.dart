import '../../config/route/go.dart';
import '../pages/payment_amount_page.dart';
import 'package:flutter/material.dart';

import '../../core/shared/theme.dart';

class PaymentOption extends StatelessWidget {
  const PaymentOption({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  /// variabel judul text
  final String title;

  /// alamat / folder gambar
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Go.to(
          context,
          PaymentAmountPage(title: title, orderId: 'dadad', total: 18000),
        );
      },
      child: Container(
        height: 62,
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: grayColor.withOpacity(0.35),
              offset: const Offset(0, 2),
              blurRadius: 6,
              spreadRadius: -1,
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              imageUrl,
              width: 43,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: blackTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
