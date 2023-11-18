import 'package:cashier_app/src/core/utils/status_inventory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cashier_app/src/config/route/go.dart';
import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/presentation/features/stock/index.dart';
import 'package:cashier_app/src/presentation/widgets/custom_button.dart';

class ItemStockScreen extends StatelessWidget {
  const ItemStockScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.quantity,
    required this.minimumQuantity,
    required this.unit,
    required this.status,
    required this.marginTop,
  }) : super(key: key);

  final String id;
  final String name;
  final int quantity;
  final int minimumQuantity;
  final String unit;
  final StatusInventory? status;
  final double marginTop;

  @override
  Widget build(BuildContext context) {
    void onEditPressed(id) {
      Go.routeWithPath(
        context: context,
        path: EditStockPage.routeName,
        arguments: id,
      );
    }

    void onDeletePressed(String id) {
      context.read<StockBloc>().add(DeleteStock(id));

      context.read<StockBloc>().add(FetchStock());
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

    Widget buildStatus() {
      Map dataStatus = {};
      switch (status) {
        case StatusInventory.inStock:
          dataStatus = {
            'text': StatusInventory.getValue(status!),
            'color': greenColor,
            'textStyle': white2TextStyle.copyWith(fontSize: 12),
          };
          break;
        case StatusInventory.lowStock:
          dataStatus = {
            'text': StatusInventory.getValue(status!),
            'color': yellowColor,
            'textStyle': primaryTextStyle.copyWith(fontSize: 12),
          };
          break;
        case StatusInventory.outOfStock:
          dataStatus = {
            'text': StatusInventory.getValue(status!),
            'color': redColor,
            'textStyle': white2TextStyle.copyWith(fontSize: 12),
          };
          break;
        case null:
          dataStatus = {
            'text': 'Belom Ditambahkan',
            'color': blackColor,
            'textStyle': white2TextStyle.copyWith(fontSize: 12),
          };
      }

      return Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: dataStatus['color'],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            dataStatus['text'],
            style: dataStatus['textStyle'],
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: marginTop,
        left: defaultMargin,
        right: defaultMargin,
      ),
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
                'Nama: $name',
                style: primaryTextStyle.copyWith(fontSize: 12),
              ),
              Text(
                'Quantity: $quantity $unit',
                style: primaryTextStyle.copyWith(fontSize: 12),
              ),
              Text(
                'Minimum Quantity: $minimumQuantity $unit',
                style: primaryTextStyle.copyWith(fontSize: 12),
              ),
              buildStatus(),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              editButton(id),
              const SizedBox(height: 8),
              deleteButton(id),
            ],
          ),
        ],
      ),
    );
  }
}
