import 'package:flutter/material.dart';
import 'package:cashier_app/src/presentation/features/add_menu/index.dart';

class AddMenuPage extends StatefulWidget {
  static const String routeName = '/addMenu';

  const AddMenuPage({Key? key}) : super(key: key);

  @override
  _AddMenuPageState createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddMenu'),
      ),
      body: Container(),
    );
  }
}
