import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/core/utils/string_helper.dart';
import 'package:cashier_app/src/data/models/menu_model.dart';
import 'package:cashier_app/src/presentation/features/admin/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AdminCubit>().getAllMenu();

    Widget itemMenu(MenuModel menu) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            // color: Colors.red,
            borderRadius: BorderRadius.circular(12),
            border: Border.all()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(menu.name),
            Text(StringHelper.addComma(menu.price)),
            Text(menu.typeMenu),
          ],
        ),
      );
    }

    Widget listMenu(List<MenuModel> menus) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: menus.map((menu) => itemMenu(menu)).toList(),
        ),
      );
    }

    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        if (state is AdminSuccess) {
          return listMenu(state.menus);
        }
        if (state is AdminLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is AdminFailed) {
          return Text(state.error);
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
