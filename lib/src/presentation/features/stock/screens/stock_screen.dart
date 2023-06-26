import 'package:cashier_app/src/core/utils/status_inventory.dart';
import 'package:cashier_app/src/data/models/stock_model.dart';
import 'package:cashier_app/src/presentation/features/stock/bloc/stock_bloc.dart';
import 'package:cashier_app/src/presentation/features/stock/data_row/stock_data_source.dart';
import 'package:cashier_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:cashier_app/src/presentation/widgets/custom_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // fetch Stock
    context.read<StockBloc>().add(FetchStock());

    // List<StockModel> stock = [
    //   StockModel(
    //     name: 'nama',
    //     quantity: 'quantity',
    //     unit: 'ml',
    //     status: StatusInventory.inStock,
    //     createdAt: DateTime.now(),
    //     updatedAt: DateTime.now(),
    //   ),
    //   StockModel(
    //     name: 'nama',
    //     quantity: 'quantity',
    //     unit: 'g',
    //     status: StatusInventory.inStock,
    //     createdAt: DateTime.now(),
    //     updatedAt: DateTime.now(),
    //   ),
    // ];

    Widget _buildTable() {
      return BlocBuilder<StockBloc, StockState>(
        builder: (context, state) {
          if (state is StockSuccess) {
            return CustomTable(
              source: StockDataSource(stock: state.stocks),
              isAddAction: false,
              columns: [
                columnItem('no', 'No.'),
                columnItem('name', 'Nama'),
                columnItem('quantity', 'Quantity'),
                columnItem('unit', 'Unit'),
                columnItem('status', 'Status'),
                columnItem('action', 'Action'),
              ],
            );
          } else if (state is StockLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StockFailed) {
            return Text('Failed Fetch ${state.error}');
          } else {
            return const SizedBox();
          }
        },
      );
    }

    Widget _buildBody() {
      return ListView(
        children: [
          const CustomAppBar(title: 'Stock'),
          _buildTable(),
        ],
      );
    }

    return _buildBody();
  }
}
