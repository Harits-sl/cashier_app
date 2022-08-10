import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MenuModel extends Equatable {
  final String id;
  final String name;
  final String typeMenu;
  final int price;

  const MenuModel({
    required this.id,
    required this.typeMenu,
    required this.price,
    required this.name,
  });

  Map<String, dynamic> toFirestore() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'typeMenu': typeMenu});
    result.addAll({'price': price});

    return result;
  }

  factory MenuModel.fromFirestore(Map<String, dynamic> json) {
    return MenuModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      typeMenu: json['typeMenu'] ?? '',
      price: json['price']?.toInt() ?? 0,
    );
  }

  @override
  List<Object> get props => [id, typeMenu, price, name];
}
