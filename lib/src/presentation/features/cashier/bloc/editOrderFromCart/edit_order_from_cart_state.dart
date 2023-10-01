part of 'edit_order_from_cart_bloc.dart';

class EditOrderFromCartState extends Equatable {
  final String? id;
  final List<_EditMenu>? menuOrders;
  final List<_EditMenu>? listMenuSearch;
  final int? total;
  final DateTime? dateTimeOrder;
  final String? buyer;

  const EditOrderFromCartState({
    this.id,
    this.menuOrders,
    this.listMenuSearch,
    this.total,
    this.dateTimeOrder,
    this.buyer,
  });

  EditOrderFromCartState copyWith({
    String? id,
    List<_EditMenu>? menuOrders,
    List<_EditMenu>? listMenuSearch,
    int? total,
    DateTime? dateTimeOrder,
    String? buyer,
  }) {
    return EditOrderFromCartState(
      id: id ?? this.id,
      menuOrders: menuOrders ?? this.menuOrders,
      listMenuSearch: listMenuSearch ?? this.listMenuSearch,
      total: total ?? this.total,
      dateTimeOrder: dateTimeOrder ?? this.dateTimeOrder,
      buyer: buyer ?? this.buyer,
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
    ];
  }
}

class _EditMenu {
  String id;
  int price;
  String menuName;
  int totalBuy;
  int hpp;
  String typeMenu;
  _EditMenu({
    required this.id,
    required this.price,
    required this.menuName,
    required this.totalBuy,
    required this.hpp,
    required this.typeMenu,
  });

  factory _EditMenu.fromMap(Map<String, dynamic> map) {
    return _EditMenu(
      id: map['id'] ?? '',
      price: map['price']?.toInt() ?? 0,
      menuName: map['menuName'] ?? '',
      totalBuy: map['totalBuy']?.toInt() ?? 0,
      hpp: map['hpp']?.toInt() ?? 0,
      typeMenu: map['typeMenu'] ?? '',
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

    return result;
  }
}
