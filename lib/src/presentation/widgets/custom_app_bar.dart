import 'package:flutter/material.dart';

import 'package:cashier_app/src/config/route/go.dart';
import 'package:cashier_app/src/core/shared/theme.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.action,
    this.isCanBack = true,
  }) : super(key: key);

  final String title;
  final Widget? action;
  final bool isCanBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isCanBack
              ? GestureDetector(
                  onTap: () => Go.back(context),
                  child: Image.asset(
                    'assets/images/ic_back.png',
                    width: 30,
                  ),
                )
              : const SizedBox(width: 30),
          Text(
            title,
            style: primaryTextStyle.copyWith(
              fontWeight: semiBold,
            ),
          ),
          action ?? const SizedBox(width: 30),
        ],
      ),
    );
  }
}
