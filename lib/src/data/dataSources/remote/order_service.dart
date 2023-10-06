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
      DateTime firstDate, DateTime secondDate) async {
    CollectionReference orders = _db.collection(ordersCollection);
    DateTime fromDate = DateTime(
      firstDate.year,
      firstDate.month,
      firstDate.day,
    );
    DateTime toDate = DateTime(
      secondDate.year,
      secondDate.month,
      secondDate.day,
      23,
      59,
      59,
    );

    Timestamp fromTimestamp = Timestamp.fromDate(fromDate);
    Timestamp toTimestamp = Timestamp.fromDate(toDate);

    QuerySnapshot snapshotOrders = await orders
        .where(
          'dateTimeOrder',
          isGreaterThanOrEqualTo: fromTimestamp,
          isLessThanOrEqualTo: toTimestamp,
        )
        .get();

    List<MenuOrderModel> listData = snapshotOrders.docs.map((doc) {
      MenuOrderModel orders =
          MenuOrderModel.fromFirestore(doc.data() as Map<String, dynamic>);

      return orders;
    }).toList();

    return listData;
  }

  Future<List<MenuOrderModel>> getTodayOrder() async {
    CollectionReference orders = _db.collection(ordersCollection);

    DateTime date = DateTime(yearNow, monthNow, dateNow);

    QuerySnapshot snapshotOrders =
        await orders.where('dateTimeOrder', isGreaterThan: date).get();

    List<MenuOrderModel> listData = snapshotOrders.docs.map((doc) {
      MenuOrderModel orders =
          MenuOrderModel.fromFirestore(doc.data() as Map<String, dynamic>);

      return orders;
    }).toList();

    return listData;
  }

  Future<List<MenuOrderModel>> getYesterdayOrder() async {
    CollectionReference orders = _db.collection(ordersCollection);
    DateTime today = DateTime(yearNow, monthNow, dateNow);
    DateTime yesterday = DateTime(yearNow, monthNow, dateNow - 1);

    QuerySnapshot snapshotOrders = await orders
        .where('dateTimeOrder', isGreaterThan: yesterday, isLessThan: today)
        .get();

    List<MenuOrderModel> listData = snapshotOrders.docs.map((doc) {
      MenuOrderModel orders =
          MenuOrderModel.fromFirestore(doc.data() as Map<String, dynamic>);

      return orders;
    }).toList();

    return listData;
  }

  Future<List<MenuOrderModel>> getThisWeekOrder() async {
    /// from https://stackoverflow.com/questions/58287278/how-to-get-start-of-or-end-of-week-in-dart
    /// The [weekday] may be 0 for Sunday, 1 for Monday, etc. up to 7 for Sunday.
    DateTime getDateMonday(DateTime date) =>
        DateTime(date.year, date.month, date.day - (date.weekday - 1) % 7);

    CollectionReference orders = _db.collection(ordersCollection);
    DateTime thisWeek = getDateMonday(DateTime.now());

    QuerySnapshot snapshotOrders =
        await orders.where('dateTimeOrder', isGreaterThan: thisWeek).get();

    List<MenuOrderModel> listData = snapshotOrders.docs.map((doc) {
      MenuOrderModel orders =
          MenuOrderModel.fromFirestore(doc.data() as Map<String, dynamic>);

      return orders;
    }).toList();

    return listData;
  }

  Future<List<MenuOrderModel>> getThisMonthOrder() async {
    CollectionReference orders = _db.collection(ordersCollection);
    DateTime thisMonth = DateTime(yearNow, monthNow, 1);

    QuerySnapshot snapshotOrders =
        await orders.where('dateTimeOrder', isGreaterThan: thisMonth).get();

    List<MenuOrderModel> listData = snapshotOrders.docs.map((doc) {
      MenuOrderModel orders =
          MenuOrderModel.fromFirestore(doc.data() as Map<String, dynamic>);

      return orders;
    }).toList();

    return listData;
  }
}

extension DateUtils on DateTime {
  DateTime getDay({required int dayOfWeek}) {
    return subtract(Duration(days: weekday - dayOfWeek));
  }
}
