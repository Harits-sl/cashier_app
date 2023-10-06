import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CustomTable extends StatelessWidget {
  const CustomTable({
    required this.source,
    required this.columns,
    this.frozenColumnsCount = 0,
    this.isAddAction = false,
    this.columnWidthMode = ColumnWidthMode.none,
    super.key,
  });

  final DataGridSource source;
  final List<GridColumn> columns;
  final int frozenColumnsCount;
  final bool isAddAction;
  final ColumnWidthMode columnWidthMode;

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      // shrinkWrapRows: true,
      isScrollbarAlwaysShown: true,
      source: source,
      columnWidthMode: columnWidthMode,
      // verticalScrollPhysics: const NeverScrollableScrollPhysics(),
      onQueryRowHeight: isAddAction
          ? (details) {
              // Set the row height as 100.0 to the column header row.
              return details.rowIndex != 0 ? 100.0 : 50.0;
            }
          : null,
      defaultColumnWidth: 210,

      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      frozenColumnsCount: frozenColumnsCount,
      columns: columns,
    );
  }
}

GridColumn columnItem(String columnName, String label) {
  return GridColumn(
    columnName: columnName,
    label: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      alignment: Alignment.center,
      child: Text(
        label,
        style: primaryTextStyle.copyWith(fontSize: 12),
      ),
    ),
  );
}
