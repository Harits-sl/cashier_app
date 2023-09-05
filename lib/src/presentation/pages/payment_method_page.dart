import 'package:cashier_app/src/config/route/go.dart';
import 'package:cashier_app/src/config/route/routes.dart';
import 'package:cashier_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:cashier_app/src/presentation/widgets/custom_divider.dart';
import 'package:cashier_app/src/presentation/widgets/order_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/shared/theme.dart';
import '../cubit/menu_order/menu_order_cubit.dart';

class PaymentMethod extends StatelessWidget {
  static const String routeName = '/payment-method';

  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuOrderBloc = context.read<MenuOrderBloc>();
    // CartModel cart = menuOrderBloc.cart;
    // if (cart.id != null) {
    //   menuOrderBloc.getDataFromCart();
    // }

    List<Map<String, String>> listPaymentOption = [
      {
        'title': 'Cash',
        'imageUrl': 'assets/images/ic_cash.png',
      },
      {
        'title': 'BCA',
        'imageUrl': 'assets/images/ic_bca.png',
      },
      {
        'title': 'ShopeePay',
        'imageUrl': 'assets/images/ic_shopeepay.png',
      }
    ];

    Widget _buildPaymentOption(int total) {
      return Column(
        children: listPaymentOption
            .map((paymentOption) => GestureDetector(
                  onTap: () {
                    menuOrderBloc.add(
                      OrderTypePaymentPressed(
                        typePayment: paymentOption['title']!,
                      ),
                    );

                    Go.routeWithPath(
                        context: context, path: Routes.paymentAmount);
                  },
                  child: Container(
                    height: 62,
                    margin: const EdgeInsets.only(
                      bottom: 12,
                      left: defaultMargin,
                      right: defaultMargin,
                    ),
                    padding: const EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1.5, color: lightGray2Color),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          paymentOption['imageUrl']!,
                          width: 35,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          paymentOption['title']!,
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
      );
    }

    Widget _buildBody() {
      return SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<MenuOrderBloc, MenuOrderState>(
            builder: (context, state) {
              return Column(
                children: [
                  const CustomAppBar(title: 'Payment Method'),
                  OrderInformation(
                    orderId: state.id!,
                    total: state.total!,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: defaultMargin,
                      vertical: 12,
                    ),
                    child: const CustomDivider(),
                  ),
                  _buildPaymentOption(state.total!),
                ],
              );
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
