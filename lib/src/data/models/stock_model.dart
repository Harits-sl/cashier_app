import 'package:cashier_app/src/core/utils/status_inventory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StockModel {
  StockModel({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String name;
  final int quantity;
  final String unit;
  final StatusInventory status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'quantity': quantity});
    result.addAll({'unit': unit});
    result.addAll({'status': status});
    result.addAll({'createdAt': createdAt});
    result.addAll({'updatedAt': updatedAt});

    return result;
  }

  factory StockModel.fromFirestore(Map<String, dynamic> firestore) {
    StatusInventory status = StatusInventory.outOfStock;
    switch (firestore['status']) {
      case 'in stock':
        status = StatusInventory.inStock;
        print(StatusInventory.inStock.toString());
        break;
      case 'lows stock':
        status = StatusInventory.lowStock;
        break;
      case 'out of stock':
        status = StatusInventory.outOfStock;
        break;
    }

    return StockModel(
      name: firestore['name'] ?? '',
      quantity: firestore['quantity'] ?? '',
      unit: firestore['unit'] ?? '',
      status: status,
      createdAt: (firestore['createdAt'] as Timestamp).toDate(),
      updatedAt: (firestore['updatedAt'] as Timestamp).toDate(),
    );
  }
}
