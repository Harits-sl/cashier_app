import 'package:cashier_app/src/presentation/cubit/Menu/menu_cubit.dart';

import '../../data/models/menu_order_model.dart';
import '../cubit/menu_order/menu_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/route/go.dart';
import '../../core/shared/theme.dart';
import '../../core/utils/string_helper.dart';
import '../widgets/menu_item.dart';
import 'select_payment_page.dart';

class HomePage extends StatefulWidget {
  // final BlueThermalPrinter printer;

  const HomePage({
    // required this.printer,
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>>? menus;
  List<Map<String, dynamic>>? searchMenus;

  bool isSearch = false;

  MenuOrderModel? menuOrder;

  @override
  void initState() {
    super.initState();

    // menjalankan fungsi cubit json menu
    context.read<MenuCubit>().getAllMenu();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('oldWidget: $oldWidget');
  }

  @override
  void dispose() {
    // _searchController.dispose();
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

  @override
  Widget build(BuildContext context) {
    Widget _buildSearch() {
      return Container(
        margin: EdgeInsets.all(defaultMargin),
        child: TextField(
          // controller: _searchController,
          onSubmitted: (String query) {
            _search(query);
          },
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

      Widget _menu(List listMenu) {
        return Column(
          children: (listMenu)
              .map(
                (menu) => Column(
                  children: [
                    MenuItem(
                      menu: menu,
                      totalOrder: 0,
                    ),
                    Divider(
                      thickness: 1,
                      height: 0,
                      color: lightGrayColor,
                    ),
                  ],
                ),
              )
              .toList(),
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
              debugPrint('isSearch: $isSearch');

              for (var item in menus!) {
                debugPrint('item: $item');
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (!isSearch ? menus : searchMenus)!.map((item) {
                  debugPrint('item: $item');

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
        return Container(
          width: double.infinity,
          height: 50,
          margin: EdgeInsets.only(top: defaultMargin, bottom: 24),
          decoration: BoxDecoration(
            color: menuOrder.listMenus!.isNotEmpty ? blueColor : grayColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextButton(
            onPressed: () {
              if (menuOrder.listMenus!.isNotEmpty) {
                context.read<MenuOrderCubit>().orderCheckoutPressed();
                Go.to(context, SelectPaymentPage());
              }
            },
            child: Text(
              'Checkout',
              style: whiteTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 16,
              ),
            ),
          ),
        );
      }

      return BlocBuilder<MenuOrderCubit, MenuOrderState>(
        builder: (context, state) {
          if (state is MenuOrderSuccess) {
            menuOrder = state.menuOrder;

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
          } else {
            menuOrder = const MenuOrderModel(
              id: '',
              listMenus: [],
              total: 0,
              dateTimeOrder: null,
            );
          }

          return const SizedBox();
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

    return Scaffold(
      body: _buildBody(),
    );
  }
}
