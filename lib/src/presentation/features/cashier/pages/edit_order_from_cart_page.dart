// import 'package:cashier_app/src/data/models/cart_model.dart';
import 'package:cashier_app/src/data/models/menu_model.dart';
import 'package:cashier_app/src/presentation/features/cashier/bloc/editOrderFromCart/edit_order_from_cart_bloc.dart';
import 'package:cashier_app/src/presentation/widgets/custom_button.dart';
import 'package:cashier_app/src/presentation/widgets/custom_divider.dart';

import '../../../../config/route/routes.dart';
import '../../../cubit/Menu/menu_cubit.dart';

import '../../../../data/models/menu_order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/route/go.dart';
import '../../../../core/shared/theme.dart';
import '../../../../core/utils/string_helper.dart';
import '../index.dart';

class EditOrderFromCartPage extends StatefulWidget {
  static const String routeName = '/edit-order-from-cart';

  const EditOrderFromCartPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  State<EditOrderFromCartPage> createState() => _EditOrderFromCartPageState();
}

class _EditOrderFromCartPageState extends State<EditOrderFromCartPage> {
  final TextEditingController _searchController = TextEditingController();

  List<MenuModel>? menus;
  // List<Map<String, dynamic>>? searchMenus;
  MenuOrderModel? menuOrder;
  late final MenuCubit menuCubit;
  late final EditOrderFromCartBloc editOrderBloc;
  // late CartModel carts;
  bool isSearch = false;
  int totalOrder = 0;
  int totalOrderFromCart = 0;

  @override
  void initState() {
    super.initState();
    editOrderBloc = context.read<EditOrderFromCartBloc>();
    editOrderBloc.add(GetDataCart(id: widget.id));

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

      editOrderBloc.add(EditSearchMenu(query: query));
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
      // editOrderBloc.add(OrderCheckoutPressed());
      context.read<MenuOrderBloc>().add(
            AddOrderFromCart(
              id: editOrderBloc.state.id!,
              menuOrders: editOrderBloc.state.menuOrders!,
              total: editOrderBloc.state.total!,
              dateTimeOrder: editOrderBloc.state.dateTimeOrder!,
              buyer: editOrderBloc.state.buyer!,
            ),
          );
      Go.routeWithPath(context: context, path: Routes.orderInfo);
    }
  }

  void backPressed() {
    editOrderBloc.add(EditResetState());

    Go.back(context);
  }

  void cartPressed() {
    Go.routeWithPath(context: context, path: Routes.cart);
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildDetailBuyer() {
      return Container(
        margin: const EdgeInsets.only(left: defaultMargin, bottom: 16),
        child: Text(
          'Buyer: ${editOrderBloc.state.buyer}',
          style: primaryTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
      );
    }

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
              'Edit Order',
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
      Widget _menu(String title, List menus) {
        final List? menusAccordingType =
            menus.where((menu) => menu.typeMenu == title).toList();

        return menusAccordingType!.isEmpty
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
                    children: (menusAccordingType).map((menu) {
                      print(menu.totalBuy);
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
                          EditItemMenu(
                            key: Key(menu.id),
                            id: menu.id,
                            name: menu.menuName,
                            price: menu.price,
                            hpp: menu.hpp,
                            totalOrder: menu.totalBuy,
                            typeMenu: menu.typeMenu,
                            quantityStock: 0,
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
                editOrderBloc.add(
                  AddMenusCart(
                    id: menu.id,
                    price: menu.price,
                    menuName: menu.name,
                    totalBuy: 0,
                    hpp: menu.hpp,
                    typeMenu: menu.typeMenu,
                  ),
                );
              }
            }
          },
          child: BlocBuilder<EditOrderFromCartBloc, EditOrderFromCartState>(
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _menu('coffee', menuOrders!),
                    _menu('non-coffee', menuOrders),
                    _menu('food', menuOrders),
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
      return BlocBuilder<EditOrderFromCartBloc, EditOrderFromCartState>(
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
                _buildDetailBuyer(),
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
        editOrderBloc.add(EditResetState());
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

class EditItemMenu extends StatefulWidget {
  final String id;
  final String name;
  final int price;
  final int hpp;
  final int totalOrder;
  final String typeMenu;
  final int quantityStock;
  final bool isDisabled;

  const EditItemMenu({
    Key? key,
    required this.id,
    required this.name,
    required this.price,
    required this.hpp,
    required this.totalOrder,
    required this.typeMenu,
    required this.quantityStock,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  State<EditItemMenu> createState() => _EditItemMenuState();
}

class _EditItemMenuState extends State<EditItemMenu> {
  late int _totalBuy;
  late String codeName;

  @override
  void initState() {
    super.initState();

    _totalBuy = widget.totalOrder;

    // jika nama menu lebih dari satu kata
    // maka lakukan split nama menu
    if (widget.name.split(' ').length > 1) {
      final split = widget.name.split(' ');
      codeName = split.map((str) => str[0]).join();
    } else {
      codeName = widget.name[0];
    }

    /// jika [_totalBuy] lebih dari 0 masukan data ke orderMenu
    // if (_totalBuy > 0) {
    //   context.read<MenuOrderBloc>().add(
    //         AddOrder(
    //           menu: Menu(
    //             id: widget.id,
    //             price: widget.price,
    //             menuName: widget.name,
    //             totalBuy: _totalBuy,
    //             hpp: widget.hpp,
    //             typeMenu: widget.typeMenu,
    //           ),
    //         ),
    //       );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: lightGray2Color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    codeName.toUpperCase(),
                    style: blackTextStyle.copyWith(fontWeight: semiBold),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp. ${StringHelper.addComma(widget.price)}',
                    style: secondaryTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: lightGray2Color,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (!widget.isDisabled) {
                      if (_totalBuy > 0) {
                        setState(() {
                          _totalBuy--;
                        });
                        context
                            .read<EditOrderFromCartBloc>()
                            .add(EditOrderDecrementPressed(id: widget.id));
                      }
                    }
                  },
                  child: Image.asset(
                    'assets/images/ic_minus.png',
                    width: 22,
                  ),
                ),
                SizedBox(
                  width: 24,
                  child: Text(
                    _totalBuy.toString(),
                    style: // jika quantity stock dengan totalbuy sudah sama, tidak bisa dibeli lagi
                        widget.quantityStock == _totalBuy || widget.isDisabled
                            ? gray2TextStyle.copyWith(
                                fontWeight: medium,
                                fontSize: 12,
                              )
                            : primaryTextStyle.copyWith(
                                fontWeight: medium,
                                fontSize: 12,
                              ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // jika quantity stock tidak lebih dari total buy
                    if (widget.quantityStock > _totalBuy) {
                      if (!widget.isDisabled) {
                        setState(() {
                          _totalBuy++;
                        });
                        context
                            .read<MenuOrderBloc>()
                            .add(OrderIncrementPressed(id: widget.id));
                      }
                    }
                  },
                  child: Image.asset(
                    'assets/images/ic_plus.png',
                    width: 22,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
