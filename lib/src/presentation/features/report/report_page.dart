import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late ReportCubit reportCubit;

  @override
  void initState() {
    super.initState();

    firstDate = DateTime.now();
    secondDate = DateTime.now();

    firstTimestamp = Timestamp.fromDate(firstDate!);
    secondTimestamp = Timestamp.fromDate(secondDate!);

    reportCubit = context.read<ReportCubit>();
    reportCubit.fetchReportOrderToday();
  }

  @override
  Widget build(BuildContext context) {
    // Widget _buildDatePickerCustom() {
    //   return Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Container(
    //         padding: const EdgeInsets.all(10),
    //         color: blueColor,
    //         child: GestureDetector(
    //           child: Text(StringHelper.dateFormat(firstDate!)),
    //           onTap: () {
    //             showDatePicker(
    //               context: context,
    //               initialDate: DateTime.now(),
    //               firstDate: DateTime(2000),
    //               lastDate: DateTime(2099),
    //             ).then((date) {
    //               setState(() {
    //                 firstDate = date;
    //                 Timestamp firstTimestamp = Timestamp.fromDate(firstDate!);
    //                 Timestamp secondTimestamp = Timestamp.fromDate(secondDate!);

    //                 context
    //                     .read<ReportCubit>()
    //                     .fetchReportDateOrder(firstTimestamp, secondTimestamp);
    //               });
    //             });
    //           },
    //         ),
    //       ),
    //       Container(
    //         padding: const EdgeInsets.all(10),
    //         color: blueColor,
    //         child: GestureDetector(
    //           child: Text(StringHelper.dateFormat(secondDate!)),
    //           onTap: () {
    //             showDatePicker(
    //               context: context,
    //               initialDate: DateTime.now(),
    //               firstDate: DateTime(2000),
    //               lastDate: DateTime(2099),
    //             ).then((date) {
    //               setState(() {
    //                 secondDate = date;

    //                 Timestamp firstTimestamp = Timestamp.fromDate(firstDate!);
    //                 Timestamp secondTimestamp = Timestamp.fromDate(secondDate!);

    //                 context
    //                     .read<ReportCubit>()
    //                     .fetchReportDateOrder(firstTimestamp, secondTimestamp);
    //               });
    //             });
    //           },
    //         ),
    //       ),
    //     ],
    //   );
    // }

    Widget _buildDatePicker() {
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

    Widget tableSfDataGrid() {
      GridColumn gridColumnItem(String columnName, String label) {
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

      return BlocBuilder<ReportCubit, ReportState>(
        builder: (context, state) {
          if (state is ReportSuccess) {
            return SfDataGrid(
              shrinkWrapRows: true,
              source: ReportDataSource(
                reportOrders: state.orders,
                reportCubit: reportCubit,
              ),
              columnWidthMode: ColumnWidthMode.auto,
              columns: [
                gridColumnItem('no', 'No.'),
                gridColumnItem('tanggal', 'Tanggal'),
                gridColumnItem('totalMinuman', 'Total Minuman'),
                gridColumnItem('totalMakanan', 'Total Makanan'),
                gridColumnItem(
                    'jumlahMinumanTerjual', 'Jumlah Minuman Terjual'),
                gridColumnItem(
                    'jumlahMakananTerjual', 'Jumlah Makanan Terjual'),
                gridColumnItem('labaMinuman', 'Laba Minuman'),
                gridColumnItem('labaMakanan', 'Laba Makanan'),
                gridColumnItem('labaBersihMinuman', 'Laba Bersih Minuman'),
                gridColumnItem('labaBersihMakanan', 'Laba Bersih Makanan'),
                gridColumnItem('labaBersihSeluruh', 'Laba Bersih Seluruh'),
              ],
            );
          } else if (state is ReportLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReportFailed) {
            return Text(state.error);
          } else {
            return const SizedBox();
          }
        },
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const CustomAppBar(title: 'Report'),
            _buildDatePicker(),
            // _buildDatePickerCustom(),
            const SizedBox(height: 16),
            tableSfDataGrid(),
          ],
        ),
      ),
    );
  }
}
