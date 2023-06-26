import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/core/utils/status_inventory.dart';
import 'package:cashier_app/src/data/models/stock_model.dart';
import 'package:cashier_app/src/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

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
          DataGridCell<String>(
            columnName: 'unit',
            value: data.unit,
          ),
          DataGridCell<StatusInventory>(
            columnName: 'status',
            value: data.status,
          ),
          const DataGridCell<Widget>(
            columnName: 'action',
            value: null,
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
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      height: 55,
                      margin: const EdgeInsets.all(8),
                      color: yellowColor,
                      onPressed: () {},
                      text: 'Edit',
                      textStyle: primaryTextStyle,
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      height: 55,
                      margin: const EdgeInsets.all(8),
                      color: redColor,
                      onPressed: () {},
                      text: 'Delete',
                    ),
                  ),
                ],
              );
            },
          );
        } else if (dataGridCell.columnName == 'status') {
          Map status = {};
          switch (dataGridCell.value) {
            case StatusInventory.inStock:
              status = {
                'text': 'In Stock',
                'color': greenColor,
                'textStyle': white2TextStyle,
              };
              break;
            case StatusInventory.lowStock:
              status = {
                'text': 'Low Stock',
                'color': yellowColor,
                'textStyle': primaryTextStyle,
              };
              break;
            case StatusInventory.outOfStock:
              status = {
                'text': 'Out Of Stock',
                'color': redColor,
                'textStyle': white2TextStyle,
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
        } else {
          return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                dataGridCell.value.toString(),
                style: primaryTextStyle.copyWith(fontSize: 12),
              ));
        }
      }).toList(),
    );
  }
}
