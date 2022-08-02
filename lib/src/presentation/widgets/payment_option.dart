import 'package:cashier_app/src/config/route/routes.dart';

import '../cubit/menu_order/menu_order_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/route/go.dart';
import '../pages/payment_amount_page.dart';
import 'package:flutter/material.dart';

import '../../core/shared/theme.dart';

class PaymentOption extends StatelessWidget {
  const PaymentOption({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.total,
  }) : super(key: key);

  /// variabel judul text
  final String title;

  /// alamat / folder gambar
  final String imageUrl;

  final int total;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<MenuOrderCubit>().orderTypePaymentPressed(title);
        Go.routeWithPath(context: context, path: Routes.paymentAmount);
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
