import 'package:cashier_app/src/config/route/go.dart';
import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/core/utils/string_helper.dart';
import 'package:cashier_app/src/data/models/menu_model.dart';
import 'package:cashier_app/src/presentation/features/product/index.dart';
import 'package:cashier_app/src/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemProductScreen extends StatefulWidget {
  const ItemProductScreen({Key? key}) : super(key: key);

  @override
  State<ItemProductScreen> createState() => _ItemProductScreenState();
}

class _ItemProductScreenState extends State<ItemProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getAllMenu();
  }

  @override
  Widget build(BuildContext context) {
    void onEditPressed(id) {
      Go.routeWithPath(
        context: context,
        path: EditProductPage.routeName,
        arguments: id,
      );
    }

    void onDeletePressed(String id) {
      context.read<ProductCubit>().deleteMenu(id);

      setState(() {
        context.read<ProductCubit>().getAllMenu();
      });

      const snackBar = SnackBar(content: Text('success deleted'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    Widget editButton(String id) {
      return CustomButton(
        color: yellowColor,
        width: 65,
        height: 32,
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        borderRadius: BorderRadius.circular(10),
        text: 'Edit',
        textStyle: primaryTextStyle.copyWith(fontSize: 12),
        onPressed: () => onEditPressed(id),
      );
    }

    Widget deleteButton(String id) {
      return CustomButton(
        color: redColor,
        width: 65,
        height: 32,
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        borderRadius: BorderRadius.circular(10),
        text: 'Delete',
        textStyle: primaryTextStyle.copyWith(fontSize: 12),
        onPressed: () => onDeletePressed(id),
      );
    }

    Widget itemMenu(MenuModel menu, double marginTop) {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: marginTop),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: lightGray2Color,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama: ${menu.name}',
                  style: primaryTextStyle.copyWith(fontSize: 12),
                ),
                RichText(
                  text: TextSpan(
                      text: 'Harga: ',
                      style: primaryTextStyle.copyWith(fontSize: 12),
                      children: [
                        TextSpan(
                          text: 'Rp. ${StringHelper.addComma(menu.price)}',
                          style: greenTextStyle.copyWith(fontSize: 12),
                        ),
                      ]),
                ),
                RichText(
                  text: TextSpan(
                      text: 'HPP: ',
                      style: primaryTextStyle.copyWith(fontSize: 12),
                      children: [
                        TextSpan(
                          text: 'Rp. ${StringHelper.addComma(menu.hpp)}',
                          style: yellowTextStyle.copyWith(fontSize: 12),
                        ),
                      ]),
                ),
                Text(
                  'Tipe: ${menu.typeMenu}',
                  style: primaryTextStyle.copyWith(fontSize: 12),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                editButton(menu.id),
                const SizedBox(height: 8),
                deleteButton(menu.id),
              ],
            ),
          ],
        ),
      );
    }

    Widget listMenu(List<MenuModel> menus) {
      int i = 0;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: menus.map((menu) {
            i++;
            double marginTop = i != 1 ? 12 : 0;
            return itemMenu(menu, marginTop);
          }).toList(),
        ),
      );
    }

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductSuccess) {
          return listMenu(state.menus);
        }
        if (state is ProductLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is ProductFailed) {
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
