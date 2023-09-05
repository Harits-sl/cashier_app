import 'package:cashier_app/src/presentation/cubit/menu_order/menu_order_cubit.dart';
import 'package:cashier_app/src/presentation/features/cart/index.dart';
import 'package:cashier_app/src/presentation/features/product/index.dart';
import 'package:cashier_app/src/presentation/features/stock/index.dart';
import 'package:cashier_app/src/presentation/pages/order_info_page.dart';
import 'package:cashier_app/src/presentation/pages/select_printer_page.dart';
import 'package:flutter/foundation.dart';

import 'firebase_options_dev.dart';
import 'firebase_options_prod.dart';
import 'src/config/route/routes.dart';
import 'src/presentation/cubit/Menu/menu_cubit.dart';
import 'src/presentation/cubit/thermalPrinterCubit/thermal_printer_cubit.dart';
import 'src/presentation/features/home/index.dart';
import 'src/presentation/features/report/index.dart';
import 'src/presentation/pages/payment_amount_page.dart';
import 'src/presentation/pages/receipt_page.dart';
import 'src/presentation/pages/payment_method_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/config/theme/app_theme.dart';

import 'src/presentation/pages/cashier_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// final dbHelper = DatabaseHelper();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize the database
  // await dbHelper.init();

  // menentukan firebase yang dipakai
  if (kDebugMode) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptionsDev.currentPlatform,
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptionsDev.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit(),
        ),
        BlocProvider<ProductCubit>(
          create: (BuildContext context) => ProductCubit(),
        ),
        BlocProvider<MenuOrderBloc>(
          create: (BuildContext context) => MenuOrderBloc(),
        ),
        BlocProvider<MenuCubit>(
          create: (BuildContext context) => MenuCubit(),
        ),
        BlocProvider<ThermalPrinterCubit>(
          create: (BuildContext context) => ThermalPrinterCubit(),
        ),
        BlocProvider<AddProductBloc>(
          create: (BuildContext context) => AddProductBloc(),
        ),
        BlocProvider<EditProductBloc>(
          create: (BuildContext context) => EditProductBloc(),
        ),
        BlocProvider<ReportCubit>(
          create: (BuildContext context) => ReportCubit(),
        ),
        BlocProvider<CartBloc>(
          create: (BuildContext context) => CartBloc(),
        ),
        BlocProvider<StockBloc>(
          create: (BuildContext context) => StockBloc(),
        ),
        BlocProvider<AddStockBloc>(
          create: (BuildContext context) => AddStockBloc(),
        ),
        BlocProvider<EditStockBloc>(
          create: (BuildContext context) => EditStockBloc(),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.light,
        initialRoute: '/',
        routes: {
          Routes.home: (context) => const HomePage(),
          Routes.cashier: (context) => const CashierPage(),
          // Routes.editOrderMenu: (context) => const EditOrderPage(),
          Routes.product: (context) => const ProductPage(),
          Routes.paymentAmount: (context) => const PaymentAmountPage(),
          Routes.paymentMethod: (context) => const PaymentMethod(),
          Routes.receipt: (context) => const ReceiptPage(),
          Routes.selectPrinter: (context) => const SelectPrinterPage(),
          Routes.addProduct: (context) => const AddProductPage(),
          Routes.report: (context) => const ReportPage(),
          Routes.cart: (context) => const CartPage(),
          Routes.orderInfo: (context) => const OrderInfoPage(),
          Routes.stock: (context) => const StockPage(),
          Routes.addStock: (context) => const AddStockPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case EditProductPage.routeName:
              final String id = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => EditProductPage(id: id),
                settings: settings,
              );
            case EditStockPage.routeName:
              final String id = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => EditStockPage(id: id),
                settings: settings,
              );

            default:
          }
          // Other values need to be implemented if we
          // add them. The assertion here will help remind
          // us of that higher up in the call stack, since
          // this assertion would otherwise fire somewhere
          // in the framework.
          assert(false, 'Need to implement ${settings.name}');
          return null;
        },
      ),
    );
  }
}
