import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/core/utils/string_helper.dart';
import 'package:cashier_app/src/presentation/features/filter/cubit/filter_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);
  static const String routeName = '/filter';

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  DateTime? firstDate;
  DateTime? secondDate;
  late Timestamp firstTimestamp;
  late Timestamp secondTimestamp;
  @override
  void initState() {
    super.initState();

    firstDate = DateTime.now();
    secondDate = DateTime.now();

    firstTimestamp = Timestamp.fromDate(firstDate!);
    secondTimestamp = Timestamp.fromDate(secondDate!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Filter'),
      ),
      body: Column(
        children: [
          Row(
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
                        Timestamp firstTimestamp =
                            Timestamp.fromDate(firstDate!);
                        Timestamp secondTimestamp =
                            Timestamp.fromDate(secondDate!);

                        context.read<FilterCubit>().fetchFilterDateOrder(
                            firstTimestamp, secondTimestamp);
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

                        Timestamp firstTimestamp =
                            Timestamp.fromDate(firstDate!);
                        Timestamp secondTimestamp =
                            Timestamp.fromDate(secondDate!);

                        context.read<FilterCubit>().fetchFilterDateOrder(
                            firstTimestamp, secondTimestamp);
                      });
                    });
                  },
                ),
              ),
            ],
          ),
          BlocBuilder<FilterCubit, FilterState>(
            builder: (context, state) {
              if (state is FilterLoading) {
                return const CircularProgressIndicator();
              }
              if (state is FilterSuccess) {
                final orders = state.orders;
                int total = 0;
                for (var order in orders) {
                  total += order.total;
                }
                debugPrint('total: ${total}');
                return Column(
                  children: [
                    Column(
                      children: orders
                          .map((order) => Text(order.total.toString()))
                          .toList(),
                    ),
                    Text('Total $total'),
                  ],
                );
              }
              if (state is FilterFailed) {
                return Text(state.error);
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
