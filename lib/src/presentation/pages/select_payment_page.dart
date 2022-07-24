import '../cubit/menuQty/menu_qty_cubit.dart';
import '../cubit/menu_order/menu_order_cubit.dart';

import '../../core/shared/theme.dart';
import '../widgets/payment_app_bar.dart';
import '../widgets/payment_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    Widget _buildPaymentOption(int total) {
      return Column(
        children: listPaymentOption
            .map(
              (paymentOption) => Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: PaymentOption(
                  title: paymentOption['title']!,
                  imageUrl: paymentOption['imageUrl']!,
                  total: total,
                ),
              ),
            )
            .toList(),
      );
    }

    Widget _buildBody() {
      return SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<MenuOrderCubit, MenuOrderState>(
            builder: (context, state) {
              if (state is MenuOrderSuccess) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    defaultMargin,
                    45,
                    defaultMargin,
                    0,
                  ),
                  child: Column(
                    children: [
                      PaymentAppBar(
                        title: 'PAYMENT',
                        orderId: state.menuOrder.id!,
                        total: state.menuOrder.total,
                      ),
                      const SizedBox(height: 30),
                      Divider(thickness: 2, height: 0, color: lightGrayColor),
                      const SizedBox(height: 22),
                      _buildPaymentOption(state.menuOrder.total),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      );
    }

    return Scaffold(
      body: _buildBody(),
    );
  }
}
