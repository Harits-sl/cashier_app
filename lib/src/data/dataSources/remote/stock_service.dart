import 'dart:async';

import 'package:cashier_app/src/data/models/stock_model.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<void> editStock(StockModel stockModel) async {
    try {
      CollectionReference stock = _db.collection(stocksCollection);
      stock
          .doc(stockModel.id)
          .update(stockModel.toFirestore())
          .then((value) => debugPrint('successfully updated!'))
          .onError((error, stackTrace) => throw Exception(error));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteStock(String id) {
    try {
      CollectionReference stocks = _db.collection(stocksCollection);
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

  Future<StockModel> fetchStockById(String id) async {
    CollectionReference stocks = _db.collection(stocksCollection);
    QuerySnapshot querySnapshot = await stocks.where('id', isEqualTo: id).get();

    List<StockModel> listData = querySnapshot.docs.map((doc) {
      return StockModel.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();

    // just get 1 data because id is unique
    return listData[0];
  }
}
