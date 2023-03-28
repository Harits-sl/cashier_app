import 'package:bloc/bloc.dart';
import '../../../data/dataSources/remote/order_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/menu_order_model.dart';

part 'menu_order_event.dart';
part 'menu_order_state.dart';

class MenuOrderCubit extends Cubit<MenuOrderState> {
  MenuOrderCubit() : super(MenuOrderInitial());

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

  String? _id;

  DateTime? _dateTime;

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
    _id = null;
    _dateTime = null;

    debugPrint('_menuOrderModel: $_menuOrderModel');

    emit(MenuOrderInitial());
  }

  void _addTotalPrice() {
    _totalPrice = 0;

    for (var item in _listMenu) {
      _totalPrice += item['price'] * item['totalBuy'];
    }
  }

  void orderMenu({
    String? id,
    int price = 0,
    String? menuName,
    int totalBuy = 0,
    int hpp = 0,
  }) {
    _mapMenu = {
      'id': id,
      'price': price,
      'menuName': menuName,
      'totalBuy': totalBuy,
      'hpp': hpp,
    };

    /// variabel berupa integer dari indexWhere
    int index = _listMenu.indexWhere((menu) => menu['id'] == _mapMenu['id']);

    if (_listMenu.isEmpty || index == -1) {
      _listMenu.add(_mapMenu);
    } else {
      _listMenu[index]['totalBuy'] = totalBuy;

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

    emit(MenuOrderSuccess(_menuOrderModel));
  }

  void orderCheckoutPressed() {
    _dateTime = DateTime.now();

    /// format: year month day HOUR24_MINUTE_SECOND
    String dateFormat = DateFormat('yyyMdHms').format(_dateTime!);

    _id = 'oid$dateFormat';

    _menuOrderModel = _menuOrderModel.copyWith(
      id: _id,
      dateTimeOrder: _dateTime,
    );

    emit(MenuOrderSuccess(_menuOrderModel));
  }

  void orderTypePaymentPressed(
    String typePayment,
  ) {
    _menuOrderModel = _menuOrderModel.copyWith(
      typePayment: typePayment,
    );

    emit(MenuOrderSuccess(_menuOrderModel));
  }

  void orderAddCashAndChangePayment({required int cash, required int change}) {
    _menuOrderModel = _menuOrderModel.copyWith(
      cash: cash,
      change: change,
    );

    emit(MenuOrderSuccess(_menuOrderModel));
  }

  void addOrderToFirestore(MenuOrderModel menuOrder) async {
    OrderService().addOrder(menuOrder);
  }

  void addBuyerName(String buyer) {
    _menuOrderModel = _menuOrderModel.copyWith(
      buyer: buyer,
    );
    emit(MenuOrderSuccess(_menuOrderModel));
  }

  void checkoutFromCart(MenuOrderModel menuOrder) {
    emit(MenuOrderSuccess(menuOrder));
  }
}
