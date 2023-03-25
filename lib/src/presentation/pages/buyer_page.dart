import 'package:cashier_app/src/config/route/go.dart';
import 'package:cashier_app/src/config/route/routes.dart';
import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/core/utils/string_helper.dart';
import 'package:cashier_app/src/data/models/menu_order_model.dart';
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
  MenuOrderModel _menuOrder = const MenuOrderModel();

  void checkOutPressed() {
    // context.read<MenuOrderCubit>().orderCheckoutPressed();
    Go.routeWithPath(context: context, path: Routes.selectPayment);
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildButtonSaveToCart() {
      return SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: TextButton(
          onPressed: () {},
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

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(defaultMargin),
              child: BlocBuilder<MenuOrderCubit, MenuOrderState>(
                builder: ((context, state) {
                  if (state is MenuOrderSuccess) {
                    return Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: defaultMargin),
                          child: CustomTextField(
                            title: 'nama pembeli',
                            controller: buyerController,
                            keyboardType: TextInputType.name,
                            onChanged: (value) {
                              context.read<MenuOrderCubit>().addBuyerName(
                                    buyerController.text,
                                  );
                              setState(() {});
                              print(state.menuOrder.buyer);
                            },
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
                                      Text(state.menuOrder.buyer ?? ''),
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
      ),
    );
  }
}
