import '../../../../core/shared/theme.dart';
import '../../../../core/utils/string_helper.dart';
import '../index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Income extends StatelessWidget {
  const Income({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().getAllOrder();

    Widget totalIncome(String title, int total) {
      return Column(
        children: [
          Text(
            title,
            style: whiteTextStyle.copyWith(
              fontWeight: light,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            StringHelper.addComma(total),
            style: whiteTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
        ],
      );
    }

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        List<int> totalList = [];
        if (state is HomeSuccess) {
          totalList = state.totalList;
        }
        return Container(
          margin: EdgeInsets.all(defaultMargin),
          padding: EdgeInsets.symmetric(vertical: defaultMargin),
          decoration: BoxDecoration(
            color: blueColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Center(
                  child: Text(
                    'Income',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  totalIncome('Today', totalList.isEmpty ? 0 : totalList[0]),
                  totalIncome(
                      'Yesterday', totalList.isEmpty ? 0 : totalList[1]),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
