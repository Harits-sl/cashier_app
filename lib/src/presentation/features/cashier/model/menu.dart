// class Menu {
//   String id;
//   int price;
//   String menuName;
//   int totalBuy;
//   int hpp;
//   String typeMenu;
//   int quantityStock;
//   Menu({
//     required this.id,
//     required this.price,
//     required this.menuName,
//     required this.totalBuy,
//     required this.hpp,
//     required this.typeMenu,
//     required this.quantityStock,
//   });

//   factory Menu.fromMap(Map<String, dynamic> map) {
//     return Menu(
//       id: map['id'] ?? '',
//       price: map['price']?.toInt() ?? 0,
//       menuName: map['menuName'] ?? '',
//       totalBuy: map['totalBuy']?.toInt() ?? 0,
//       hpp: map['hpp']?.toInt() ?? 0,
//       typeMenu: map['typeMenu'] ?? '',
//       quantityStock: map['quantityStock'] ?? '',
//     );
//   }

//   Map<String, dynamic> toMap() {
//     final result = <String, dynamic>{};

//     result.addAll({'id': id});
//     result.addAll({'price': price});
//     result.addAll({'menuName': menuName});
//     result.addAll({'totalBuy': totalBuy});
//     result.addAll({'hpp': hpp});
//     result.addAll({'typeMenu': typeMenu});
//     result.addAll({'quantityStock': quantityStock});

//     return result;
//   }
// }
