import 'dart:convert';

import 'package:equatable/equatable.dart';

class CartTable extends Equatable {
  final int id;
  final String? buyer;
  final String dateTimeOrder;
  final int total;
  final String listMenus;

  const CartTable({
    required this.id,
    this.buyer,
    required this.dateTimeOrder,
    required this.total,
    required this.listMenus,
  });

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'dateTimeOrder': dateTimeOrder});
    result.addAll({'total': total});
    result.addAll({'listMenus': listMenus});
    if (buyer != null) {
      result.addAll({'buyer': buyer});
    } else {
      result.addAll({'buyer': ''});
    }

    return result;
  }

  factory CartTable.fromMap(Map<String, dynamic> map) {
    return CartTable(
      id: map['id']?.toInt() ?? 0,
      buyer: map['buyer'],
      dateTimeOrder: map['dateTimeOrder'] ?? '',
      total: map['total']?.toInt() ?? 0,
      listMenus: map['listMenus'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        buyer,
        dateTimeOrder,
        total,
        listMenus,
      ];
}
