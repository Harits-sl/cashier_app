import 'package:cashier_app/src/data/models/menu_order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  final String? id;
  final List? listMenus;
  final DateTime? dateTimeOrder;
  final String? buyer;
  // final int hpp;

  const CartModel({
    this.id,
    this.listMenus,
    this.dateTimeOrder,
    this.buyer,
    // this.hpp = 0,
  });

  Map<String, dynamic> toFirestore() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'listMenus': listMenus});
    result.addAll({'dateTimeOrder': dateTimeOrder});
    result.addAll({'buyer': buyer});
    // result.addAll({'hpp': hpp});

    return result;
  }

  factory CartModel.fromFirestore(Map<String, dynamic> firestore) {
    return CartModel(
      id: firestore['id'] ?? '',
      listMenus: firestore['listMenus'] ?? [],
      dateTimeOrder: (firestore['dateTimeOrder'] as Timestamp).toDate(),

      buyer: firestore['buyer'],
      // hpp: firestore['hpp'],
    );
  }

  factory CartModel.fromMenuOrderModel(MenuOrderModel menuOrder) {
    return CartModel(
      id: menuOrder.id ?? '',
      listMenus: menuOrder.listMenus ?? [],
      dateTimeOrder: menuOrder.dateTimeOrder,

      buyer: menuOrder.buyer,
      // hpp: firestore['hpp'],
    );
  }

  CartModel copyWith({
    String? id,
    List? listMenus,
    DateTime? dateTimeOrder,
    String? buyer,
    // int? hpp,
  }) {
    return CartModel(
      id: id ?? this.id,
      listMenus: listMenus ?? this.listMenus,
      dateTimeOrder: dateTimeOrder ?? this.dateTimeOrder,
      buyer: buyer ?? this.buyer,
      // hpp: hpp ?? this.hpp,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      listMenus,
      dateTimeOrder,
      buyer,
      // hpp,
    ];
  }
}
