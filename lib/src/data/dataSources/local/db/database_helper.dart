// import 'package:cashier_app/src/data/models/cart_table.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   static const _databaseName = "cashier-mota.db";
//   static const _databaseVersion = 1;

//   static const String _tblCart = 'cart';

//   late Database _db;

//   // this opens the database (and creates it if it doesn't exist)
//   Future<Database> init() async {
//     var databasePath = await getDatabasesPath();
//     String path = '$databasePath/$_databaseName';

//     _db = await openDatabase(
//       path,
//       version: _databaseVersion,
//       onCreate: _onCreate,
//     );
//     return _db;
//   }

//   // SQL code to create the database table
//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE $_tblCart (
//         id INTEGER PRIMARY KEY,
//         buyer TEXT,
//         dateTimeOrder TEXT,
//         listMenus TEXT,
//         total INTEGER
//       )
//     ''');

//     Future<int> insertCart(CartTable cart) {
//       return _db.insert(_tblCart, cart.toJson());
//     }

//     Future<int> removeCart(CartTable cart) {
//       return _db.delete(
//         _tblCart,
//         where: 'id = ?',
//         whereArgs: [cart.id],
//       );
//     }
//   }
// }
