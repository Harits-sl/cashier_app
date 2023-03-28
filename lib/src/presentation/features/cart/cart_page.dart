import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:cashier_app/src/presentation/features/cart/index.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);
  static const String routeName = '/cart';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cart'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(defaultMargin),
          child: Column(
            children: [
              MenuOrder(),
            ],
          ),
        ),
      ),
    );
  }
}
