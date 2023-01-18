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

  const MenuModel({
    required this.id,
    required this.name,
    required this.typeMenu,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.hpp,
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

    return result;
  }

  factory MenuModel.fromFirestore(Map<String, dynamic> firestore) {
    return MenuModel(
      id: firestore['id'] ?? '',
      name: firestore['name'] ?? '',
      typeMenu: firestore['typeMenu'] ?? '',
      price: firestore['price']?.toInt() ?? 0,
      createdAt: (firestore['createdAt'] as Timestamp).toDate(),
      updatedAt: (firestore['updatedAt'] as Timestamp).toDate(),
      hpp: firestore['hpp']?.toInt() ?? 0,
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
      ];
}
