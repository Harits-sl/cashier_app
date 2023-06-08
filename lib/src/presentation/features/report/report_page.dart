import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/core/utils/string_helper.dart';
import 'package:cashier_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'index.dart';
import 'widget/report_data_source.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);
  static const String routeName = '/report';

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  DateTime? firstDate;
  DateTime? secondDate;
  late Timestamp firstTimestamp;
  late Timestamp secondTimestamp;

  List<ReportOrder> reportOrder = [];

  late ReportDataSource _reportDataSource;
  List<ReportOrder> _reportOrders = <ReportOrder>[];

  @override
  void initState() {
    super.initState();

    firstDate = DateTime.now();
    secondDate = DateTime.now();

    firstTimestamp = Timestamp.fromDate(firstDate!);
    secondTimestamp = Timestamp.fromDate(secondDate!);

    _reportOrders = getReportOrders();
    _reportDataSource = ReportDataSource(reportOrders: _reportOrders);
  }

  List<ReportOrder> getReportOrders() {
    return [
      ReportOrder(
          id: 1,
          tanggal: 'senin',
          totalMakanan: 24,
          totalMinuman: 3,
          jumlahMakananTerjual: 2,
          jumlahMinumanTerjual: 1),
      ReportOrder(
          id: 2,
          tanggal: 'selasa',
          totalMakanan: 1,
          totalMinuman: 5,
          jumlahMakananTerjual: 4,
          jumlahMinumanTerjual: 2),
      ReportOrder(
          id: 3,
          tanggal: 'Rabu',
          totalMakanan: 8,
          totalMinuman: 10,
          jumlahMakananTerjual: 8,
          jumlahMinumanTerjual: 3),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildDatePicker() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            color: blueColor,
            child: GestureDetector(
              child: Text(StringHelper.dateFormat(firstDate!)),
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2099),
                ).then((date) {
                  setState(() {
                    firstDate = date;
                    Timestamp firstTimestamp = Timestamp.fromDate(firstDate!);
                    Timestamp secondTimestamp = Timestamp.fromDate(secondDate!);

                    context
                        .read<ReportCubit>()
                        .fetchReportDateOrder(firstTimestamp, secondTimestamp);
                  });
                });
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: blueColor,
            child: GestureDetector(
              child: Text(StringHelper.dateFormat(secondDate!)),
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2099),
                ).then((date) {
                  setState(() {
                    secondDate = date;

                    Timestamp firstTimestamp = Timestamp.fromDate(firstDate!);
                    Timestamp secondTimestamp = Timestamp.fromDate(secondDate!);

                    context
                        .read<ReportCubit>()
                        .fetchReportDateOrder(firstTimestamp, secondTimestamp);
                  });
                });
              },
            ),
          ),
        ],
      );
    }

    Widget _buildDatePicker2() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: lightGray2Color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  'Today',
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: medium,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  // color: backgroundColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  'This Month',
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: medium,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  // color: backgroundColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  'Custom',
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: medium,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildReportItem() {
      return BlocBuilder<ReportCubit, ReportState>(
        builder: (context, state) {
          if (state is ReportLoading) {
            return const CircularProgressIndicator();
          }
          if (state is ReportSuccess) {
            final orders = state.orders;
            int total = 0;
            int totalHpp = 0;
            for (var order in orders) {
              total += order.total;
            }
            debugPrint('total: ');
            return Expanded(
              child: ListView(
                children: [
                  Column(
                    children: orders.map((order) {
                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: order.listMenus!.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              // totalHpp +=
                              //     order.listMenus![index]['hpp'] as int;

                              return Column(
                                children: [
                                  Text(
                                      '${order.listMenus![index]['menuName']} x ${order.listMenus![index]['totalBuy']}'),
                                  Text(
                                      'harga: ${order.listMenus![index]['price']}'),
                                  Text(
                                      'hpp: ${order.listMenus![index]['hpp']}'),
                                  SizedBox(
                                    height: 12,
                                  ),
                                ],
                              );
                            },
                          ),
                          Text('total: ${order.total}'),
                          // Text('hpp: ${order.hpp}'),
                          Divider(
                            thickness: 2,
                            color: blackColor,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  Text('Total Semua: '),
                  // Text('Total hpp: ')6,
                ],
              ),
            );
          }
          if (state is ReportFailed) {
            return Text(state.error);
          }
          return Container();
        },
      );
    }

    Widget _buildTableReport() {
      List dataColumn = [
        'NO',
        'TANGGAL',
        'TOTAL MINUMAN',
        'TOTAL MAKANAN',
        'JUMLAH MINUMAN TERJUAL',
        'JUMLAH MAKANAN TERJUAL',
        'LABA MINUMAN',
        'LABA MAKANAN',
        'LABA BERSIH MINUMAN',
        'LABA BERSIH MAKANAN',
        'LABA BERSIH SELURUH',
      ];
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: dataColumn
              .map(
                (data) => DataColumn(
                  label: Expanded(
                    child: Text(
                      data,
                    ),
                  ),
                ),
              )
              .toList(),
          rows: [
            DataRow(
              cells: dataColumn
                  .map(
                    (data) => DataCell(
                      Text(data),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );
    }

    Widget tableSfDataGrid() {
      GridColumn gridColumnItem(String columnName, String label) {
        return GridColumn(
          columnName: columnName,
          label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.centerRight,
            child: Text(
              label,
              style: primaryTextStyle.copyWith(fontSize: 12),
            ),
          ),
        );
      }

      return SfDataGrid(
        source: _reportDataSource,
        columnWidthMode: ColumnWidthMode.fitByColumnName,
        columns: [
          gridColumnItem('no', 'No.'),
          gridColumnItem('tanggal', 'Tanggal'),
          gridColumnItem('totalMinuman', 'Total Minuman'),
          gridColumnItem('totalMakanan', 'Total Makanan'),
          gridColumnItem('jumlahMinumanTerjual', 'Jumlah Minuman Terjual'),
          gridColumnItem('jumlahMakananTerjual', 'Jumlah Makanan Terjual'),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: 'Report'),
            // _buildDatePicker(),
            _buildDatePicker2(),
            _buildReportItem(),
            // _buildTableReport(),
            tableSfDataGrid(),
          ],
        ),
      ),
    );
  }
}

class ReportOrder {
  final int id;
  final String tanggal;
  final int totalMinuman;
  final int totalMakanan;
  final int jumlahMinumanTerjual;
  final int jumlahMakananTerjual;
  // final int labaMinuman;
  // final int labaMakanan;
  // final int labaBersihMinuman;
  // final int labaBersihMakanan;
  // final int labaBersihSeluruh;

  ReportOrder({
    required this.id,
    required this.tanggal,
    required this.totalMinuman,
    required this.totalMakanan,
    required this.jumlahMinumanTerjual,
    required this.jumlahMakananTerjual,
    // required this.labaMinuman,
    // required this.labaMakanan,
    // required this.labaBersihMinuman,
    // required this.labaBersihMakanan,
    // required this.labaBersihSeluruh,
  });
}
