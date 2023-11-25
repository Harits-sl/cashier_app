import 'package:flutter/material.dart';

import '../../models/menu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String menusCollection = 'menus';

  void addMenu(MenuModel menuModel) async {
    Map<String, dynamic> menu = menuModel.toFirestore();

    CollectionReference menus = _db.collection(menusCollection);
    menus
        .doc(menuModel.id)
        .set(menu)
        .catchError((error) => throw Exception(error));
  }

  void editMenu(MenuModel menuModel) async {
    CollectionReference menus = _db.collection(menusCollection);
    menus
        .doc(menuModel.id)
        .update(menuModel.toFirestore())
        .then((value) => debugPrint('successfully updated!'))
        .onError((error, stackTrace) => debugPrint('update error: $error'));
  }

  Future<List<MenuModel>> fetchMenu() async {
    CollectionReference menus = _db.collection(menusCollection);

    QuerySnapshot querySnapshot = await menus.where('id', isNull: false).get();

    // Get data from docs and convert map to List
    List<MenuModel> listData = querySnapshot.docs.map((doc) {
      return MenuModel.fromFirestore(doc.data() as Map<String, dynamic>);

      // code for update data
      // menus.doc(doc.id).update({
      //   'createdAt': DateTime.now(),
      //   'updatedAt': DateTime.now(),
      // });
      // return MenuModel(
      //   id: 'id',
      //   name: 'name',
      //   typeMenu: 'typeMenu',
      //   price: 0,
      //   createdAt: DateTime.now(),
      //   updatedAt: DateTime.now(),
      // );
    }).toList();

    return listData;
  }

  void deleteMenu(String id) {
    CollectionReference menus = _db.collection(menusCollection);

    menus.doc(id).delete().then(
          (value) => debugPrint('Document Deleted'),
          onError: (e) => debugPrint('error deleting document $e'),
        );
  }

  Future<MenuModel> fetchMenuById(String id) async {
    CollectionReference menusRef = _db.collection(menusCollection);
    QuerySnapshot menus = await menusRef.where('id', isEqualTo: id).get();

    List<MenuModel> listData = menus.docs.map((doc) {
      return MenuModel.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();

    // just get 1 data because id is unique
    return listData[0];
  }

  void updateQuantityAndStatus(
    String id,
    int newQuantity,
    String status,
  ) async {
    CollectionReference menus = _db.collection(menusCollection);
    menus
        .doc(id)
        .update({'quantity': newQuantity, 'status': status})
        .then((value) => debugPrint('successfully updated!'))
        .onError((error, stackTrace) => debugPrint('update error: $error'));
  }
}
