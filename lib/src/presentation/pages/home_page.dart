import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import '../../config/route/go.dart';
import 'select_payment_page.dart';
import '../cubit/homeCubit/home_cubit.dart';
import '../../core/shared/theme.dart';
import '../../presentation/widgets/menu.dart';
import '../../core/utils/string_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  // final BlueThermalPrinter printer;

  const HomePage(
      {
      // required this.printer,
      Key? key})
      : super(key: key);

  _tesPrint(datas) async {
    //SIZE
    // 0- normal size text
    // 1- only bold text
    // 2- bold with medium text
    // 3- bold with large text
    //ALIGN
    // 0- ESC_ALIGN_LEFT
    // 1- ESC_ALIGN_CENTER
    // 2- ESC_ALIGN_RIGHT

    // printer.isConnected.then((isConnected) async {
    //   printer.printNewLine();
    //   for (var data in datas['menus']) {
    //     printer.printCustom('${data['namaMenu']}', 0, 1);
    //     printer.printCustom('${data['price']}', 0, 1);
    //     printer.printNewLine();
    //   }
    //   printer.printCustom('total: ${datas['totalPrice']}', 0, 1);
    //   printer.printNewLine();
    //   printer.printNewLine();
    //   printer.paperCut();

    // return BlocBuilder<HomeCubit, Map<String, dynamic>?>(
    //   builder: (context, data) {
    //     // _print(data);
    //     return const SizedBox();
    //   },
    // );
    // printer.printNewLine();
    // printer.printCustom("HEADER", 3, 1);
    // printer.printNewLine();
    // printer.printNewLine();
    // //printer.printImageBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    // printer.printLeftRight("LEFT", "RIGHT", 0);
    // printer.printLeftRight("LEFT", "RIGHT", 1);
    // printer.printLeftRight("LEFT", "RIGHT", 1, format: "%-15s %15s %n");
    // printer.printNewLine();
    // printer.printLeftRight("LEFT", "RIGHT", 2);
    // printer.printLeftRight("LEFT", "RIGHT", 3);
    // printer.printLeftRight("LEFT", "RIGHT", 4);
    // printer.printNewLine();
    // printer.print3Column("Col1", "Col2", "Col3", 1);
    // printer.print3Column("Col1", "Col2", "Col3", 1,
    //     format: "%-10s %10s %10s %n");
    // printer.printNewLine();
    // printer.print4Column("Col1", "Col2", "Col3", "Col4", 1);
    // printer.print4Column("Col1", "Col2", "Col3", "Col4", 1,
    //     format: "%-8s %7s %7s %7s %n");
    // printer.printNewLine();
    // String testString = " čĆžŽšŠ-H-ščđ";
    // printer.printCustom(testString, 1, 1, charset: "windows-1250");
    // printer.printLeftRight("Številka:", "18000001", 1,
    //     charset: "windows-1250");
    // printer.printCustom("Body left", 1, 0);
    // printer.printCustom("Body right", 0, 2);
    // printer.printNewLine();
    // printer.printCustom("Thank You", 2, 1);
    // printer.printNewLine();
    // printer.printQRcode("Insert Your Own Text to Generate", 200, 200, 1);
    // printer.printNewLine();
    // printer.printNewLine();
    // printer.paperCut();
    // });
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildSearch() {
      return Container(
        margin: EdgeInsets.all(defaultMargin),
        child: TextField(
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.fromLTRB(0, 13, 13, 13),
            hintText: 'Cari menu...',
            hintStyle: grayTextStyle.copyWith(fontWeight: light, fontSize: 14),
            prefixIcon: const Padding(
              padding: EdgeInsets.fromLTRB(15, 11, 20, 11),
              child: ImageIcon(
                AssetImage('assets/images/ic_search.png'),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: lightGrayColor, width: 2),
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: blueColor, width: 2),
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
          ),
        ),
      );
    }

    Widget _buildMenu(String title) {
      Widget textTitle() => Text(
            title,
            style: blackTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 18,
            ),
          );

      return Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textTitle(),
            const SizedBox(height: 12),
            Divider(thickness: 1, height: 0, color: lightGrayColor),
            const Menu(id: 1, title: 'Kopi Sembunyi', price: 18000),
            Divider(thickness: 1, height: 0, color: lightGrayColor),
            const Menu(id: 2, title: 'Cappucino', price: 20000),
            Divider(thickness: 1, height: 0, color: lightGrayColor),
            const Menu(id: 3, title: 'Americano', price: 23000),
            Divider(thickness: 1, height: 0, color: lightGrayColor),
          ],
        ),
      );
    }

    Widget _buildTotalAndBtnCheckout() {
      Widget _totalPriceAndItem(data) {
        /// variabel ini untuk banyaknya menu yang dipesan dari map data
        /// mengembalikan nilai berupa int
        /// jika data null return 0
        int _numberOfItems = data != null ? data['menus'].length : 0;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total | Item $_numberOfItems',
              style: blackTextStyle.copyWith(
                fontWeight: regular,
                fontSize: 14,
              ),
            ),
            Text(
              data == null
                  ? 'Rp. 0'
                  : 'Rp. ${StringHelper.addComma(data['totalPrice'])}',
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 14,
              ),
            ),
          ],
        );
      }

      Widget _buttonCheckOut(data) => Container(
            width: double.infinity,
            height: 50,
            margin: EdgeInsets.only(top: defaultMargin, bottom: 24),
            decoration: BoxDecoration(
              color: blueColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                Go.to(context, SelectPaymentPage());
              },
              child: Text(
                'Checkout',
                style: whiteTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 16,
                ),
              ),
            ),
          );

      return BlocBuilder<HomeCubit, Map<String, dynamic>?>(
        builder: (context, data) {
          return Container(
            width: double.infinity,
            height: 140,
            padding: EdgeInsets.only(
                top: 20, left: defaultMargin, right: defaultMargin),
            decoration: BoxDecoration(
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  color: grayColor,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                _totalPriceAndItem(data),
                _buttonCheckOut(data),
              ],
            ),
          );
        },
      );
    }

    Widget _buildBody() {
      return SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                _buildSearch(),
                _buildMenu('Coffe'),
                // spasi dari menu ke widget _totalAndBtnCheckout
                SizedBox(
                  height: defaultMargin + 140,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildTotalAndBtnCheckout(),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: _buildBody(),
    );
  }
}
