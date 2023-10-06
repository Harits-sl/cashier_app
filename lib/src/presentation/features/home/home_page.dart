import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:flutter/material.dart';

import 'index.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: const SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: Income(),
            ),
            Expanded(
              child: Shortcut(),
            ),
          ],
        ),
      ),
    );
  }
}
