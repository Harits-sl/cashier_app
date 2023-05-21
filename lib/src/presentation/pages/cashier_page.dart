import 'package:cashier_app/src/data/models/cart_model.dart';
import 'package:cashier_app/src/data/models/menu_model.dart';
import 'package:cashier_app/src/presentation/widgets/custom_divider.dart';

import '../../config/route/routes.dart';
import '../cubit/Menu/menu_cubit.dart';

import '../../data/models/menu_order_model.dart';
import '../cubit/menu_order/menu_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/route/go.dart';
import '../../core/shared/theme.dart';
import '../../core/utils/string_helper.dart';
import '../widgets/item_menu.dart';

class CashierPage extends StatefulWidget {
  static const String routeName = '/cashier';

  // final BlueThermalPrinter printer;

  const CashierPage({
    // required this.printer,
    Key? key,
  }) : super(key: key);

  @override
  State<CashierPage> createState() => _CashierPageState();
}

class _CashierPageState extends State<CashierPage> {
  // final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>>? menus;
  List<Map<String, dynamic>>? searchMenus;
  MenuOrderModel? menuOrder;
  late MenuOrderCubit menuOrderCubit;
  late CartModel carts;
  bool isSearch = false;
  int totalOrder = 0;
  int totalOrderFromCart = 0;

  @override
  void initState() {
    super.initState();

    // menjalankan fungsi cubit json menu
    context.read<MenuCubit>().getAllMenu();

    menuOrderCubit = context.read<MenuOrderCubit>();
    carts = menuOrderCubit.cart;
    // if (carts.id != null) {
    //   menuOrderCubit.getDataFromCart();
    //   debugPrint('cart: ${cart}');
    // }
  }

  @override
  void didUpdateWidget(covariant CashierPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('oldWidget: $oldWidget');
  }

  @override
  void dispose() {
    // _searchController.dispose();
    totalOrder = 0;
    super.dispose();
  }

  void _search(String query) {
    if (query.isNotEmpty) {
      isSearch = true;

      context.read<MenuCubit>().searchMenu(query);
    } else {
      isSearch = false;
      setState(() {});
      // context.read<MenuCubit>().getAllMenu();
      // _menuOrderModel
    }
  }

  void checkOutPressed() {
    if (menuOrder!.listMenus!.isNotEmpty) {
      context.read<MenuOrderCubit>().orderCheckoutPressed();
      Go.routeWithPath(context: context, path: Routes.orderInfo);
    }
  }

  void backPressed() {
    Go.back(context);
  }

  void cartPressed() {
    Go.routeWithPathAndRemove(context: context, path: Routes.cart);
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildAppBar() {
      return Container(
        padding: const EdgeInsets.all(defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: backPressed,
              child: Image.asset(
                'assets/images/ic_back.png',
                width: 30,
              ),
            ),
            Text(
              'Cashier',
              style: primaryTextStyle.copyWith(
                fontWeight: semiBold,
              ),
            ),
            GestureDetector(
              onTap: cartPressed,
              child: Image.asset(
                'assets/images/ic_cart.png',
                width: 30,
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildSearch() {
      return Container(
        margin: const EdgeInsets.only(bottom: defaultMargin),
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: TextField(
          // controller: _searchController,
          onSubmitted: (String query) {
            // _search(query);
            // TODO: CAN SEARCH MENU
          },
          // enabled: false,
          style: primaryTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 12,
          ),
          cursorColor: primaryColor,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            hintText: 'Search menu...',
            prefixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
              child: ImageIcon(
                const AssetImage(
                  'assets/images/ic_search.png',
                ),
                size: 26,
                color: gray2Color,
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildMenu() {
      Widget _title(String title) {
        return Text(
          title,
          style: primaryTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 16,
          ),
        );
      }

      Widget _menu(List<MenuModel> listMenu) {
        return Column(
          children: (listMenu).map((menu) {
            int totalOrderFromCart = 0;

            /// jika data cart tidak kosong
            /// maka lakukan perulangan data [carts.listMenus]
            if (carts.id != null) {
              for (var cart in carts.listMenus!) {
                /// jika menu id sama dengan cart id
                /// maka ubah [totalOrderFromCart]
                /// menjadi datanya [cart]
                if (menu.id == cart['id']) {
                  totalOrderFromCart = cart['totalBuy'];
                }
                // setState(() {});
              }
            }
            return Column(
              children: [
                ItemMenu(
                  id: menu.id,
                  name: menu.name,
                  price: menu.price,
                  hpp: menu.price,
                  totalOrder:
                      totalOrderFromCart > 0 ? totalOrderFromCart : totalOrder,
                ),
              ],
            );
          }).toList(),
        );
      }

      return Container(
        margin: const EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: BlocBuilder<MenuCubit, MenuState>(
          buildWhen: (previousState, state) {
            debugPrint('state: $state');
            debugPrint('previousState: $previousState');
            setState(() {});
            return true;
          },
          builder: (context, state) {
            if (state is MenuLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is MenuSuccess) {
              if (!isSearch) {
                menus ??= state.menu;
              } else {
                searchMenus = state.menu;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (!isSearch ? menus : searchMenus)!.map((item) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title(item['typeMenu']),
                      const SizedBox(height: 12),
                      const CustomDivider(),
                      _menu(item['menu']),
                      const SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              );
            }
            if (state is MenuFailed) {
              print(state.error);
              return Text(state.error);
            }
            return const SizedBox();
          },
        ),
      );
    }

    Widget _buttonCheckout() {
      return BlocBuilder<MenuOrderCubit, MenuOrderState>(
        builder: (context, state) {
          num totalBuy = 0;
          // MenuOrderModel menuOrder = const MenuOrderModel();
          if (state is MenuOrderSuccess) {
            menuOrder = state.menuOrder;
            for (var item in menuOrder!.listMenus!) {
              totalBuy += item['totalBuy'];
            }
          } else {
            menuOrder = const MenuOrderModel(
              id: '',
              listMenus: [],
              total: 0,
              dateTimeOrder: null,
            );
          }

          return GestureDetector(
            onTap: checkOutPressed,
            child: Container(
              height: 55,
              margin: const EdgeInsets.all(defaultMargin),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: totalBuy > 0 ? primaryColor : gray2Color,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(.25),
                    offset: const Offset(0, 12),
                    blurRadius: 27,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your added $totalBuy items',
                    style: totalBuy > 0
                        ? white2TextStyle.copyWith(
                            fontSize: 12,
                          )
                        : primaryTextStyle.copyWith(
                            fontSize: 12,
                          ),
                  ),
                  Row(
                    children: [
                      Image.asset('assets/images/ic_bag.png',
                          width: 18,
                          color: totalBuy > 0 ? backgroundColor : primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        'Rp. ${StringHelper.addComma(menuOrder!.total)}',
                        style: totalBuy > 0
                            ? white2TextStyle.copyWith(
                                fontSize: 12,
                              )
                            : primaryTextStyle.copyWith(
                                fontSize: 12,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    Widget _buildBody() {
      return SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                _buildAppBar(),
                _buildSearch(),
                _buildMenu(),
                // spasi dari menu ke widget checkout button
                const SizedBox(height: defaultMargin + 55),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buttonCheckout(),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        context.read<MenuOrderCubit>().initState();
        totalOrder = 0;
        totalOrderFromCart = 0;
        return true;
      },
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }
}
