import 'dart:async';
import 'dart:io';

import 'package:cashier_app/src/data/models/stock_model.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class StockService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String stocksCollection = 'stocks';

  Future<List<StockModel>> fetchStocks() async {
    CollectionReference stocks = _db.collection(stocksCollection);

    QuerySnapshot querySnapshot =
        await stocks.orderBy('status', descending: true).get();

    // Get data from docs and convert map to List
    List<StockModel> listData = querySnapshot.docs.map((doc) {
      return StockModel.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();

    return listData;
  }

  Future<void> addStock(StockModel stockModel) async {
    try {
      Map<String, dynamic> stock = stockModel.toFirestore();

      CollectionReference stocks = _db.collection(stocksCollection);
      stocks
          .doc(stockModel.id)
          .set(stock)
          .catchError((error) => throw Exception(error))
          .onError(
            (error, stackTrace) => throw Exception(error),
          );
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  // void editMenu(MenuModel menuModel) async {
  //   CollectionReference menus = _db.collection(menusCollection);
  //   menus
  //       .doc(menuModel.id)
  //       .update(menuModel.toFirestore())
  //       .then((value) => debugPrint('successfully updated!'))
  //       .onError((error, stackTrace) => debugPrint('update error: $error'));
  // }

  Future<void> deleteStock(String id) {
    CollectionReference stocks = _db.collection(stocksCollection);

    try {
      return stocks
          .doc(id)
          .delete()
          .then(
            (value) => debugPrint('Document Deleted'),
          )
          .catchError((e) => throw Exception(e));
    } catch (e) {
      throw Exception(e);
    }
  }

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
