import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:cashier_app/src/config/route/go.dart';
import 'package:cashier_app/src/config/route/routes.dart';
import 'package:cashier_app/src/data/models/menu_order_model.dart';
import 'package:cashier_app/src/presentation/cubit/thermalPrinterCubit/thermal_printer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../core/shared/theme.dart';
import '../../core/utils/string_helper.dart';
import '../cubit/menu_order/menu_order_cubit.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MenuOrderModel _menuOrder = const MenuOrderModel();

    void _tesPrint() async {
      final BlueThermalPrinter printer =
          context.read<ThermalPrinterCubit>().printer!;

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
            DateFormat('M.d.y - H:mm:ss').format(_menuOrder.dateTimeOrder!);

        printer.printNewLine();
        printer.printCustom('Struk', 3, 1);
        printer.printNewLine();
        printer.printCustom(_menuOrder.typePayment!, 1, 0);
        printer.printNewLine();
        printer.printCustom(dateFormat, 1, 0);
        printer.printNewLine();
        printer.printCustom('--------------------------------', 0, 0);
        for (var menu in _menuOrder.listMenus!) {
          printer.printCustom(menu['menuName'], 0, 0);
          printer.printLeftRight(
            '${menu['totalBuy']} x ${StringHelper.addComma(menu['price'])}',
            StringHelper.addComma(menu['totalBuy'] * menu['price']),
            0,
          );
        }
        printer.printCustom('--------------------------------', 0, 0);
        printer.printNewLine();
        printer.printLeftRight(
            'TOTAL', StringHelper.addComma(_menuOrder.total), 0);
        printer.printLeftRight(
            'CASH', StringHelper.addComma(_menuOrder.cash), 0);
        printer.printLeftRight(
            'CHANGE', StringHelper.addComma(_menuOrder.change), 0);
        printer.printNewLine();
        printer.printNewLine();
        printer.paperCut();
      });
    }

    void onTapReceiptPrint() {
      if (context.read<ThermalPrinterCubit>().isConnected) {
        _tesPrint();
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

    void _onTapSaveOrder() {
      context.read<MenuOrderCubit>().addOrderToFirestore(_menuOrder);
      Go.routeWithPathAndRemove(context: context, path: Routes.home);

      context.read<MenuOrderCubit>().initState();
    }

    Widget _buildHeader() {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 45),
          child: Text(
            'STRUK',
            style: blackTextStyle.copyWith(
              fontWeight: medium,
              fontSize: 18,
            ),
          ),
        ),
      );
    }

    Widget _buildReceipt() {
      return BlocBuilder<MenuOrderCubit, MenuOrderState>(
        builder: (context, state) {
          if (state is MenuOrderSuccess) {
            _menuOrder = state.menuOrder;

            String dateFormat = state.menuOrder.dateTimeOrder != null
                ? DateFormat('M.d.y - H:mm:ss')
                    .format(state.menuOrder.dateTimeOrder!)
                : 'hari kosong';

            return Container(
              margin: EdgeInsets.only(
                left: defaultMargin,
                right: defaultMargin,
                bottom: defaultMargin,
                top: 35,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.menuOrder.typePayment!,
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    dateFormat,
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Divider(),
                  Column(
                    children: state.menuOrder.listMenus!
                        .map(
                          (menu) => Container(
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    menu['menuName'],
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    menu['totalBuy'].toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    StringHelper.addComma(menu['price']),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    StringHelper.addComma(
                                        menu['totalBuy'] * menu['price']),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const Divider(),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('TOTAL'),
                      Text(StringHelper.addComma(state.menuOrder.total)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('CASH'),
                      Text(StringHelper.addComma(state.menuOrder.cash)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('CHANGE'),
                      Text(StringHelper.addComma(state.menuOrder.change)),
                    ],
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      );
    }

    Widget _buildButtonPrintStruck() {
      return SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: TextButton(
          onPressed: () {
            onTapReceiptPrint();
          },
          style: TextButton.styleFrom(
            backgroundColor: blueColor,
            primary: whiteColor,
            padding: const EdgeInsets.symmetric(vertical: 24),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          child: const Text('Cetak Struk'),
        ),
      );
    }

    Widget _buildButtonSaveOrder() {
      return SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: TextButton(
          onPressed: _onTapSaveOrder,
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            primary: blackColor,
            padding: const EdgeInsets.symmetric(vertical: 24),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          child: const Text('Simpan Order'),
        ),
      );
    }

    Widget _buildBody() {
      return Stack(
        children: [
          ListView(
            children: [
              _buildHeader(),
              _buildReceipt(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                _buildButtonSaveOrder(),
                _buildButtonPrintStruck(),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: _buildBody(),
    );
  }
}
