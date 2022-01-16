import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<Map<String, dynamic>?> {
  HomeCubit() : super(null);

  int totalPrice = 0;
  List<Map<String, dynamic>> arrMenus = [];

  void price({int? id, int? price = 0, String? menuName, int? qty}) {
    int _price = price!;
    int _qty = qty!;

    // print(qty);

    // if (qty == null) {
    //   _qty = 0;
    // } else {
    //   _qty = int.parse(qty);
    // }

    Map<String, dynamic> menus = {
      'id': id,
      'price': price,
      'menuName': menuName,
      'qty': _qty
    };

    int indexId = arrMenus.indexWhere((menu) => menu['id'] == id!);

    // if (_qty < 1) {
    //   arrMenus.removeAt(indexId);
    //   _price *= _qty;
    //   totalPrice -= _price;
    // } else {
    //   arrMenus.add(menus);
    //   _price *= _qty;
    //   totalPrice = _price;
    // }

    // print(arrMenus.length);
    // print(arrMenus);
    // if (arrMenus.length == 0) {
    //   arrMenus.add(menus);
    //   _price *= _qty;
    //   totalPrice = _price;
    // } else {
    //   for (var menu in arrMenus) {
    //     if (menu['id'] != indexId) {
    //       arrMenus.add(menus);
    //       _price *= _qty;
    //       totalPrice = _price;
    //     }
    //   }
    // }

    Map<String, dynamic> data = {
      'menus': arrMenus,
      'totalPrice': totalPrice,
    };

    print(data);

    emit(data);
  }
}
