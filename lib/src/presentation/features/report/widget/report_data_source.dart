import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/presentation/features/report/index.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ReportDataSource extends DataGridSource {
  ReportDataSource({required List<ReportOrder> reportOrders}) {
    dataGridRows = reportOrders
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(
                  columnName: 'tanggal', value: dataGridRow.tanggal),
              DataGridCell<int>(
                  columnName: 'totalMinuman', value: dataGridRow.totalMinuman),
              DataGridCell<int>(
                  columnName: 'totalMakanan', value: dataGridRow.totalMakanan),
              DataGridCell<int>(
                  columnName: 'jumlahMakananTerjual',
                  value: dataGridRow.jumlahMakananTerjual),
              DataGridCell<int>(
                  columnName: 'jumlahMinumanTerjual',
                  value: dataGridRow.jumlahMinumanTerjual),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            style: primaryTextStyle.copyWith(fontSize: 12),
          ));
    }).toList());
  }
}
