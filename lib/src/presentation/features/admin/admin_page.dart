import 'package:cashier_app/src/config/route/go.dart';
import 'package:cashier_app/src/config/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:cashier_app/src/presentation/features/admin/index.dart';

class AdminPage extends StatelessWidget {
  static const String routeName = '/admin';

  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _iconPressed() {
      Go.routeWithPath(context: context, path: Routes.addMenu);
    }

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Admin'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Menu(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _iconPressed,
      ),
    );
  }
}
