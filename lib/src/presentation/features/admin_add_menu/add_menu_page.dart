import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:cashier_app/src/presentation/features/admin_add_menu/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMenuPage extends StatelessWidget {
  const AddMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Menu'),
      ),
      body: BlocListener<AddMenuBloc, AddMenuState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            final snackBar = SnackBar(content: Text(state.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            context.read<AddMenuBloc>().add(ClearState());
          }
        },
        child: Container(
          margin: EdgeInsets.all(defaultMargin),
          child: Column(
            children: const [
              FieldMenu(),
              ButtonAddMenu(),
            ],
          ),
        ),
      ),
    );
  }
}
