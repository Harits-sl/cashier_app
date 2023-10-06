import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/core/utils/string_helper.dart';
import 'package:cashier_app/src/presentation/features/report/index.dart';
import 'package:cashier_app/src/presentation/features/report/report_order.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ReportDataSource extends DataGridSource {
  ReportDataSource({
    required List<ReportOrder> reportOrders,
    required ReportCubit reportCubit,
  }) {
    int no = 0;
    dataGridRows = reportOrders.map<DataGridRow>((data) {
      no++;
      return DataGridRow(
        cells: [
          DataGridCell<int>(columnName: 'no', value: no),
          DataGridCell<String>(columnName: 'tanggal', value: data.tanggal),
          DataGridCell<String>(
              columnName: 'totalMinuman',
              value: StringHelper.addComma(data.totalMinuman)),
          DataGridCell<String>(
              columnName: 'totalMakanan',
              value: StringHelper.addComma(data.totalMakanan)),
          DataGridCell<String>(
              columnName: 'jumlahMinumanTerjual',
              value: data.jumlahMinumanTerjual != 0
                  ? 'Rp. ${StringHelper.addComma(data.jumlahMinumanTerjual)}'
                  : '0'),
          DataGridCell<String>(
              columnName: 'jumlahMakananTerjual',
              value: data.jumlahMakananTerjual != 0
                  ? 'Rp. ${StringHelper.addComma(data.jumlahMakananTerjual)}'
                  : '0'),
          DataGridCell<String>(
              columnName: 'labaMinuman',
              value: data.labaMinuman != 0
                  ? 'Rp. ${StringHelper.addComma(data.labaMinuman)}'
                  : '0'),
          DataGridCell<String>(
              columnName: 'labaMakanan',
              value: data.labaMakanan != 0
                  ? 'Rp. ${StringHelper.addComma(data.labaMakanan)}'
                  : '0'),
          DataGridCell<String>(
              columnName: 'labaBersihMinuman',
              value: data.labaBersihMinuman != 0
                  ? 'Rp. ${StringHelper.addComma(data.labaBersihMinuman)}'
                  : '0'),
          DataGridCell<String>(
              columnName: 'labaBersihMakanan',
              value: data.labaBersihMakanan != 0
                  ? 'Rp. ${StringHelper.addComma(data.labaBersihMakanan)}'
                  : '0'),
          DataGridCell<String>(
              columnName: 'labaBersihSeluruh',
              value: data.labaBersihSeluruh != 0
                  ? 'Rp. ${StringHelper.addComma(data.labaBersihSeluruh)}'
                  : '0'),
        ],
      );
    }).toList();
    dataGridRows.add(DataGridRow(
      cells: [
        DataGridCell<String>(columnName: 'no', value: ''),
        DataGridCell<String>(columnName: 'tanggal', value: 'Total'),
        DataGridCell<String>(
            columnName: 'totalMinuman',
            value: StringHelper.addComma(reportCubit.seluruhTotalMinuman)),
        DataGridCell<String>(
            columnName: 'totalMakanan',
            value: StringHelper.addComma(reportCubit.seluruhTotalMakanan)),
        DataGridCell<String>(
            columnName: 'jumlahMinumanTerjual',
            value: reportCubit.seluruhJumlahMinumanTerjual != 0
                ? 'Rp. ${StringHelper.addComma(reportCubit.seluruhJumlahMinumanTerjual)}'
                : '0'),
        DataGridCell<String>(
            columnName: 'jumlahMakananTerjual',
            value: reportCubit.seluruhJumlahMakananTerjual != 0
                ? 'Rp. ${StringHelper.addComma(reportCubit.seluruhJumlahMakananTerjual)}'
                : '0'),
        DataGridCell<String>(
            columnName: 'labaMinuman',
            value: reportCubit.seluruhLabaMinuman != 0
                ? 'Rp. ${StringHelper.addComma(reportCubit.seluruhLabaMinuman)}'
                : '0'),
        DataGridCell<String>(
            columnName: 'labaMakanan',
            value: reportCubit.seluruhLabaMakanan != 0
                ? 'Rp. ${StringHelper.addComma(reportCubit.seluruhLabaMakanan)}'
                : '0'),
        DataGridCell<String>(
            columnName: 'labaBersihMinuman',
            value: reportCubit.seluruhLabaBersihMinuman != 0
                ? 'Rp. ${StringHelper.addComma(reportCubit.seluruhLabaBersihMinuman)}'
                : '0'),
        DataGridCell<String>(
            columnName: 'labaBersihMakanan',
            value: reportCubit.seluruhLabaBersihMakanan != 0
                ? 'Rp. ${StringHelper.addComma(reportCubit.seluruhLabaBersihMakanan)}'
                : '0'),
        DataGridCell<String>(
            columnName: 'labaBersihSeluruh',
            value: reportCubit.totalseluruhLabaBersih != 0
                ? 'Rp. ${StringHelper.addComma(reportCubit.seluruhLabaBersihMinuman)}'
                : '0'),
      ],
    ));
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
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            dataGridCell.value.toString(),
            style: primaryTextStyle.copyWith(fontSize: 12),
          ));
    }).toList());
  }
}
