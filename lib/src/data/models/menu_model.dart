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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'typeMenu': typeMenu,
      'price': price,
    };
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
