// import 'package:bloc/bloc.dart';
// import 'package:cashier_app/src/data/models/menu_order_model.dart';
// import 'package:intl/intl.dart';

// class MenuQtyCubit extends Cubit<Map<String, dynamic>?> {
//   MenuQtyCubit() : super({});

//   /// variabel untuk keseluruhan harga menu
//   int totalPrice = 0;

//   /// variabel untuk menampung menu yang ditambahkan
//   List<Map<String, dynamic>> listMenu = [];

//   /// variabel untuk meng-Map data dari parameter
//   /// [insertMenu] berupa id, price, menuName
//   Map<String, dynamic> mapMenu = {};

//   /// variabel untuk menampung harga dari menu
//   List<int> listPriceMenu = [];

//   /// variabel yang akan mengembalikan atau emit dari
//   ///  variabel [listMenu] dan [totalPrice]
//   Map<String, dynamic> data = {};

//   /// fungsi untuk memasukan harga menu dari [listMenu]
//   /// ke [listPriceMenu]
//   void _addPriceToList() {
//     listPriceMenu.clear(); // mengosongkan listPriceMenu

//     /// lakukan perulangan [listMenu], ambil data price,
//     /// lalu masukan data ke [listPriceMenu]
//     for (var item in listMenu) {
//       listPriceMenu.add(item['price']);
//     }
//   }

//   /// fungsi untuk menghitung [totalPrice] dari [listPriceMenu]
//   void _addTotalPrice() {
//     totalPrice = 0;

//     /// lakukan perulangan [listPriceMenu], ambil data,
//     /// lalu masukan data ke [totalPrice]
//     for (var item in listPriceMenu) {
//       totalPrice += item;
//     }
//   }

//   void insertMenu({
//     int? id,
//     int? price = 0,
//     String? menuName,
//     bool? isIncrement,
//   }) {
//     mapMenu = {
//       'id': id,
//       'price': price,
//       'menuName': menuName,
//     };

//     /// jika isIncrement = true, tambahkan data [mapMenu] ke [listMenu]
//     /// lalu panggil fungsi [_addPriceToList] dan [_addTotalPrice]
//     if (isIncrement!) {
//       listMenu.add(mapMenu);
//       _addPriceToList();
//       _addTotalPrice();
//     } else {
//       /// variabel berupa integer dari indexWhere
//       int index = listMenu.indexWhere((menu) => menu['id'] == mapMenu['id']);

//       /// hapus data dari listMenu yang cocok dari index yang dicari
//       listMenu.remove(listMenu[index]);

//       /// memanggil fungsi [_addPriceToList] dan [_addTotalPrice]
//       _addPriceToList();
//       _addTotalPrice();
//     }

//     data = {
//       'listMenu': listMenu,
//       'totalPrice': totalPrice,
//     };

//     emit(data);
//   }

//   void removeMenu({
//     int? id,
//     int? price = 0,
//     String? menuName,
//   }) {
//     /// variabel berupa integer dari indexWhere
//     int index = listMenu.indexWhere((menu) => menu['id'] == mapMenu['id']);

//     /// hapus data dari listMenu yang cocok dari index yang dicari
//     listMenu.remove(listMenu[index]);

//     /// memanggil fungsi [_addPriceToList] dan [_addTotalPrice]
//     _addPriceToList();
//     _addTotalPrice();
//   }

//   MenuOrderModel menuOrder() {
//     DateTime now = DateTime.now();

//     /// format: year month day HOUR24_MINUTE_SECOND
//     DateFormat dateFormat = DateFormat('yyyMdHms');

//     MenuOrderModel menuOrder = MenuOrderModel(
//       id: 'oid$dateFormat',
//       total: data['totalPrice'],
//       listMenus: data['listMenu'],
//       dateTimeOrder: now,
//     );

//     return menuOrder;
//   }
// }
