import 'package:flutter/material.dart';
import 'package:cashier_app/src/presentation/features/stock/index.dart';

class StockPage extends StatelessWidget {
  static const String routeName = '/stock';

  const StockPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StockScreen(),
    );
  }
}
