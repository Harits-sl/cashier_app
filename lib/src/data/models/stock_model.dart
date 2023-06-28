import 'package:cashier_app/src/core/utils/status_inventory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StockModel {
  StockModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.minimumQuantity,
    required this.unit,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final int quantity;
  final int minimumQuantity;
  final String unit;
  final StatusInventory status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toFirestore() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'quantity': quantity});
    result.addAll({'minimumQuantity': minimumQuantity});
    result.addAll({'unit': unit});
    result.addAll({'status': StatusInventory.getValue(status)});
    result.addAll({'createdAt': createdAt});
    result.addAll({'updatedAt': updatedAt});

    return result;
  }

  factory StockModel.fromFirestore(Map<String, dynamic> firestore) {
    StatusInventory status =
        StatusInventory.getTypeByTitle(firestore['status']);

    return StockModel(
      id: firestore['id'],
      name: firestore['name'],
      quantity: firestore['quantity'],
      minimumQuantity: firestore['minimumQuantity'],
      unit: firestore['unit'],
      status: status,
      createdAt: (firestore['createdAt'] as Timestamp).toDate(),
      updatedAt: (firestore['updatedAt'] as Timestamp).toDate(),
    );
  }
}
