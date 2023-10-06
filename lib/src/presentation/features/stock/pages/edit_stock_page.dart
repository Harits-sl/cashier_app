import 'package:cashier_app/src/presentation/features/stock/index.dart';
import 'package:flutter/material.dart';

class EditStockPage extends StatelessWidget {
  static const String routeName = '/stock/edit';

  const EditStockPage({super.key, required this.id});

  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditStockScreen(id: id),
    );
  }
}
