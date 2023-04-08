import 'package:cashier_app/src/data/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String cartsCollection = 'carts';

  void insertCart(CartModel cartModel) async {
    Map<String, dynamic> order = cartModel.toFirestore();

    CollectionReference orders = _db.collection(cartsCollection);
    orders.doc(cartModel.id).set(order);
  }

  Future<List<CartModel>> fetchAllCarts() async {
    CollectionReference orders = _db.collection(cartsCollection);
    QuerySnapshot querySnapshot = await orders.get();

    List<CartModel> listData = querySnapshot.docs
        .map(
          (doc) => CartModel.fromFirestore(doc.data() as Map<String, dynamic>),
        )
        .toList();

    return listData;
  }

  Future<CartModel> fetchCartById(String id) async {
    CollectionReference carts = _db.collection(cartsCollection);
    QuerySnapshot querySnapshot = await carts.where('id', isEqualTo: id).get();

    CartModel cart =
        CartModel.fromFirestore(querySnapshot.docs[0] as Map<String, dynamic>);
    return cart;
  }

  void deleteCart(String id) async {
    CollectionReference carts = _db.collection(cartsCollection);
    carts.doc(id).delete();
  }
}
