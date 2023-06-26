import 'package:cashier_app/src/data/models/stock_model.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class StockService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String stocksCollection = 'stocks';

  Future<List<StockModel>> fetchStocks() async {
    CollectionReference stocks = _db.collection(stocksCollection);

    QuerySnapshot querySnapshot = await stocks.get();
    debugPrint('querySnapshot: ${querySnapshot.docs}');

    // Get data from docs and convert map to List
    List<StockModel> listData = querySnapshot.docs.map((doc) {
      return StockModel.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();

    return listData;
  }

  // void addStock(StockModel stockModel) async {
  //   Map<String, dynamic> menu = menuModel.toFirestore();

  //   CollectionReference menus = _db.collection(menusCollection);
  //   menus
  //       .doc(menuModel.id)
  //       .set(menu)
  //       .catchError((error) => throw Exception(error));
  // }

  // void editMenu(MenuModel menuModel) async {
  //   CollectionReference menus = _db.collection(menusCollection);
  //   menus
  //       .doc(menuModel.id)
  //       .update(menuModel.toFirestore())
  //       .then((value) => debugPrint('successfully updated!'))
  //       .onError((error, stackTrace) => debugPrint('update error: $error'));
  // }

  // void deleteMenu(String id) {
  //   CollectionReference menus = _db.collection(menusCollection);

  //   menus.doc(id).delete().then(
  //         (value) => debugPrint('Document Deleted'),
  //         onError: (e) => debugPrint('error deleting document $e'),
  //       );
  // }

  // Future<MenuModel> fetchMenuById(String id) async {
  //   CollectionReference menusRef = _db.collection(menusCollection);
  //   QuerySnapshot menus = await menusRef.where('id', isEqualTo: id).get();

  //   List<MenuModel> listData = menus.docs.map((doc) {
  //     return MenuModel.fromFirestore(doc.data() as Map<String, dynamic>);
  //   }).toList();

  //   // just get 1 data because id is unique
  //   return listData[0];
  // }
}
