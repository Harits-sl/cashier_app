import 'package:cashier_app/src/config/route/go.dart';
import 'package:cashier_app/src/config/route/routes.dart';
import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/core/utils/string_helper.dart';
import 'package:cashier_app/src/data/models/cart_model.dart';
import 'package:cashier_app/src/data/models/menu_order_model.dart';
import 'package:cashier_app/src/presentation/cubit/buyer/buyer_cubit.dart';
import 'package:cashier_app/src/presentation/cubit/menu_order/menu_order_cubit.dart';
import 'package:cashier_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:cashier_app/src/presentation/widgets/custom_button.dart';
import 'package:cashier_app/src/presentation/widgets/custom_divider.dart';
import 'package:cashier_app/src/presentation/widgets/item_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderInfoPage extends StatefulWidget {
  static const String routeName = '/order-info';

  const OrderInfoPage({super.key});

  @override
  State<OrderInfoPage> createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  TextEditingController buyerController = TextEditingController();
  bool isBuyerEmpty = false;

  void checkOutPressed() {
    // context.read<MenuOrderCubit>().orderCheckoutPressed();
    Go.routeWithPath(context: context, path: Routes.paymentMethod);
  }

  void saveToCart() {
    var menuOrder = context.read<MenuOrderCubit>().state;
    if (buyerController.text.isEmpty) {
      setState(() {
        isBuyerEmpty = true;
      });
      return;
    }

    if (menuOrder is MenuOrderSuccess) {
      CartModel cart = CartModel.fromMenuOrderModel(menuOrder.menuOrder);
      BuyerCubit().addToCart(cart);
      context.read<MenuOrderCubit>().initState();
      Go.routeWithPath(context: context, path: Routes.cashier);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildCustomerInformation() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer Information',
              style: primaryTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: buyerController,
                    onChanged: (value) {
                      if (isBuyerEmpty == true) {
                        print('true');
                        setState(() {
                          isBuyerEmpty = false;
                        });
                      }
                      context.read<MenuOrderCubit>().addBuyerName(
                            buyerController.text,
                          );
                    },
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 12,
                    ),
                    cursorColor: primaryColor,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 15,
                      ),
                      hintText: 'Customer Name',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      isBuyerEmpty ? "can't empty" : '',
                      style: redTextStyle.copyWith(
                        fontSize: 11,
                        fontWeight: light,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildListMenu(MenuOrderModel menuOrder) {
      int i = 0;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Items',
              style: primaryTextStyle.copyWith(),
            ),
            Column(
              children: menuOrder.listMenus!.map((menu) {
                i++;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ItemMenu(
                      id: menu['id'],
                      name: menu['menuName'],
                      price: menu['price'],
                      hpp: menu['hpp'],
                      totalOrder: menu['totalBuy'],
                    ),
                    i != menuOrder.listMenus!.length
                        ? const SizedBox(height: 12)
                        : const SizedBox(),
                    i != menuOrder.listMenus!.length
                        ? const CustomDivider()
                        : const SizedBox(),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      );
    }

    Widget _buildOrderSummary(MenuOrderModel menuOrder) {
      return Container(
        margin: const EdgeInsets.only(top: defaultMargin),
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: primaryTextStyle.copyWith(fontWeight: medium),
            ),
            Container(
              height: 42,
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: lightGray2Color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: primaryTextStyle.copyWith(
                      fontWeight: light,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Rp. ${StringHelper.addComma(menuOrder.total)}',
                    style: primaryTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildButtonPayment() {
      return Expanded(
        child: CustomButton(
          color: backgroundColor,
          onPressed: checkOutPressed,
          text: 'Payment',
          textStyle: primaryTextStyle.copyWith(fontSize: 12),
          margin: const EdgeInsets.only(
            right: 12,
            left: defaultMargin,
          ),
          border: Border.all(width: 1, color: primaryColor),
        ),
      );
    }

    Widget _buildButtonToCart() {
      return Expanded(
        child: CustomButton(
          color: primaryColor,
          onPressed: saveToCart,
          text: '+ Cart',
          margin: const EdgeInsets.only(right: defaultMargin, left: 12),
        ),
      );
    }

    Widget body() {
      MenuOrderModel? menuOrder;
      return SafeArea(
        child: Stack(
          children: [
            BlocBuilder<MenuOrderCubit, MenuOrderState>(
              builder: (context, state) {
                if (state is MenuOrderSuccess) {
                  menuOrder = state.menuOrder;
                }
                return ListView(
                  children: [
                    const CustomAppBar(title: 'Order'),
                    _buildCustomerInformation(),
                    _buildListMenu(menuOrder!),
                    _buildOrderSummary(menuOrder!),
                    const SizedBox(
                      height: (defaultMargin * 2) + 55,
                    )
                  ],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: defaultMargin,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    _buildButtonPayment(),
                    _buildButtonToCart(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        // context.read<MenuOrderCubit>().initState();
        return true;
      },
      child: Scaffold(
        body: body(),
      ),
    );
  }
}
