import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/core/utils/string_helper.dart';

import '../index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Income extends StatelessWidget {
  const Income({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().fetchOrder();

    Widget totalIncome(
      String title,
      int total, [
      bool isToday = false,
    ]) {
      return Column(
        children: [
          Text(
            title,
            style: primaryTextStyle.copyWith(
              fontWeight: regular,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            StringHelper.addComma(total),
            style: isToday
                ? secondaryTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  )
                : primaryTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  ),
          ),
        ],
      );
    }

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        Map<DateStatus, int> totalList = {};
        if (state is HomeSuccess) {
          totalList = state.totalList;
        }
        return Container(
          margin: const EdgeInsets.all(defaultMargin),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Center(
                  child: Text(
                    'Income',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        totalIncome(
                          'Today',
                          totalList.isEmpty ? 0 : totalList[DateStatus.today]!,
                          true,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        totalIncome(
                            'This Week',
                            totalList.isEmpty
                                ? 0
                                : totalList[DateStatus.oneWeek]!),
                      ],
                    ),
                    Column(
                      children: [
                        totalIncome(
                            'Yesterday',
                            totalList.isEmpty
                                ? 0
                                : totalList[DateStatus.yesterday]!),
                        const SizedBox(
                          height: 16,
                        ),
                        totalIncome(
                            'This Month',
                            totalList.isEmpty
                                ? 0
                                : totalList[DateStatus.oneMonth]!),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
