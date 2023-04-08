import 'package:cashier_app/src/config/route/go.dart';
import 'package:cashier_app/src/config/route/routes.dart';
import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/data/models/cart_model.dart';
import 'package:cashier_app/src/data/models/menu_order_model.dart';
import 'package:cashier_app/src/presentation/cubit/menu_order/menu_order_cubit.dart';
import 'package:cashier_app/src/presentation/features/cart/index.dart';
import 'package:cashier_app/src/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuOrder extends StatelessWidget {
  const MenuOrder({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(FetchCart());

    void onTapCheckout(CartModel cart) {
      // final menuOrder = MenuOrderModel.fromCartModel(cart);
      context.read<MenuOrderCubit>().setCart = cart;

      Go.routeWithPath(context: context, path: Routes.selectPayment);
    }

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state.carts.map((cart) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: lightGrayColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pembeli: ${cart.buyer}',
                      style: blackTextStyle.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      children: cart.listMenus!.map((menu) {
                        return Row(
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
                                menu['price'].toString(),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                (menu['totalBuy'] * menu['price']).toString(),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                    CustomButton(
                      color: blueColor,
                      height: 40,
                      onPressed: () => onTapCheckout(cart),
                      margin: const EdgeInsets.only(top: 12),
                      borderRadius: BorderRadius.circular(4),
                      text: 'Checkout',
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        }
        return SizedBox();
      },
    );
  }
}
