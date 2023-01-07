import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:cashier_app/src/presentation/features/admin_menu_edit/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminMenuEditPage extends StatefulWidget {
  static const String routeName = '/edit-menu';

  final String id;

  const AdminMenuEditPage({Key? key, required this.id}) : super(key: key);

  @override
  State<AdminMenuEditPage> createState() => _AdminMenuEditPageState();
}

class _AdminMenuEditPageState extends State<AdminMenuEditPage> {
  @override
  void initState() {
    super.initState();

    context.read<AdminMenuEditBloc>().setId = widget.id;
    context.read<AdminMenuEditBloc>().add(FetchMenuById());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Menu'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          context.read<AdminMenuEditBloc>().add(ClearState());
          return true;
        },
        child: Container(
          margin: EdgeInsets.all(defaultMargin),
          child: Column(
            children: [
              FieldEditMenu(),
            ],
          ),
        ),
      ),
    );
  }
}
