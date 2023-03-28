import 'package:cashier_app/src/config/route/go.dart';
import 'package:cashier_app/src/config/route/routes.dart';
import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/core/utils/string_helper.dart';
import 'package:cashier_app/src/data/models/cart_model.dart';
import 'package:cashier_app/src/data/models/menu_order_model.dart';
import 'package:cashier_app/src/presentation/cubit/cart/cart_cubit.dart';
import 'package:cashier_app/src/presentation/cubit/menu_order/menu_order_cubit.dart';
import 'package:cashier_app/src/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyerPage extends StatefulWidget {
  const BuyerPage({super.key});

  @override
  State<BuyerPage> createState() => _BuyerPageState();
}

class _BuyerPageState extends State<BuyerPage> {
  TextEditingController buyerController = TextEditingController();
  bool isBuyerEmpty = false;

  void checkOutPressed() {
    // context.read<MenuOrderCubit>().orderCheckoutPressed();
    Go.routeWithPath(context: context, path: Routes.selectPayment);
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
      CartCubit().addToCart(cart);
      context.read<MenuOrderCubit>().initState();
      Go.routeWithPath(context: context, path: Routes.orderMenu);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildButtonSaveToCart() {
      return SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: TextButton(
          onPressed: saveToCart,
          style: TextButton.styleFrom(
            backgroundColor: whiteColor,
            primary: blueColor,
            padding: const EdgeInsets.symmetric(vertical: 24),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          child: const Text('Save to Cart'),
        ),
      );
    }

    Widget _buildButtonCheckout() {
      return SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: TextButton(
          onPressed: checkOutPressed,
          style: TextButton.styleFrom(
            backgroundColor: blueColor,
            primary: whiteColor,
            padding: const EdgeInsets.symmetric(vertical: 24),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          child: const Text('Checkout'),
        ),
      );
    }

    Widget body() {
      return SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(defaultMargin),
              child: BlocBuilder<MenuOrderCubit, MenuOrderState>(
                builder: ((context, state) {
                  if (state is MenuOrderSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          title: 'nama pembeli',
                          controller: buyerController,
                          keyboardType: TextInputType.name,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 8),
                          child: Text(
                            isBuyerEmpty ? 'nama kosong' : '',
                            style: darkRedTextStyle,
                          ),
                        ),
                        Column(
                          children: state.menuOrder.listMenus!
                              .map(
                                (menu) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          menu['menuName'],
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          menu['totalBuy'].toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          StringHelper.addComma(menu['price']),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          StringHelper.addComma(
                                              menu['totalBuy'] * menu['price']),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    );
                  }
                  return SizedBox();
                }),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  _buildButtonSaveToCart(),
                  _buildButtonCheckout(),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        context.read<MenuOrderCubit>().initState();
        return true;
      },
      child: Scaffold(
        body: body(),
      ),
    );
  }
}
