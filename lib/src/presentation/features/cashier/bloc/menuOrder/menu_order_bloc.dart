import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/data/dataSources/remote/cart_service.dart';
import 'package:cashier_app/src/data/dataSources/remote/order_service.dart';
import 'package:cashier_app/src/data/models/cart_model.dart';
import 'package:cashier_app/src/data/models/menu_order_model.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'menu_order_event.dart';
part 'menu_order_state.dart';

class MenuOrderBloc extends Bloc<MenuOrderEvent, MenuOrderState> {
  MenuOrderBloc() : super(const MenuOrderState()) {
    on<AddMenus>(_addMenus);
    on<SearchMenu>(_searchMenu);
    on<OrderIncrementPressed>(_orderIncrementPressed);
    on<OrderDecrementPressed>(_orderDecrementPressed);
    on<OrderCheckoutPressed>(_orderCheckoutPressed);
    on<OrderTypePaymentPressed>(_orderTypePaymentPressed);
    on<AddCashAndChangePayment>(_addCashAndChangePayment);
    on<AddBuyerName>(_addBuyerName);
    on<AddOrderToCart>(_addOrderToCart);
    on<AddOrderFromCart>(_addOrderFromCart);
    on<AddOrderToFirestore>(_addOrderToFirestore);
    on<ResetState>(_resetState);
  }

  /// variabel untuk menampung menu yang ditambahkan
  final List<_Menu> _listMenuOrders = [];

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

  void _resetState(ResetState event, Emitter<MenuOrderState> emit) {
    _listMenuOrders.clear();
    emit(const MenuOrderState(
      id: '',
      buyer: '',
      cash: 0,
      change: 0,
      dateTimeOrder: null,
      menuOrders: [],
      listMenuSearch: [],
      total: 0,
      typePayment: '',
    ));
  }

  void _addMenus(AddMenus event, Emitter<MenuOrderState> emit) {
    if (_isCanAddToListMenuOrders(event.id)) {
      _listMenuOrders.add(
        _Menu(
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

  void _searchMenu(SearchMenu event, Emitter<MenuOrderState> emit) {
    List<_Menu>? menuSearch = state.menuOrders!.where(
      (menu) {
        return menu.menuName.toLowerCase().contains(event.query.toLowerCase());
      },
    ).toList();

    emit(state.copyWith(listMenuSearch: menuSearch));
  }

  _orderIncrementPressed(
      OrderIncrementPressed event, Emitter<MenuOrderState> emit) {
    int index = _listMenuOrders.indexWhere((menu) => menu.id == event.id);

    // increment total buy sesuai dengan data list menu order
    _listMenuOrders[index].totalBuy++;
    emit(state.copyWith(
      total: _totalPrice(),
      menuOrders: _listMenuOrders,
    ));
  }

  _orderDecrementPressed(
      OrderDecrementPressed event, Emitter<MenuOrderState> emit) {
    int index = _listMenuOrders.indexWhere((menu) => menu.id == event.id);

    // decrement total buy sesuai dengan data list menu order
    _listMenuOrders[index].totalBuy--;

    emit(state.copyWith(
      total: _totalPrice(),
      menuOrders: _listMenuOrders,
    ));
  }

  void _orderCheckoutPressed(
      OrderCheckoutPressed event, Emitter<MenuOrderState> emit) {
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

  void _orderTypePaymentPressed(
      OrderTypePaymentPressed event, Emitter<MenuOrderState> emit) {
    emit(state.copyWith(
      typePayment: event.typePayment,
    ));
  }

  void _addCashAndChangePayment(
      AddCashAndChangePayment event, Emitter<MenuOrderState> emit) {
    emit(state.copyWith(
      cash: event.cash,
      change: event.change,
    ));
  }

  void _addOrderFromCart(AddOrderFromCart event, Emitter<MenuOrderState> emit) {
    List<_Menu> menuOrders = event.menuOrders
        .map((order) => _Menu(
              id: order.id,
              price: order.price,
              menuName: order.menuName,
              totalBuy: order.totalBuy,
              hpp: order.hpp,
              typeMenu: order.typeMenu,
            ))
        .toList();

    emit(state.copyWith(
      id: event.id,
      buyer: event.buyer,
      menuOrders: menuOrders,
      dateTimeOrder: event.dateTimeOrder,
      total: event.total,
    ));
  }

  void _addOrderToFirestore(
      AddOrderToFirestore event, Emitter<MenuOrderState> emit) async {
    // find total buy more than 0,
    // and change menuOrders from [_Menu] to map
    List listMenus = state.menuOrders!
        .where((order) => order.totalBuy != 0)
        .map((o) => o.toMap())
        .toList();

    MenuOrderModel menuOrder = MenuOrderModel(
      id: state.id,
      buyer: state.buyer,
      cash: state.cash!,
      change: state.change!,
      dateTimeOrder: state.dateTimeOrder,
      listMenus: listMenus,
      total: state.total!,
      typePayment: state.typePayment,
    );

    OrderService().addOrder(menuOrder);
    CartService().deleteCart(menuOrder.id!);
  }

  void _addBuyerName(AddBuyerName event, Emitter<MenuOrderState> emit) {
    emit(state.copyWith(
      buyer: event.buyer,
    ));
  }

  void _addOrderToCart(AddOrderToCart event, Emitter<MenuOrderState> emit) {
    // find total buy more than 0,
    // and change menuOrders from [_Menu] to map
    List listMenus = state.menuOrders!
        .where((order) => order.totalBuy != 0)
        .map((o) => o.toMap())
        .toList();

    CartModel cartOrder = CartModel(
      id: state.id,
      buyer: state.buyer,
      dateTimeOrder: state.dateTimeOrder,
      listMenus: listMenus,
      total: state.total!,
    );

    CartService().insertCart(cartOrder);
  }
}
