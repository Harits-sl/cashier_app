import 'package:cashier_app/src/data/models/menu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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

  void addMenu() async {}
}
