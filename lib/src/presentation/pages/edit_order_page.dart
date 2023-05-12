import 'package:cashier_app/src/data/models/cart_model.dart';
import 'package:cashier_app/src/data/models/menu_model.dart';
import 'package:cashier_app/src/presentation/widgets/custom_button.dart';

import '../../config/route/routes.dart';
import '../cubit/Menu/menu_cubit.dart';

import '../../data/models/menu_order_model.dart';
import '../cubit/buyer/buyer_cubit.dart';
import '../cubit/menu_order/menu_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/route/go.dart';
import '../../core/shared/theme.dart';
import '../../core/utils/string_helper.dart';
import '../widgets/item_menu.dart';

class EditOrderPage extends StatefulWidget {
  // final BlueThermalPrinter printer;

  const EditOrderPage({
    // required this.printer,
    Key? key,
  }) : super(key: key);

  @override
  State<EditOrderPage> createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
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
  void didUpdateWidget(covariant EditOrderPage oldWidget) {
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
      CartModel cart = CartModel.fromMenuOrderModel(menuOrder!).copyWith(
        id: carts.id,
        dateTimeOrder: carts.dateTimeOrder,
        buyer: carts.buyer,
      );
      debugPrint('menuOrder: ${menuOrder}');
      context.read<MenuOrderCubit>().setCart = cart;
      // context.read<MenuOrderCubit>().orderCheckoutPressed();
      Go.routeWithPath(context: context, path: Routes.selectPayment);
    }
  }

  void cartPressed() {
    Go.routeWithPathAndRemove(context: context, path: Routes.cart);
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildSearch() {
      return Container(
        margin: EdgeInsets.all(defaultMargin),
        child: TextField(
          // controller: _searchController,
          onSubmitted: (String query) {
            // _search(query);
          },
          enabled: false,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.fromLTRB(0, 13, 13, 13),
            hintText: 'Cari menu...',
            hintStyle: grayTextStyle.copyWith(fontWeight: light, fontSize: 14),
            prefixIcon: const Padding(
              padding: EdgeInsets.fromLTRB(15, 11, 20, 11),
              child: ImageIcon(
                AssetImage('assets/images/ic_search.png'),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: lightGrayColor, width: 2),
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: blueColor, width: 2),
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
          ),
        ),
      );
    }

    Widget _buildBuyer() {
      return Padding(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          bottom: 12,
        ),
        child: Text(
          'pembeli: ${carts.buyer!}',
          style: blackTextStyle.copyWith(
            fontWeight: light,
            fontSize: 16,
          ),
        ),
      );
    }

    Widget _buildMenu() {
      Widget _title(String title) {
        return Text(
          title,
          style: blackTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 18,
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
                Divider(
                  thickness: 1,
                  height: 0,
                  color: lightGrayColor,
                ),
              ],
            );
          }).toList(),
        );
      }

      return Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: BlocBuilder<MenuCubit, MenuState>(
          buildWhen: (previousState, state) {
            debugPrint('state: $state');
            debugPrint('previousState: $previousState');
            // _menuOrderModel =
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
                      Divider(
                        thickness: 1,
                        height: 0,
                        color: lightGrayColor,
                      ),
                      _menu(item['menu']),
                      const SizedBox(height: 12),
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

    Widget _buildTotalAndBtnCheckout() {
      Widget _totalPriceAndItem(MenuOrderModel menuOrder) {
        num totalBuy = 0;
        for (var item in menuOrder.listMenus!) {
          totalBuy += item['totalBuy'];
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total | Item $totalBuy',
              style: blackTextStyle.copyWith(
                fontWeight: regular,
                fontSize: 14,
              ),
            ),
            Text(
              'Rp. ${StringHelper.addComma(menuOrder.total)}',
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 14,
              ),
            ),
          ],
        );
      }

      Widget _buttonCheckOut(MenuOrderModel menuOrder) {
        Color color = menuOrder.listMenus!.isNotEmpty ? blueColor : grayColor;

        return CustomButton(
          color: color,
          margin: EdgeInsets.only(top: defaultMargin, bottom: 24),
          borderRadius: BorderRadius.circular(8),
          onPressed: checkOutPressed,
          text: 'Checkout',
        );
      }

      return BlocBuilder<MenuOrderCubit, MenuOrderState>(
        builder: (context, state) {
          if (state is MenuOrderSuccess) {
            menuOrder = state.menuOrder;
          } else {
            menuOrder = const MenuOrderModel(
              id: '',
              listMenus: [],
              total: 0,
              dateTimeOrder: null,
            );
          }

          return Container(
            width: double.infinity,
            height: 140,
            padding: EdgeInsets.only(
              top: 20,
              left: defaultMargin,
              right: defaultMargin,
            ),
            decoration: BoxDecoration(
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  color: grayColor,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                _totalPriceAndItem(menuOrder!),
                _buttonCheckOut(menuOrder!),
              ],
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
                _buildSearch(),
                _buildBuyer(),
                _buildMenu(),
                // spasi dari menu ke widget _totalAndBtnCheckout
                SizedBox(
                  height: defaultMargin + 140,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildTotalAndBtnCheckout(),
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
        appBar: AppBar(
          leading: Container(),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                cartPressed();
              },
            ),
          ],
        ),
        body: _buildBody(),
      ),
    );
  }
}
