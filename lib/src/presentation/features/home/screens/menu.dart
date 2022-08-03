import '../../../../config/route/go.dart';
import '../../../../config/route/routes.dart';
import '../../../../core/shared/theme.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;

    void onTapOrder() {
      Go.routeWithPath(context: context, path: Routes.orderMenu);
    }

    Widget item(String title, IconData icon) {
      return InkWell(
        onTap: onTapOrder,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: width - (defaultMargin * 2),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: lightGrayColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 40,
                color: blueColor,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(title),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          item('Cashier', Icons.receipt_long_outlined),
          item('Admin', Icons.admin_panel_settings_outlined),
        ],
      ),
    );
  }
}