import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MenuOrderModel extends Equatable {
  final String? id;
  final int total;
  final List? listMenus;
  final DateTime? dateTimeOrder;
  final String? typePayment;
  final int cash;
  final int change;

  const MenuOrderModel({
    this.id,
    this.total = 0,
    this.listMenus,
    this.dateTimeOrder,
    this.typePayment,
    this.cash = 0,
    this.change = 0,
  });

  Map<String, dynamic> toFirestore() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'total': total});
    result.addAll({'listMenus': listMenus});
    result.addAll({'dateTimeOrder': dateTimeOrder});
    result.addAll({'typePayment': typePayment});
    result.addAll({'cash': cash});
    result.addAll({'change': change});

    return result;
  }

  factory MenuOrderModel.fromFirestore(Map<String, dynamic> firestore) {
    return MenuOrderModel(
      id: firestore['id'] ?? '',
      total: firestore['total']?.toInt() ?? 0,
      listMenus: firestore['listMenus'] ?? [],
      dateTimeOrder: (firestore['dateTimeOrder'] as Timestamp).toDate(),
      typePayment: firestore['typePayment'],
      cash: firestore['cash'],
      change: firestore['change'],
    );
  }

  MenuOrderModel copyWith({
    String? id,
    int? total,
    List? listMenus,
    DateTime? dateTimeOrder,
    String? typePayment,
    int? cash,
    int? change,
  }) {
    return MenuOrderModel(
      id: id ?? this.id,
      total: total ?? this.total,
      listMenus: listMenus ?? this.listMenus,
      dateTimeOrder: dateTimeOrder ?? this.dateTimeOrder,
      typePayment: typePayment ?? this.typePayment,
      cash: cash ?? this.cash,
      change: change ?? this.change,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      total,
      listMenus,
      dateTimeOrder,
      typePayment,
      cash,
      change,
    ];
  }
}
