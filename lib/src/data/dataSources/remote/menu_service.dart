import 'package:flutter/material.dart';

import '../../models/menu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void addMenu(MenuModel menuModel) async {
    Map<String, dynamic> menu = menuModel.toFirestore();
    debugPrint('menu: $menu');

    CollectionReference menus = _db.collection('menus');
    menus
        .doc(menuModel.name)
        .set(menu)
        .then((value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"))
        .catchError((error) => throw Exception(error));
  }

  Future<List<MenuModel>> fetchMenu() async {
    CollectionReference menus = _db.collection('menus');

    QuerySnapshot querySnapshot = await menus.get();

    // Get data from docs and convert map to List
    List<MenuModel> listData = querySnapshot.docs
        .map(
          (doc) => MenuModel.fromFirestore(doc.data() as Map<String, dynamic>),
        )
        .toList();

    return listData;
  }
}
