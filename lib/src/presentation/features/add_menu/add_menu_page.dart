import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:cashier_app/src/presentation/features/add_menu/index.dart';

class AddMenuPage extends StatefulWidget {
  const AddMenuPage({Key? key}) : super(key: key);

  @override
  _AddMenuPageState createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Menu'),
      ),
      body: Container(
        margin: EdgeInsets.all(defaultMargin),
        child: Column(
          children: const [
            FieldMenu(),
            ButtonAddMenu(),
          ],
        ),
      ),
    );
  }
}
