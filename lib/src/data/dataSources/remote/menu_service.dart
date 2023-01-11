import 'package:flutter/material.dart';

import '../../models/menu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void addMenu(MenuModel menuModel) async {
    Map<String, dynamic> menu = menuModel.toFirestore();

    CollectionReference menus = _db.collection('menus');
    menus
        .doc(menuModel.id)
        .set(menu)
        .catchError((error) => throw Exception(error));
  }

  void editMenu(MenuModel menuModel) async {
    CollectionReference menus = _db.collection('menus');
    menus
        .doc(menuModel.id)
        .update(menuModel.toFirestore())
        .then((value) => debugPrint('successfully updated!'))
        .onError((error, stackTrace) => debugPrint('update error: $error'));
  }

  Future<List<MenuModel>> fetchMenu() async {
    CollectionReference menus = _db.collection('menus');

    QuerySnapshot querySnapshot = await menus.get();
    debugPrint('querySnapshot: ${querySnapshot.docs}');

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

  Future<MenuModel> fetchMenuById(String id) async {
    CollectionReference menusRef = _db.collection('menus');
    QuerySnapshot menus = await menusRef.where('id', isEqualTo: id).get();

    List<MenuModel> listData = menus.docs.map((doc) {
      return MenuModel.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();

    // just get 1 data because id is unique
    return listData[0];
  }
}
