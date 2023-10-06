import 'package:cashier_app/src/core/utils/string_helper.dart';
import 'package:cashier_app/src/presentation/widgets/custom_button.dart';
import 'package:cashier_app/src/presentation/widgets/custom_table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'index.dart';
import 'data_row/report_data_source.dart';

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

    reportCubit = context.read<ReportCubit>();
    reportCubit.setIdRadio = 1;
    fetchReportOrder();
    // reportCubit.fetchReportOrderToday();
  }

  @override
  void dispose() {
    super.dispose();
    reportCubit.initState();
  }

  fetchReportOrder() {
    switch (reportCubit.idRadio) {
      case 1:
        reportCubit.fetchReportOrderToday();
        break;
      case 2:
        reportCubit.fetchReportOrderThisMonth();
        break;
      default:
        reportCubit.fetchReportOrderToday();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildDatePickerCustom() {
      Widget _datePickerItem({
        DateTime? fromDate,
        DateTime? toDate,
      }) {
        DateTime selectInitialDate() {
          if (fromDate != null) {
            return fromDate;
          } else if (toDate != null) {
            return toDate;
          } else {
            return DateTime.now();
          }
        }

        DateTime initialDate = selectInitialDate();

        return GestureDetector(
          child: Row(
            children: [
              Text(
                fromDate != null
                    ? 'From ${StringHelper.dateFormat(firstDate!)}'
                    : 'To ${StringHelper.dateFormat(secondDate!)}',
                style: primaryTextStyle,
              ),
              const SizedBox(width: 8),
              Image.asset(
                'assets/images/ic_date.png',
                width: 22,
                color: primaryColor,
              ),
            ],
          ),
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2099),
              currentDate: DateTime.now(),
            ).then((date) {
              setState(() {
                if (date != null) {
                  if (fromDate != null) {
                    firstDate = date;
                  } else {
                    secondDate = date;
                  }
                }
              });
            });
          },
        );
      }

      return Container(
        margin: const EdgeInsets.fromLTRB(defaultMargin, 12, defaultMargin, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _datePickerItem(fromDate: firstDate),
            const SizedBox(height: 8),
            _datePickerItem(toDate: secondDate),
            CustomButton(
              margin: const EdgeInsets.only(top: 12),
              width: 150,
              height: 40,
              color: primaryColor,
              text: 'Search',
              onPressed: () {
                reportCubit.initState();
                context
                    .read<ReportCubit>()
                    .fetchReportDateOrder(firstDate!, secondDate!);
              },
            ),
          ],
        ),
      );
    }

    Widget _buildDatePicker() {
      Widget _datePickerItem(int id, String title) {
        return Expanded(
          child: GestureDetector(
            onTap: () {
              reportCubit.initState();
              reportCubit.setIdRadio = id;
              fetchReportOrder();
              setState(() {});
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: reportCubit.idRadio == id
                    ? backgroundColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                title,
                style: primaryTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: medium,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: lightGray2Color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            _datePickerItem(1, 'Today'),
            _datePickerItem(2, 'This Month'),
            _datePickerItem(3, 'Custom'),
          ],
        ),
      );
    }

    Widget tableSfDataGrid() {
      return BlocBuilder<ReportCubit, ReportState>(
        builder: (context, state) {
          if (state is ReportSuccess) {
            return CustomTable(
              frozenColumnsCount: 2,
              columnWidthMode: ColumnWidthMode.auto,
              source: ReportDataSource(
                reportOrders: state.orders,
                reportCubit: reportCubit,
              ),
              columns: [
                columnItem('no', 'No.'),
                columnItem('tanggal', 'Tanggal'),
                columnItem('totalMinuman', 'Total Minuman'),
                columnItem('totalMakanan', 'Total Makanan'),
                columnItem('jumlahMinumanTerjual', 'Jumlah Minuman Terjual'),
                columnItem('jumlahMakananTerjual', 'Jumlah Makanan Terjual'),
                columnItem('labaMinuman', 'Laba Minuman'),
                columnItem('labaMakanan', 'Laba Makanan'),
                columnItem('labaBersihMinuman', 'Laba Bersih Minuman'),
                columnItem('labaBersihMakanan', 'Laba Bersih Makanan'),
                columnItem('labaBersihSeluruh', 'Laba Bersih Seluruh'),
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
      body: WillPopScope(
        onWillPop: () async {
          reportCubit.initState();
          return true;
        },
        child: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(title: 'Report'),
              _buildDatePicker(),
              reportCubit.idRadio == 3
                  ? _buildDatePickerCustom()
                  : const SizedBox(),
              const SizedBox(height: 12),
              Expanded(
                child: tableSfDataGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
