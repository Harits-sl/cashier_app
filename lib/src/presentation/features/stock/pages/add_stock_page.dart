import 'package:flutter/material.dart';
import 'package:cashier_app/src/presentation/features/stock/index.dart';

class AddStockPage extends StatelessWidget {
  static const String routeName = '/stock/add';

  const AddStockPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AddStockScreen(),
    );
  }
}
