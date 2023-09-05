part of 'menu_order_cubit.dart';

class MenuOrderState extends Equatable {
  final String? id;
  final List? menuOrders;
  final int? total;
  final DateTime? dateTimeOrder;
  final String? typePayment;
  final String? buyer;
  final int? cash;
  final int? change;

  const MenuOrderState({
    this.id,
    this.menuOrders,
    this.total,
    this.dateTimeOrder,
    this.typePayment,
    this.buyer,
    this.cash,
    this.change,
  });

  @override
  List<Object?> get props {
    return [
      id,
      menuOrders,
      total,
      dateTimeOrder,
      buyer,
      typePayment,
      cash,
      change,
    ];
  }

  MenuOrderState copyWith({
    String? id,
    List? menuOrders,
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
      total: total ?? this.total,
      dateTimeOrder: dateTimeOrder ?? this.dateTimeOrder,
      buyer: buyer ?? this.buyer,
      typePayment: typePayment ?? this.typePayment,
      cash: cash ?? this.cash,
      change: change ?? this.change,
    );
  }
}
