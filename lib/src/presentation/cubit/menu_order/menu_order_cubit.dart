import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/data/dataSources/remote/cart_service.dart';
import 'package:cashier_app/src/data/models/cart_model.dart';
import '../../../data/dataSources/remote/order_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/menu_order_model.dart';

part 'menu_order_event.dart';
part 'menu_order_state.dart';

class MenuOrderBloc extends Bloc<MenuOrderEvent, MenuOrderState> {
  MenuOrderBloc() : super(const MenuOrderState()) {
    on<AddOrder>(_addorder);
    on<OrderCheckoutPressed>(_orderCheckoutPressed);
    on<OrderTypePaymentPressed>(_orderTypePaymentPressed);
    on<AddCashAndChangePayment>(_addCashAndChangePayment);
    // on<AddCashAndChangePayment>(_addCashAndChangePayment);
    on<AddBuyerName>(_addBuyerName);
  }

  /// variabel untuk keseluruhan harga menu
  num _totalPrice = 0;

  /// variabel untuk menampung menu yang ditambahkan
  final List<Map<String, dynamic>> _listMenu = [];

  /// variabel untuk meng-Map data dari parameter
  /// [insertMenu] berupa id, price, menuName
  Map<String, dynamic> _mapMenu = {};

  /// variabel yang akan mengembalikan atau emit dari
  ///  variabel [listMenu] dan [totalPrice]
  Map<String, dynamic> _data = {};

  // String? _id;

  DateTime? _dateTime;

  bool _isfFromCart = false;
  get isFromCart => _isfFromCart;
  set setIsFromCart(bool newValue) {
    _isfFromCart = newValue;
  }

  CartModel _cart = const CartModel();
  get cart => _cart;
  set setCart(CartModel newValue) {
    _cart = newValue;
  }

  MenuOrderModel _menuOrderModel = const MenuOrderModel(
    id: '',
    total: 0,
    listMenus: [],
    dateTimeOrder: null,
    typePayment: '',
  );

  void initState() {
    _menuOrderModel = const MenuOrderModel(
      id: '',
      total: 0,
      listMenus: [],
      dateTimeOrder: null,
      typePayment: '',
    );
    _totalPrice = 0;
    _listMenu.clear();
    _mapMenu = {};
    _data = {};
    // _id = null;
    _dateTime = null;
    _cart = const CartModel();

    debugPrint('_menuOrderModel: $_menuOrderModel');

    // emit(MenuOrderInitial());
  }

  void _addTotalPrice() {
    _totalPrice = 0;

    for (var item in _listMenu) {
      _totalPrice += item['price'] * item['totalBuy'];
    }
  }

  void _addorder(AddOrder event, Emitter<MenuOrderState> emit) {
    _mapMenu = {
      'id': event.id,
      'price': event.price,
      'menuName': event.menuName,
      'totalBuy': event.totalBuy,
      'hpp': event.hpp,
      'typeMenu': event.typeMenu,
    };

    /// variabel berupa integer dari indexWhere
    int index = _listMenu.indexWhere((menu) => menu['id'] == _mapMenu['id']);

    if (_listMenu.isEmpty || index == -1) {
      _listMenu.add(_mapMenu);
    } else {
      _listMenu[index]['totalBuy'] = event.totalBuy;

      if (_listMenu[index]['totalBuy'] == 0) {
        _listMenu.remove(_listMenu[index]);
      }
    }

    _addTotalPrice();

    _data = {
      'listMenu': _listMenu,
      'totalPrice': _totalPrice,
    };

    _menuOrderModel = _menuOrderModel.copyWith(
      total: _data['totalPrice'],
      listMenus: _data['listMenu'],
    );

    // emit(MenuOrderSuccess(_menuOrderModel));
    emit(state.copyWith(
      total: _menuOrderModel.total,
      menuOrders: _menuOrderModel.listMenus,
    ));
  }

  void _orderCheckoutPressed(
      OrderCheckoutPressed event, Emitter<MenuOrderState> emit) {
    _dateTime = DateTime.now();

    /// format: year month day HOUR24_MINUTE_SECOND
    String dateFormat = DateFormat('yyyMdHms').format(_dateTime!);
    String id = 'oid$dateFormat';

    _menuOrderModel = _menuOrderModel.copyWith(
      id: id,
      dateTimeOrder: _dateTime,
    );

    // emit(MenuOrderSuccess(_menuOrderModel));
    emit(state.copyWith(
      id: id,
      dateTimeOrder: _dateTime,
    ));
  }

  void _orderTypePaymentPressed(
      OrderTypePaymentPressed event, Emitter<MenuOrderState> emit) {
    _menuOrderModel = _menuOrderModel.copyWith(
      typePayment: event.typePayment,
    );

    // emit(MenuOrderSuccess(_menuOrderModel));
    emit(state.copyWith(
      typePayment: event.typePayment,
    ));
  }

  void _addCashAndChangePayment(
      AddCashAndChangePayment event, Emitter<MenuOrderState> emit) {
    // _menuOrderModel = _menuOrderModel.copyWith(
    //   cash: cash,
    //   change: change,
    // );
    emit(state.copyWith(
      cash: event.cash,
      change: event.change,
    ));

    // emit(MenuOrderSuccess(_menuOrderModel));
  }

  void addOrderToFirestore(MenuOrderModel menuOrder) async {
    log('menuOrder: ${menuOrder}');
    OrderService().addOrder(menuOrder);
    // CartService().deleteCart(menuOrder.id!);
  }

  void _addBuyerName(AddBuyerName event, Emitter<MenuOrderState> emit) {
    // _menuOrderModel = _menuOrderModel.copyWith(
    //   buyer: event.buyer,
    // );
    // emit(MenuOrderSuccess(_menuOrderModel));
    emit(state.copyWith(
      buyer: event.buyer,
    ));
  }

  // void checkoutFromCart(MenuOrderModel menuOrder) {
  //   emit(MenuOrderSuccess(menuOrder));
  // }

  // void getDataFromCart() {
  //   // final cartData = CartService().fetchCartById(cart.id!);
  //   final menuOrder = MenuOrderModel.fromCartModel(_cart);
  //   _menuOrderModel = _menuOrderModel.copyWith(
  //     id: menuOrder.id,
  //     buyer: menuOrder.buyer,
  //     dateTimeOrder: menuOrder.dateTimeOrder,
  //     listMenus: menuOrder.listMenus,
  //     total: menuOrder.total,
  //   );

  //   emit(MenuOrderSuccess(_menuOrderModel));
  // }
}
