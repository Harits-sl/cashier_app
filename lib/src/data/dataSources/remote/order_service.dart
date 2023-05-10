import 'package:cashier_app/src/data/models/menu_order_model.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String ordersCollection = 'orders';

  final int yearNow = DateTime.now().year;
  final int monthNow = DateTime.now().month;
  final int dateNow = DateTime.now().day;

  void addOrder(MenuOrderModel menuOrder) async {
    Map<String, dynamic> order = menuOrder.toFirestore();

    CollectionReference orders = _db.collection('orders');
    debugPrint('menuOrder.id: ${menuOrder.id}');
    orders.doc(menuOrder.id).set(order).then(
        (value) => debugPrint('success save'),
        onError: (e) => debugPrint('gagal $e'));
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
      MenuOrderModel orders =
          MenuOrderModel.fromFirestore(doc.data() as Map<String, dynamic>);

      return orders;
    }).toList();

    return listData;
  }

  Future<int> getTodayOrder() async {
    CollectionReference orders = _db.collection(ordersCollection);

    DateTime date = DateTime(yearNow, monthNow, dateNow);

    QuerySnapshot snapshotOrders =
        await orders.where('dateTimeOrder', isGreaterThan: date).get();

    List<MenuOrderModel> listData = snapshotOrders.docs.map((doc) {
      MenuOrderModel orders =
          MenuOrderModel.fromFirestore(doc.data() as Map<String, dynamic>);

      return orders;
    }).toList();

    return totalOrder(listData);
  }

  Future<int> getYesterdayOrder() async {
    CollectionReference orders = _db.collection(ordersCollection);
    DateTime yesterday = DateTime(yearNow, monthNow, dateNow - 1);

    QuerySnapshot snapshotOrders =
        await orders.where('dateTimeOrder', isGreaterThan: yesterday).get();

    List<MenuOrderModel> listData = snapshotOrders.docs.map((doc) {
      MenuOrderModel orders =
          MenuOrderModel.fromFirestore(doc.data() as Map<String, dynamic>);

      return orders;
    }).toList();

    return totalOrder(listData);
  }

  Future<int> getOneWeekOrder() async {
    CollectionReference orders = _db.collection(ordersCollection);
    DateTime oneWeek = DateTime(yearNow, monthNow, dateNow - 7);

    QuerySnapshot snapshotOrders =
        await orders.where('dateTimeOrder', isGreaterThan: oneWeek).get();

    List<MenuOrderModel> listData = snapshotOrders.docs.map((doc) {
      MenuOrderModel orders =
          MenuOrderModel.fromFirestore(doc.data() as Map<String, dynamic>);

      return orders;
    }).toList();

    return totalOrder(listData);
  }

  Future<int> getOneMonthOrder() async {
    CollectionReference orders = _db.collection(ordersCollection);
    DateTime oneMonth = DateTime(yearNow, monthNow - 1, dateNow);

    QuerySnapshot snapshotOrders =
        await orders.where('dateTimeOrder', isGreaterThan: oneMonth).get();

    List<MenuOrderModel> listData = snapshotOrders.docs.map((doc) {
      MenuOrderModel orders =
          MenuOrderModel.fromFirestore(doc.data() as Map<String, dynamic>);

      return orders;
    }).toList();

    return totalOrder(listData);
  }

  int totalOrder(List<MenuOrderModel> orders) {
    int total = 0;

    for (var order in orders) {
      total += order.total;
    }
    return total;
  }
}
