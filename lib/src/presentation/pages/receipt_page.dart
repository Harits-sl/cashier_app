import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:cashier_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:cashier_app/src/presentation/widgets/custom_button.dart';
import 'package:cashier_app/src/presentation/widgets/custom_divider.dart';
import '../../config/route/go.dart';
import '../../config/route/routes.dart';
import '../cubit/thermalPrinterCubit/thermal_printer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../core/shared/theme.dart';
import '../../core/utils/string_helper.dart';
import '../cubit/menu_order/menu_order_bloc.dart';

class ReceiptPage extends StatelessWidget {
  static const String routeName = '/receipt';

  const ReceiptPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _receiptPrint(MenuOrderState order) async {
      final BlueThermalPrinter printer =
          context.read<ThermalPrinterCubit>().printer!;
      List menuOrders =
          order.menuOrders!.where((order) => order.totalBuy != 0).toList();

      //SIZE
      // 0- normal size text
      // 1- only bold text
      // 2- bold with medium text
      // 3- bold with large text
      //ALIGN
      // 0- ESC_ALIGN_LEFT
      // 1- ESC_ALIGN_CENTER
      // 2- ESC_ALIGN_RIGHT

      printer.isConnected.then((isConnected) async {
        String dateFormat =
            DateFormat('M.d.y - H:mm:ss').format(order.dateTimeOrder!);

        printer.printNewLine();
        printer.printCustom('Struk', 3, 1);
        printer.printNewLine();
        printer.printCustom(order.typePayment!, 1, 0);
        printer.printNewLine();
        printer.printCustom(dateFormat, 1, 0);
        printer.printNewLine();
        printer.printCustom('--------------------------------', 0, 0);
        for (var menu in menuOrders) {
          printer.printCustom(menu.menuName, 0, 0);
          printer.printLeftRight(
            '${menu.totalBuy} x ${StringHelper.addComma(menu.price)}',
            StringHelper.addComma(menu.totalBuy * menu.price),
            0,
          );
        }
        printer.printCustom('--------------------------------', 0, 0);
        printer.printNewLine();
        printer.printLeftRight('TOTAL', StringHelper.addComma(order.total!), 0);
        printer.printLeftRight('CASH', StringHelper.addComma(order.cash!), 0);
        printer.printLeftRight(
            'CHANGE', StringHelper.addComma(order.change!), 0);
        printer.printNewLine();
        printer.printNewLine();
        printer.paperCut();
      });
    }

    void onTapReceiptPrint(MenuOrderState order) {
      if (context.read<ThermalPrinterCubit>().isConnected) {
        _receiptPrint(order);
      } else {
        Go.routeWithPath(context: context, path: Routes.selectPrinter);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: ((context) => SelectPrinterPage()),
        //   ),
        // );
      }
    }

    void _onTapSaveOrder(MenuOrderState order) {
      context.read<MenuOrderBloc>().add(AddOrderToFirestore());
      context.read<MenuOrderBloc>().add(ResetState());
      Go.routeWithPathAndRemove(context: context, path: Routes.home);
    }

    Widget _buildReceiptInfo(MenuOrderState order) {
      List menuOrders =
          order.menuOrders!.where((order) => order.totalBuy != 0).toList();
      String dateFormat = order.dateTimeOrder != null
          ? DateFormat('M.d.yy-H:mm').format(order.dateTimeOrder!)
          : 'hari kosong';

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 80,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 240,
              child: Text(
                'Jl. Warakas Gg. 8 No.98, RW.3, Warakas, Kec. Tj. Priok, Jkt Utara, Daerah Khusus Ibukota Jakarta 14370',
                style: primaryTextStyle.copyWith(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: CustomDivider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID',
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
                Text(
                  order.id!,
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date Order',
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
                Text(
                  dateFormat,
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment Method',
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
                Text(
                  order.typePayment!,
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: CustomDivider(),
            ),
            Column(
              children: menuOrders
                  .map(
                    (order) => Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              order.menuName,
                              style: primaryTextStyle.copyWith(
                                fontWeight: medium,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              order.totalBuy.toString(),
                              style: primaryTextStyle.copyWith(
                                fontWeight: medium,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              StringHelper.addComma(order.price),
                              style: primaryTextStyle.copyWith(
                                fontWeight: medium,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              StringHelper.addComma(
                                  order.totalBuy * order.price),
                              style: primaryTextStyle.copyWith(
                                fontWeight: medium,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            const CustomDivider(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Price'),
                Text(
                  StringHelper.addComma(order.total!),
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Cash'),
                Text(
                  StringHelper.addComma(order.cash!),
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Change'),
                Text(
                  StringHelper.addComma(order.change!),
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildButtonSaveOrder(MenuOrderState order) {
      return Expanded(
        child: CustomButton(
          color: backgroundColor,
          onPressed: () => _onTapSaveOrder(order),
          text: 'Save Order',
          textStyle: primaryTextStyle.copyWith(fontSize: 12),
          margin: const EdgeInsets.only(
            right: 12,
            left: defaultMargin,
          ),
          border: Border.all(width: 1, color: primaryColor),
        ),
      );
    }

    Widget _buildButtonPrintStruck(MenuOrderState order) {
      return Expanded(
        child: CustomButton(
          color: primaryColor,
          onPressed: () => onTapReceiptPrint(order),
          text: 'Print Receipt',
          margin: const EdgeInsets.only(right: defaultMargin, left: 12),
        ),
      );
    }

    Widget _buildBody() {
      return BlocBuilder<MenuOrderBloc, MenuOrderState>(
        builder: (context, state) {
          return Stack(
            children: [
              ListView(
                children: [
                  const CustomAppBar(
                    title: 'Receipt',
                    isCanBack: false,
                  ),
                  _buildReceiptInfo(state),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: defaultMargin),
                  child: Row(
                    children: [
                      _buildButtonSaveOrder(state),
                      _buildButtonPrintStruck(state),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: _buildBody(),
    );
  }
}
