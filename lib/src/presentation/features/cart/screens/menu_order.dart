import 'package:cashier_app/src/config/route/go.dart';
import 'package:cashier_app/src/config/route/routes.dart';
import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/core/utils/string_helper.dart';
import 'package:cashier_app/src/data/models/cart_model.dart';
import 'package:cashier_app/src/data/models/menu_order_model.dart';
import 'package:cashier_app/src/presentation/cubit/menu_order/menu_order_cubit.dart';
import 'package:cashier_app/src/presentation/features/cart/index.dart';
import 'package:cashier_app/src/presentation/widgets/custom_button.dart';
import 'package:cashier_app/src/presentation/widgets/custom_divider.dart';
import 'package:cashier_app/src/presentation/widgets/item_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuOrder extends StatelessWidget {
  const MenuOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void onTapEdit(CartModel cart) {
      context.read<MenuOrderCubit>().setCart = cart;

      Go.routeWithPathAndRemove(context: context, path: Routes.editOrderMenu);
    }

    void onTapCheckout(CartModel cart) {
      // final menuOrder = MenuOrderModel.fromCartModel(cart);
      context.read<MenuOrderCubit>().setCart = cart;

      Go.routeWithPath(context: context, path: Routes.paymentMethod);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          int i = 1;
          if (state is CartSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: state.carts.map((cart) {
                i++;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '${cart.buyer}',
                        style: primaryTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: medium,
                        ),
                        children: [
                          const WidgetSpan(
                            child: SizedBox(
                              width: 8,
                            ),
                          ),
                          TextSpan(
                            text: '${cart.listMenus!.length} Items',
                            style: primaryTextStyle.copyWith(
                              fontSize: 11,
                              fontWeight: light,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: cart.listMenus!.map((menu) {
                        return ItemMenu(
                          id: menu['id'],
                          name: menu['menuName'],
                          price: menu['price'],
                          hpp: menu['hpp'],
                          totalOrder: menu['totalBuy'],
                          isDisabled: true,
                        );
                      }).toList(),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: lightGray2Color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: const EdgeInsets.only(top: 12),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: primaryTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: light,
                                ),
                              ),
                              Text(
                                'Rp. ${StringHelper.addComma(cart.total!)}',
                                style: primaryTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: medium,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomButton(
                                  color: backgroundColor,
                                  onPressed: () => onTapEdit(cart),
                                  text: 'Add New Item',
                                  height: 34,
                                  textStyle: primaryTextStyle.copyWith(
                                    fontSize: 11,
                                    fontWeight: light,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  margin: const EdgeInsets.only(right: 12),
                                ),
                              ),
                              Expanded(
                                child: CustomButton(
                                  color: primaryColor,
                                  onPressed: () => onTapCheckout(cart),
                                  text: 'Checkout',
                                  height: 34,
                                  textStyle: white2TextStyle.copyWith(
                                    fontSize: 11,
                                    fontWeight: light,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  margin: const EdgeInsets.only(left: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    i == state.carts.length
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: CustomDivider(),
                          )
                        : const SizedBox(),
                  ],
                );
              }).toList(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
