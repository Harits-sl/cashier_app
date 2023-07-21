import 'package:cashier_app/src/config/route/go.dart';
import 'package:cashier_app/src/config/route/routes.dart';
import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class FloatingAddButtonScreen extends StatelessWidget {
  const FloatingAddButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void onPressed() {
      Go.routeWithPath(context: context, path: Routes.addProduct);
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: CustomButton(
        color: primaryColor,
        onPressed: onPressed,
        text: 'Add New Product',
        isShadowed: true,
      ),
    );
  }
}
