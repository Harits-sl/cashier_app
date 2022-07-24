import 'package:equatable/equatable.dart';

class MenuModel extends Equatable {
  final int id;
  final int order;
  final int price;
  final String name;

  const MenuModel({
    required this.id,
    required this.order,
    required this.price,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order': order,
      'price': price,
      'name': name,
    };
  }

  factory MenuModel.fromJSon(Map<String, dynamic> json) {
    return MenuModel(
      id: json['id']?.toInt() ?? 0,
      order: json['order']?.toInt() ?? 0,
      price: json['price']?.toInt() ?? 0,
      name: json['name'] ?? '',
    );
  }

  @override
  List<Object> get props => [id, order, price, name];
}
