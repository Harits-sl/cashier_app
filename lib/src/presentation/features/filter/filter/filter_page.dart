import 'package:flutter/material.dart';
import 'package:cashier_app/src/presentation/features/filter/filter/index.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);
  static const String routeName = '/filter';

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Filter'),
      ),
    );
  }
}
