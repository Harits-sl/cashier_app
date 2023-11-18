part of 'menu_order_bloc.dart';

class MenuOrderState extends Equatable {
  final String? id;
  final List<_Menu>? menuOrders;
  final List<_Menu>? listMenuSearch;
  final int? total;
  final DateTime? dateTimeOrder;
  final String? typePayment;
  final String? buyer;
  final int? cash;
  final int? change;

  const MenuOrderState({
    this.id,
    this.menuOrders,
    this.listMenuSearch,
    this.total,
    this.dateTimeOrder,
    this.typePayment,
    this.buyer,
    this.cash,
    this.change,
  });

  MenuOrderState copyWith({
    String? id,
    List<_Menu>? menuOrders,
    List<_Menu>? listMenuSearch,
    int? total,
    DateTime? dateTimeOrder,
    String? buyer,
    String? typePayment,
    int? cash,
    int? change,
  }) {
    return MenuOrderState(
      id: id ?? this.id,
      menuOrders: menuOrders ?? this.menuOrders,
      listMenuSearch: listMenuSearch ?? this.listMenuSearch,
      total: total ?? this.total,
      dateTimeOrder: dateTimeOrder ?? this.dateTimeOrder,
      buyer: buyer ?? this.buyer,
      typePayment: typePayment ?? this.typePayment,
      cash: cash ?? this.cash,
      change: change ?? this.change,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      menuOrders,
      listMenuSearch,
      total,
      dateTimeOrder,
      buyer,
      typePayment,
      cash,
      change,
    ];
  }
}

class _Menu {
  String id;
  int price;
  String menuName;
  int totalBuy;
  int hpp;
  String typeMenu;
  int? quantityStock;

  _Menu({
    required this.id,
    required this.price,
    required this.menuName,
    required this.totalBuy,
    required this.hpp,
    required this.typeMenu,
    required this.quantityStock,
  });

  factory _Menu.fromMap(Map<String, dynamic> map) {
    return _Menu(
      id: map['id'] ?? '',
      price: map['price']?.toInt() ?? 0,
      menuName: map['menuName'] ?? '',
      totalBuy: map['totalBuy']?.toInt() ?? 0,
      hpp: map['hpp']?.toInt() ?? 0,
      typeMenu: map['typeMenu'] ?? '',
      quantityStock: map['quantityStock'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'price': price});
    result.addAll({'menuName': menuName});
    result.addAll({'totalBuy': totalBuy});
    result.addAll({'hpp': hpp});
    result.addAll({'typeMenu': typeMenu});
    result.addAll({'quantityStock': quantityStock});

    return result;
  }
}
