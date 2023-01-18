import 'package:cashier_app/src/config/route/go.dart';
import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/core/utils/string_helper.dart';
import 'package:cashier_app/src/data/models/menu_model.dart';
import 'package:cashier_app/src/presentation/features/admin/index.dart';
import 'package:cashier_app/src/presentation/features/admin_menu_edit/index.dart';
import 'package:cashier_app/src/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    context.read<AdminCubit>().getAllMenu();

    void onEditPressed({required String path, required String id}) {
      Go.routeWithPath(context: context, path: path, arguments: id);
    }

    void onDeletePressed(String id) {
      context.read<AdminCubit>().deleteMenu(id);

      setState(() {});

      const snackBar = SnackBar(content: Text('success deleted'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    Widget itemMenu(MenuModel menu) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(menu.name),
                  Text(StringHelper.addComma(menu.price)),
                  Text('hpp: '),
                  Text(menu.typeMenu),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: CustomButton(
                color: blueColor,
                onPressed: () => onEditPressed(
                    path: AdminMenuEditPage.routeName, id: menu.id),
                margin: const EdgeInsets.only(right: 8),
                text: 'edit',
              ),
            ),
            Expanded(
              flex: 1,
              child: CustomButton(
                color: redColor,
                onPressed: () {
                  onDeletePressed(menu.id);
                },
                text: 'delete',
              ),
            ),
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
        debugPrint('state: ${state}');
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
