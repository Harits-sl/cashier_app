import 'package:cashier_app/src/config/route/go.dart';
import 'package:cashier_app/src/config/route/routes.dart';
import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/presentation/features/stock/data_row/stock_data_source.dart';
import 'package:cashier_app/src/presentation/features/stock/index.dart';
import 'package:cashier_app/src/presentation/features/stock/screens/item_stock_screen.dart';
import 'package:cashier_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:cashier_app/src/presentation/widgets/custom_button.dart';
import 'package:cashier_app/src/presentation/widgets/custom_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  void initState() {
    super.initState();
    // fetch Stock
    context.read<StockBloc>().add(FetchStock());
  }

  @override
  Widget build(BuildContext context) {
    void _navigateToAddStock() {
      Go.routeWithPath(context: context, path: Routes.addStock);
    }

    Widget _buildButtonAddStock() {
      return UnconstrainedBox(
        alignment: Alignment.topLeft,
        child: CustomButton(
          width: 150,
          height: 45,
          color: primaryColor,
          onPressed: _navigateToAddStock,
          text: '+ Add New Stock',
        ),
      );
    }

    Widget _buildTextDataStocks() {
      return Padding(
        padding: const EdgeInsets.only(
          left: defaultMargin,
          bottom: 8,
        ),
        child: Text(
          'Stocks Data',
          style: primaryTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget _buildTable() {
      return BlocConsumer<StockBloc, StockState>(
        listener: (context, state) {
          if (state is StockDeleteSuccess) {
            context.read<StockBloc>().add(FetchStock());

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is StockDeleteLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Processing Data'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is StockSuccess) {
            return Expanded(
              child: CustomTable(
                source: StockDataSource(stock: state.stocks),
                isAddAction: false,
                columns: [
                  columnItem('no', 'No.'),
                  columnItem('name', 'Nama'),
                  columnItem('quantity', 'Quantity'),
                  columnItem('minimumQuantity', 'Minimum Quantity'),
                  columnItem('unit', 'Unit'),
                  columnItem('status', 'Status'),
                  columnItem('action', 'Action'),
                ],
              ),
            );
          } else if (state is StockLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StockDeleteLoading) {
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

    _buildListStocks() {
      return BlocConsumer<StockBloc, StockState>(
        listener: (context, state) {
          if (state is StockDeleteSuccess) {
            context.read<StockBloc>().add(FetchStock());

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is StockDeleteLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Processing Data'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is StockSuccess) {
            int i = 0;
            return Column(
              children: state.stocks.map((stock) {
                i++;
                return ItemStockScreen(
                  id: stock.id,
                  name: stock.name,
                  quantity: stock.quantity,
                  minimumQuantity: stock.minimumQuantity,
                  unit: stock.unit,
                  status: stock.status,
                  marginTop: i != 1 ? 12 : 0,
                );
              }).toList(),
            );
          } else if (state is StockLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StockDeleteLoading) {
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
      return SafeArea(
        child: ListView(
          children: [
            const CustomAppBar(title: 'Stock'),
            _buildButtonAddStock(),
            _buildTextDataStocks(),
            // _buildTable(),
            _buildListStocks(),
            const SizedBox(height: defaultMargin),
          ],
        ),
      );
    }

    return _buildBody();
  }
}
