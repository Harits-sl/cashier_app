import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/presentation/features/product/index.dart';
import 'package:cashier_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  static const String routeName = '/product';

  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: const [
                CustomAppBar(title: 'Products'),
                ItemProductScreen(),
                // spasi dari produk ke widget floating button
                SizedBox(height: (defaultMargin * 2) + 55),
              ],
            ),
            const FloatingAddButtonScreen(),
          ],
        ),
      ),
    );
  }
}
