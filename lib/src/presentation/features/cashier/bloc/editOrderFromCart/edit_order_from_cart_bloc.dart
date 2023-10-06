import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../../../data/dataSources/remote/cart_service.dart';

part 'edit_order_from_cart_event.dart';
part 'edit_order_from_cart_state.dart';

class EditOrderFromCartBloc
    extends Bloc<EditOrderFromCartEvent, EditOrderFromCartState> {
  EditOrderFromCartBloc() : super(const EditOrderFromCartState()) {
    on<GetDataCart>(_getDataCart);
    on<AddMenusCart>(_addMenus);
    on<EditSearchMenu>(_searchMenu);
    on<EditOrderIncrementPressed>(_orderIncrementPressed);
    on<EditOrderDecrementPressed>(_orderDecrementPressed);
    on<EditOrderCheckoutPressed>(_orderCheckoutPressed);
    on<EditResetState>(_resetState);
  }

  /// variabel untuk menampung menu yang ditambahkan
  final List<_EditMenu> _listMenuOrders = [];

  // bool _isfFromCart = false;
  // get isFromCart => _isfFromCart;
  // set setIsFromCart(bool newValue) {
  //   _isfFromCart = newValue;
  // }

  // CartModel _cart = const CartModel();
  // get cart => _cart;
  // set setCart(CartModel newValue) {
  //   _cart = newValue;
  // }

  int _totalPrice() {
    int totalPrice = 0;
    for (var item in _listMenuOrders) {
      totalPrice += item.price * item.totalBuy;
    }

    return totalPrice;
  }

  /// jika [_listMenuOrders] kosong atau variabel [index] -1
  /// return true
  bool _isCanAddToListMenuOrders(String id) {
    int index = _listMenuOrders.indexWhere((menu) => menu.id == id);
    if (_listMenuOrders.isEmpty || index == -1) {
      return true;
    }
    return false;
  }

  void _resetState(EditResetState event, Emitter<EditOrderFromCartState> emit) {
    _listMenuOrders.clear();
    emit(const EditOrderFromCartState(
      id: '',
      buyer: '',
      dateTimeOrder: null,
      menuOrders: [],
      listMenuSearch: [],
      total: 0,
    ));
  }

  void _getDataCart(
      GetDataCart event, Emitter<EditOrderFromCartState> emit) async {
    final cart = await CartService().fetchCartById(event.id);

    for (final menuOrder in cart.listMenus!) {
      if (_isCanAddToListMenuOrders(menuOrder['id'])) {
        _listMenuOrders.add(
          _EditMenu(
            id: menuOrder['id'],
            price: menuOrder['price'],
            menuName: menuOrder['menuName'],
            totalBuy: menuOrder['totalBuy'],
            hpp: menuOrder['hpp'],
            typeMenu: menuOrder['typeMenu'],
          ),
        );
      } else {
        int index =
            _listMenuOrders.indexWhere((menu) => menu.id == menuOrder['id']);
        _listMenuOrders[index] = _EditMenu(
          id: menuOrder['id'],
          price: menuOrder['price'],
          menuName: menuOrder['menuName'],
          totalBuy: menuOrder['totalBuy'],
          hpp: menuOrder['hpp'],
          typeMenu: menuOrder['typeMenu'],
        );
      }
    }

    emit(state.copyWith(
      id: cart.id,
      buyer: cart.buyer,
      dateTimeOrder: cart.dateTimeOrder,
      total: cart.total,
      menuOrders: _listMenuOrders,
    ));
  }

  void _addMenus(AddMenusCart event, Emitter<EditOrderFromCartState> emit) {
    if (_isCanAddToListMenuOrders(event.id)) {
      _listMenuOrders.add(
        _EditMenu(
          id: event.id,
          price: event.price,
          menuName: event.menuName,
          totalBuy: event.totalBuy,
          hpp: event.hpp,
          typeMenu: event.typeMenu,
        ),
      );
    }

    emit(state.copyWith(
      menuOrders: _listMenuOrders,
    ));
  }

  void _searchMenu(EditSearchMenu event, Emitter<EditOrderFromCartState> emit) {
    List<_EditMenu>? menuSearch = state.menuOrders!.where(
      (menu) {
        return menu.menuName.toLowerCase().contains(event.query.toLowerCase());
      },
    ).toList();

    emit(state.copyWith(listMenuSearch: menuSearch));
  }

  _orderIncrementPressed(
      EditOrderIncrementPressed event, Emitter<EditOrderFromCartState> emit) {
    int index = _listMenuOrders.indexWhere((menu) => menu.id == event.id);

    // increment total buy sesuai dengan data list menu order
    _listMenuOrders[index].totalBuy++;
    emit(state.copyWith(
      total: _totalPrice(),
      menuOrders: _listMenuOrders,
    ));
  }

  _orderDecrementPressed(
      EditOrderDecrementPressed event, Emitter<EditOrderFromCartState> emit) {
    int index = _listMenuOrders.indexWhere((menu) => menu.id == event.id);

    // decrement total buy sesuai dengan data list menu order
    _listMenuOrders[index].totalBuy--;

    emit(state.copyWith(
      total: _totalPrice(),
      menuOrders: _listMenuOrders,
    ));
  }

  void _orderCheckoutPressed(
      EditOrderCheckoutPressed event, Emitter<EditOrderFromCartState> emit) {
    DateTime dateTime = DateTime.now();

    /// format: year month day HOUR24_MINUTE_SECOND
    String dateFormat = DateFormat('yyyMdHms').format(dateTime);
    String id = 'oid$dateFormat';

    emit(state.copyWith(
      id: id,
      dateTimeOrder: dateTime,
      menuOrders: _listMenuOrders,
    ));
  }
}
