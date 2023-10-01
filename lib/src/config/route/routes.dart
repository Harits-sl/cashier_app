import 'package:cashier_app/src/presentation/features/cart/index.dart';
import 'package:cashier_app/src/presentation/features/cashier/index.dart';
import 'package:cashier_app/src/presentation/features/product/index.dart';
import 'package:cashier_app/src/presentation/features/report/index.dart';
import 'package:cashier_app/src/presentation/features/stock/index.dart';

class Routes {
  static const String home = '/';
  static const String product = ProductPage.routeName;
  static const String cashier = CashierPage.routeName;
  static const String editOrderFromCart = EditOrderFromCartPage.routeName;
  static const String receipt = ReceiptPage.routeName;
  static const String paymentAmount = PaymentAmountPage.routeName;
  static const String paymentMethod = PaymentMethod.routeName;
  static const String selectPrinter = '/select-printer';
  static const String addProduct = AddProductPage.routeName;
  static const String cart = CartPage.routeName;
  static const String orderInfo = OrderInfoPage.routeName;
  static const String report = ReportPage.routeName;
  static const String stock = StockPage.routeName;
  static const String addStock = AddStockPage.routeName;
  static const String editStock = EditStockPage.routeName;
}
