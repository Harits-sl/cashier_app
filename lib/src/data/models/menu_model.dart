import 'package:cashier_app/src/core/utils/status_inventory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MenuModel extends Equatable {
  final String id;
  final String name;
  final String typeMenu;
  final int price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int hpp;
  final int? quantity;
  final int? minimumQuantity;
  final String? unit;
  final StatusInventory? status;

  const MenuModel({
    required this.id,
    required this.name,
    required this.typeMenu,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.hpp,
    this.quantity,
    this.minimumQuantity,
    this.unit,
    this.status,
  });

  Map<String, dynamic> toFirestore() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'typeMenu': typeMenu});
    result.addAll({'price': price});
    result.addAll({'createdAt': createdAt});
    result.addAll({'updatedAt': updatedAt});
    result.addAll({'hpp': hpp});
    result.addAll({'quantity': quantity});
    result.addAll({'minimumQuantity': minimumQuantity});
    result.addAll({'unit': unit});
    result.addAll(
        {'status': status == null ? StatusInventory.getValue(status!) : null});

    return result;
  }

  factory MenuModel.fromFirestore(Map<String, dynamic> firestore) {
    StatusInventory? status = firestore['status'] != null
        ? StatusInventory.getTypeByTitle(firestore['status'])
        : null;

    return MenuModel(
      id: firestore['id'] ?? '',
      name: firestore['name'] ?? '',
      typeMenu: firestore['typeMenu'] ?? '',
      price: firestore['price']?.toInt() ?? 0,
      createdAt: (firestore['createdAt'] as Timestamp).toDate(),
      updatedAt: (firestore['updatedAt'] as Timestamp).toDate(),
      hpp: firestore['hpp']?.toInt() ?? 0,
      quantity: firestore['quantity']?.toInt() ?? 0,
      minimumQuantity: firestore['minimumQuantity']?.toInt() ?? 0,
      unit: firestore['unit'] ?? '',
      status: status,
    );
  }

  @override
  List<Object?> get props => [
        id,
        typeMenu,
        price,
        name,
        createdAt,
        updatedAt,
        hpp,
        quantity,
        minimumQuantity,
        unit,
        status,
      ];
}
