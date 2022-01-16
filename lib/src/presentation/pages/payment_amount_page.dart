import 'package:cashier_app/src/core/utils/string_helper.dart';

import '../../core/shared/theme.dart';
import '../widgets/custom_radio_payment.dart';
import 'package:flutter/material.dart';

import '../widgets/payment_app_bar.dart';

class PaymentAmountPage extends StatefulWidget {
  const PaymentAmountPage({
    Key? key,
    required this.title,
    required this.orderId,
    required this.total,
  }) : super(key: key);

  /// variabel yang akan diisi untuk payment app bar,
  /// didapat dari select payment page
  final String title;

  /// variabel yang akan diisi untuk payment app bar
  final String orderId;

  /// variabel yang akan diisi untuk payment app bar
  final int total;

  @override
  State<PaymentAmountPage> createState() => _PaymentAmountPageState();
}

class _PaymentAmountPageState extends State<PaymentAmountPage> {
  late TextEditingController payAmountController;

  @override
  void initState() {
    // isChecked = false;
    // setState(() {
    // valueController = TextEditingController(text: '0');

    // });
    payAmountController = TextEditingController(text: '0');

    super.initState();
  }

  @override
  void dispose() {
    payAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// variabel berisi list banyaknya jumlah yang akan diberikan pelanggan
    final List _mostListPaymentAmount = [18000, 20000, 30000, 50000];

    Widget _buildListRadioPayment() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: GridView.count(
          // menentukan child aspect ratio lihat dari sini
          // https://calculateaspectratio.com/
          childAspectRatio: 16 / 7,
          crossAxisCount: 2,
          crossAxisSpacing: 58,
          mainAxisSpacing: 15,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: _mostListPaymentAmount
              .map((value) => CustomRadioPayment(value: value))
              .toList(),
        ),
      );
    }

    Widget _buildFieldPayAndChange() {
      Widget title() => Text(
            'Enter The Pay Amount',
            style: grayTextStyle.copyWith(
              fontWeight: regular,
              fontSize: 14,
            ),
          );

      Widget textField() => TextField(
            controller: payAmountController,
            keyboardType: TextInputType.number,
            style: blackTextStyle.copyWith(
              fontWeight: regular,
              fontSize: 14,
            ),
            onChanged: (_) {
              setState(() => payAmountController);
            },
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(0, 21, 21, 21),
              hintStyle:
                  grayTextStyle.copyWith(fontWeight: light, fontSize: 14),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 15, right: 10),
                child: Text('Rp.'),
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
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
          );

      Widget change() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Change',
                style: grayTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 12,
                ),
              ),
              Text(
                '${StringHelper.addComma(int.parse(payAmountController.text))}',
                style: blackTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 16,
                ),
              ),
            ],
          );

      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            title(),
            const SizedBox(height: 12),
            textField(),
            const SizedBox(height: 12),
            change(),
          ],
        ),
      );
    }

    Widget _buildBody() {
      return SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              defaultMargin,
              45,
              defaultMargin,
              0,
            ),
            child: Column(
              children: [
                PaymentAppBar(
                  title: widget.title,
                  orderId: widget.orderId,
                  total: widget.total,
                ),
                const SizedBox(height: 30),
                Divider(thickness: 2, height: 0, color: lightGrayColor),
                _buildListRadioPayment(),
                Divider(thickness: 2, height: 0, color: lightGrayColor),
                _buildFieldPayAndChange(),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: _buildBody(),
    );
  }
}
