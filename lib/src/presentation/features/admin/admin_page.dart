import 'package:flutter/material.dart';
import 'package:cashier_app/src/presentation/features/admin/index.dart';

class AdminPage extends StatelessWidget {
  static const String routeName = '/admin';

  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Admin'),
      ),
      body: Column(
        children: const [
          Menu(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
