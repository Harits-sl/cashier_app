import 'package:cashier_app/src/presentation/features/admin/admin_page.dart';
import 'package:cashier_app/src/presentation/features/admin/index.dart';
import 'package:cashier_app/src/presentation/pages/select_printer_page.dart';

import 'src/config/route/routes.dart';
import 'src/presentation/cubit/Menu/menu_cubit.dart';
import 'src/presentation/cubit/thermalPrinterCubit/thermal_printer_cubit.dart';
import 'src/presentation/features/home/index.dart';
import 'src/presentation/pages/payment_amount_page.dart';
import 'src/presentation/pages/receipt_page.dart';
import 'src/presentation/pages/select_payment_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'src/presentation/cubit/menu_order/menu_order_cubit.dart';

import 'src/config/theme/app_theme.dart';

import 'src/presentation/pages/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        BlocProvider<AdminCubit>(
          create: (BuildContext context) => AdminCubit(),
        ),
        BlocProvider<MenuOrderCubit>(
          create: (BuildContext context) => MenuOrderCubit(),
        ),
        BlocProvider<MenuCubit>(
          create: (BuildContext context) => MenuCubit(),
        ),
        BlocProvider<ThermalPrinterCubit>(
          create: (BuildContext context) => ThermalPrinterCubit(),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.light,
        initialRoute: '/',
        routes: {
          Routes.home: (context) => const HomePage(),
          Routes.orderMenu: (context) => const OrderPage(),
          Routes.admin: (context) => const AdminPage(),
          Routes.paymentAmount: (context) => const PaymentAmountPage(),
          Routes.selectPayment: (context) => const SelectPaymentPage(),
          Routes.receipt: (context) => const ReceiptPage(),
          Routes.selectPrinter: (context) => const SelectPrinterPage(),
        },
      ),
    );
  }
}
