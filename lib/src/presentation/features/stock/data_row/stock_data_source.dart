import 'package:cashier_app/src/config/route/go.dart';
import 'package:cashier_app/src/config/route/routes.dart';
import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/core/utils/status_inventory.dart';
import 'package:cashier_app/src/data/models/stock_model.dart';
import 'package:cashier_app/src/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../index.dart';

class StockDataSource extends DataGridSource {
  StockDataSource({
    required List<StockModel> stock,
    // required ReportCubit reportCubit,
  }) {
    int no = 0;
    dataGridRows = stock.map<DataGridRow>((data) {
      no++;
      return DataGridRow(
        cells: [
          DataGridCell<int>(columnName: 'no', value: no),
          DataGridCell<String>(
            columnName: 'name',
            value: data.name,
          ),
          DataGridCell<int>(
            columnName: 'quantity',
            value: data.quantity,
          ),
          DataGridCell<int>(
            columnName: 'minimumQuantity',
            value: data.minimumQuantity,
          ),
          DataGridCell<String>(
            columnName: 'unit',
            value: data.unit,
          ),
          DataGridCell<StatusInventory>(
            columnName: 'status',
            value: data.status,
          ),
          DataGridCell<dynamic>(
            columnName: 'action',
            value: data.id,
          )
        ],
      );
    }).toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        if (dataGridCell.columnName == 'action') {
          return action(dataGridCell.value);
        } else if (dataGridCell.columnName == 'status') {
          return status(dataGridCell);
        } else {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              dataGridCell.value.toString(),
              style: primaryTextStyle.copyWith(fontSize: 12),
            ),
          );
        }
      }).toList(),
    );
  }

  Widget action(String id) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        void editStock() {
          Go.routeWithPathAndArgument(
              context: context, path: Routes.editStock, arguments: id);
        }

        void deleteStock() {
          context.read<StockBloc>().add(DeleteStock(id));
        }

        return Row(
          children: [
            Expanded(
              child: CustomButton(
                height: 55,
                margin: const EdgeInsets.all(8),
                color: yellowColor,
                onPressed: editStock,
                text: 'Edit',
                textStyle: primaryTextStyle,
              ),
            ),
            Expanded(
              child: CustomButton(
                height: 55,
                margin: const EdgeInsets.all(8),
                color: redColor,
                onPressed: deleteStock,
                text: 'Delete',
              ),
            ),
          ],
        );
      },
    );
  }

  Widget status(DataGridCell<dynamic> dataGridCell) {
    Map status = {};
    switch (dataGridCell.value) {
      case StatusInventory.inStock:
        status = {
          'text': StatusInventory.getValue(dataGridCell.value),
          'color': greenColor,
          'textStyle': white2TextStyle.copyWith(fontSize: 12),
        };
        break;
      case StatusInventory.lowStock:
        status = {
          'text': StatusInventory.getValue(dataGridCell.value),
          'color': yellowColor,
          'textStyle': primaryTextStyle.copyWith(fontSize: 12),
        };
        break;
      case StatusInventory.outOfStock:
        status = {
          'text': StatusInventory.getValue(dataGridCell.value),
          'color': redColor,
          'textStyle': white2TextStyle.copyWith(fontSize: 12),
        };
        break;
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: status['color'],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          status['text'],
          style: status['textStyle'],
        ),
      ),
    );
  }
}
