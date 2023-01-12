import 'package:flutter/cupertino.dart';

import '../../models/menu_order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String ordersCollection = 'orders';

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

  Future<List<MenuOrderModel>> getFilterOrder(
      Timestamp firstDate, Timestamp secondDate) async {
    CollectionReference orders = _db.collection(ordersCollection);

    QuerySnapshot snapshotOrders = await orders
        .where('dateTimeOrder',
            isGreaterThanOrEqualTo: firstDate, isLessThanOrEqualTo: secondDate)
        // .where('dateTimeOrder', isLessThanOrEqualTo: secondDate)
        .get();

    debugPrint('snapshotOrders: ${snapshotOrders.docs}');
    List<MenuOrderModel> listData = snapshotOrders.docs.map((doc) {
      debugPrint('doc: ${doc.data()}');
      return MenuOrderModel.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();

    return listData;
  }
}
