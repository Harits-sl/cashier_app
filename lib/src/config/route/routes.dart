import 'package:cashier_app/src/presentation/features/report/index.dart';
import 'package:cashier_app/src/presentation/features/stock/index.dart';
import 'package:cashier_app/src/presentation/pages/cashier_page.dart';
import 'package:cashier_app/src/presentation/pages/order_info_page.dart';
import 'package:cashier_app/src/presentation/pages/payment_amount_page.dart';
import 'package:cashier_app/src/presentation/pages/payment_method_page.dart';
import 'package:cashier_app/src/presentation/pages/receipt_page.dart';

class Routes {
  static const String home = '/';
  static const String product = '/product';
  static const String cashier = CashierPage.routeName;
  static const String editOrderMenu = '/edit-order';
  static const String receipt = ReceiptPage.routeName;
  static const String paymentAmount = PaymentAmountPage.routeName;
  static const String paymentMethod = PaymentMethod.routeName;
  static const String selectPrinter = '/select-printer';
  static const String addMenu = 'admin/add-menu';
  static const String cart = '/cart';
  static const String orderInfo = OrderInfoPage.routeName;
  static const String report = ReportPage.routeName;
  static const String stock = StockPage.routeName;
  static const String addStock = AddStockPage.routeName;
  static const String editStock = EditStockPage.routeName;
}
