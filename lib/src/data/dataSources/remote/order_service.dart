import 'package:cashier_app/src/data/models/menu_order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void addOrder(MenuOrderModel menuOrder) async {
    Map<String, dynamic> order = menuOrder.toFirestore();

    CollectionReference orders = _db.collection('orders');
    orders.doc(menuOrder.id).set(order);
  }

  Future<List<MenuOrderModel>> getAllOrder() async {
    CollectionReference orders = _db.collection('orders');
    QuerySnapshot querySnapshot = await orders.get();

    List<MenuOrderModel> listData = querySnapshot.docs
        .map(
          (doc) =>
              MenuOrderModel.fromFirestore(doc.data() as Map<String, dynamic>),
        )
        .toList();

    return listData;
  }
}
