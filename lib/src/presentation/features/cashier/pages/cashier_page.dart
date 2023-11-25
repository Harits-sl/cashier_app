// import 'package:cashier_app/src/data/models/cart_model.dart';

import 'dart:developer';

import 'package:cashier_app/src/data/models/menu_model.dart';
import 'package:cashier_app/src/presentation/widgets/custom_button.dart';
import 'package:cashier_app/src/presentation/widgets/custom_divider.dart';

import '../../../../config/route/routes.dart';
import '../../../cubit/Menu/menu_cubit.dart';

import '../../../../data/models/menu_order_model.dart';
import '../index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/route/go.dart';
import '../../../../core/shared/theme.dart';
import '../../../../core/utils/string_helper.dart';
import '../../../widgets/item_menu.dart';

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
  final TextEditingController _searchController = TextEditingController();

  List<MenuModel>? menus;
  // List<Map<String, dynamic>>? searchMenus;
  MenuOrderModel? menuOrder;
  late final MenuCubit menuCubit;
  late final MenuOrderBloc menuOrderBloc;
  // late CartModel carts;
  bool isSearch = false;
  int totalOrder = 0;
  int totalOrderFromCart = 0;

  @override
  void initState() {
    super.initState();
    menuOrderBloc = context.read<MenuOrderBloc>();

    // menjalankan fungsi cubit json menu
    menuCubit = context.read<MenuCubit>();
    menuCubit.getAllMenu();
    // if (menuCubit.state is MenuSuccess) {
    //   menuCubit.state.props.map((e) => debugPrint(e.toString()));
    //   // log(' menuCubit.state: ${state}');
    // }

    // carts = menuOrderCubit.cart;
    // if (carts.id != null) {
    //   menuOrderCubit.getDataFromCart();
    //   debugPrint('cart: ${cart}');
    // }
  }

  @override
  void dispose() {
    _searchController.dispose();
    totalOrder = 0;
    super.dispose();
  }

  void _search(String query) {
    if (query.isNotEmpty) {
      isSearch = true;

      menuOrderBloc.add(SearchMenu(query: query));
      setState(() {});
    } else {
      isSearch = false;
      setState(() {});
      // context.read<MenuCubit>().getAllMenu();
      // _menuOrderModel
    }
  }

  void checkOutPressed() {
    if (menuOrder!.total != 0) {
      menuOrderBloc.add(OrderCheckoutPressed());
      Go.routeWithPath(context: context, path: Routes.orderInfo);
    }
  }

  void backPressed() {
    menuOrderBloc.add(ResetState());
    Go.back(context);
  }

  void cartPressed() {
    Go.routeWithPath(context: context, path: Routes.cart);
  }

  @override
  Widget build(BuildContext context) {
    menuCubit.getAllMenu();
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
          controller: _searchController,
          onSubmitted: (String query) {
            _search(query);
          },
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
      // Widget _title(String title) {
      //   return Padding(
      //     padding: const EdgeInsets.only(bottom: 12),
      //     child: Text(
      //       title,
      //       style: primaryTextStyle.copyWith(
      //         fontWeight: semiBold,
      //         fontSize: 16,
      //       ),
      //     ),
      //   );
      // }

      Widget _menu(String title, List menus) {
        return menus.isEmpty
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      title,
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const CustomDivider(),
                  Column(
                    children: menus.map((menu) {
                      debugPrint('${menu.id}');
                      // int totalOrderFromCart = 0;
                      /// jika data cart tidak kosong
                      /// maka lakukan perulangan data [carts.listMenus]
                      // if (carts.id != null) {
                      //   for (var cart in carts.listMenus!) {
                      //     /// jika menu id sama dengan cart id
                      //     /// maka ubah [totalOrderFromCart]
                      //     /// menjadi datanya [cart]
                      //     if (menu.id == cart['id']) {
                      //       totalOrderFromCart = cart['totalBuy'];
                      //     }
                      //     // setState(() {});
                      //   }
                      // }
                      return Column(
                        children: [
                          ItemMenu(
                            key: Key(menu.id),
                            id: menu.id,
                            name: menu.menuName,
                            price: menu.price,
                            hpp: menu.hpp,
                            totalOrder: menu.totalBuy,
                            typeMenu: menu.typeMenu,
                            quantityStock: menu.quantityStock,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],
              );
      }

      return Container(
        margin: const EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: BlocListener<MenuCubit, MenuState>(
          listener: (context, state) {
            if (state is MenuSuccess) {
              // if (!isSearch) {
              //   menus ??= state.menu;
              // } else {
              //   searchMenus = state.menu;
              // }
              for (var menu in state.menu) {
                menuOrderBloc.add(
                  AddMenus(
                    id: menu.id,
                    price: menu.price,
                    menuName: menu.name,
                    totalBuy: 0,
                    hpp: menu.hpp,
                    typeMenu: menu.typeMenu,
                    quantityStock: menu.quantity!,
                    minimumQuantityStock: menu.minimumQuantity!,
                  ),
                );
              }
            }
          },
          child: BlocBuilder<MenuOrderBloc, MenuOrderState>(
            builder: (context, state) {
              List? menuOrders;
              if (!isSearch) {
                menuOrders = state.menuOrders;
              } else {
                menuOrders = state.listMenuSearch;
              }

              if (state.menuOrders == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.menuOrders != null) {
                // list menu untuk minuman
                final List? listDrinks = menuOrders!
                    .where((menu) =>
                        menu.typeMenu == 'coffee' ||
                        menu.typeMenu == 'non-coffee')
                    .toList();

                // list menu untuk makanan
                final List? listFoods = menuOrders
                    .where((menu) => menu.typeMenu == 'food')
                    .toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _menu('drinks', listDrinks!),
                    // _menu('non-coffee', menuOrders),
                    _menu('food', listFoods!),
                  ],
                );
              } else {
                return const Text('Please Try Again');
              }
            },
          ),
        ),
      );
    }

    Widget _buttonCheckout() {
      return BlocBuilder<MenuOrderBloc, MenuOrderState>(
        builder: (context, state) {
          num totalBuy = 0;
          // MenuOrderModel menuOrder = const MenuOrderModel();
          if (state.menuOrders != null) {
            menuOrder = menuOrder = MenuOrderModel(
              listMenus: state.menuOrders,
              total: state.total ?? 0,
            );
            for (var item in menuOrder!.listMenus!) {
              totalBuy += item.totalBuy;
            }
          } else {
            menuOrder = const MenuOrderModel(
              id: '',
              listMenus: [],
              total: 0,
              dateTimeOrder: null,
            );
          }

          return CustomButtonWithIcon(
            color: totalBuy > 0 ? primaryColor : gray2Color,
            onPressed: checkOutPressed,
            isShadowed: true,
            text: 'Your added $totalBuy items',
            iconUrl: 'assets/images/ic_bag.png',
            iconColor: totalBuy > 0 ? backgroundColor : primaryColor,
            iconText: 'Rp. ${StringHelper.addComma(menuOrder!.total)}',
            textStyle: totalBuy > 0
                ? white2TextStyle.copyWith(
                    fontSize: 12,
                  )
                : primaryTextStyle.copyWith(
                    fontSize: 12,
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
        menuOrderBloc.add(ResetState());
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
