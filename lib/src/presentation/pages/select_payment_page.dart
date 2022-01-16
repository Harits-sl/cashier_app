import '../../core/shared/theme.dart';
import '../widgets/payment_app_bar.dart';
import '../widgets/payment_option.dart';
import 'package:flutter/material.dart';

class SelectPaymentPage extends StatelessWidget {
  const SelectPaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> listPaymentOption = [
      {
        'title': 'Cash',
        'imageUrl': 'assets/images/ic_cash.png',
      },
      {
        'title': 'Debit Card',
        'imageUrl': 'assets/images/ic_debit.png',
      },
      {
        'title': 'OVO',
        'imageUrl': 'assets/images/ic_ovo.png',
      },
      {
        'title': 'ShopeePay',
        'imageUrl': 'assets/images/ic_shopeepay.png',
      }
    ];

    Widget _buildPaymentOption() {
      return Column(
        children: listPaymentOption
            .map(
              (paymentOption) => Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: PaymentOption(
                  title: paymentOption['title']!,
                  imageUrl: paymentOption['imageUrl']!,
                ),
              ),
            )
            .toList(),
      );
    }

    Widget _buildBody() {
      return SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              defaultMargin,
              45,
              defaultMargin,
              0,
            ),
            child: Column(
              children: [
                const PaymentAppBar(
                  title: 'PAYMENT',
                  orderId: 'OD535627903678238',
                  total: 18000,
                ),
                const SizedBox(height: 30),
                Divider(thickness: 2, height: 0, color: lightGrayColor),
                const SizedBox(height: 22),
                _buildPaymentOption(),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: _buildBody(),
    );
  }
}
