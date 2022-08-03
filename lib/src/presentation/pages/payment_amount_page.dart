import '../../config/route/routes.dart';

import '../../config/route/go.dart';
import '../../core/utils/string_helper.dart';
import '../cubit/menu_order/menu_order_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/shared/theme.dart';
import '../widgets/custom_radio_payment_amount.dart';
import 'package:flutter/material.dart';

import '../widgets/payment_app_bar.dart';

class PaymentAmountPage extends StatefulWidget {
  const PaymentAmountPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentAmountPage> createState() => _PaymentAmountPageState();
}

class _PaymentAmountPageState extends State<PaymentAmountPage> {
  /// controller text field
  late TextEditingController _payAmountController = TextEditingController();

  /// variabel untuk kembalian
  late int _change = 0;

  /// variabel untuk radio button
  late int _groupvalue = 0;

  @override
  void initState() {
    super.initState();

    // initVariable();
  }

  @override
  void dispose() {
    _payAmountController.dispose();
    super.dispose();
  }

  /// fungsi untuk initial variabel
  // void initVariable() {
  //   _groupvalue = widget.total;
  //   _payAmountController = TextEditingController(text: _groupvalue.toString());
  //   _change = 0;
  // }

  void onTapPay() {
    context.read<MenuOrderCubit>().orderAddCashAndChangePayment(
        cash: int.parse(_payAmountController.text), change: _change);
    Go.routeWithPath(context: context, path: Routes.receipt);
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildListRadioPayment(int totalPayment) {
      /// variabel berisi list banyaknya jumlah yang akan diberikan pelanggan
      final List<int> _mostListPaymentAmount = [
        totalPayment,
        20000,
        30000,
        50000
      ];

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
          children: _mostListPaymentAmount.map((value) {
            // CustomRadioController controller = CustomRadioController(
            //   isSelected: value['isSelected'],
            //   payment: value['payment'],
            // );

            return CustomRadioPaymentAmount(
              value: value,
              groupValue: _groupvalue,
              onChanged: (value) {
                setState(() {
                  _groupvalue = value;
                  _payAmountController =
                      TextEditingController(text: _groupvalue.toString());
                  _change = _groupvalue - totalPayment;
                });
              },
            );
          }).toList(),
        ),
      );
    }

    Widget _buildFieldPayAndChange(int totalPrice) {
      Widget title() => Text(
            'Enter The Pay Amount',
            style: grayTextStyle.copyWith(
              fontWeight: regular,
              fontSize: 14,
            ),
          );

      Widget textField() => TextField(
            controller: _payAmountController,
            keyboardType: TextInputType.number,
            style: blackTextStyle.copyWith(
              fontWeight: regular,
              fontSize: 14,
            ),
            onChanged: (value) {
              /// jika value dari onChanged string kosong,
              /// set [_payAmountController] jadi 0
              if (value == '') {
                setState(() {
                  // set _payAmountController jadi 0
                  _payAmountController = TextEditingController(text: '0');

                  // set cursor textfield jadi paling ujung
                  _payAmountController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _payAmountController.text.length),
                  );

                  _change = int.parse(_payAmountController.text) - totalPrice;
                });
              } else {
                setState(() {
                  _groupvalue = int.parse(value);
                  _change = int.parse(value) - totalPrice;
                });
              }

              /// jika karakter value onChanged lebih dari 1, lalu jika
              /// karakter value pertama sama dengan 0 maka set nilai
              /// _payAmountController menjadi karakter kedua dari value
              /// e.g: _payAmountController.text = 01 diubah menjadi
              /// _payAmountController.text = 1
              if (value.length > 1) {
                if (value[0] == '0') {
                  setState(() {
                    _payAmountController =
                        TextEditingController(text: value.substring(1));

                    // set cursor textfield jadi paling ujung
                    _payAmountController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _payAmountController.text.length),
                    );
                  });
                }
              }
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

      Widget changes() => Row(
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
                StringHelper.addComma(_change),
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
            changes(),
          ],
        ),
      );
    }

    Widget _buttonPay() {
      return Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.only(
          top: defaultMargin,
          bottom: 24,
          left: defaultMargin,
          right: defaultMargin,
        ),
        decoration: BoxDecoration(
          color: blueColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton(
          onPressed: onTapPay,
          child: Text(
            'Pay',
            style: whiteTextStyle.copyWith(
              fontWeight: medium,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    Widget _buildBody() {
      return SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: BlocBuilder<MenuOrderCubit, MenuOrderState>(
                builder: (context, state) {
                  if (state is MenuOrderSuccess) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                        defaultMargin,
                        45,
                        defaultMargin,
                        0,
                      ),
                      child: Column(
                        children: [
                          PaymentAppBar(
                            title: state.menuOrder.typePayment!,
                            orderId: state.menuOrder.id!,
                            total: state.menuOrder.total,
                          ),
                          const SizedBox(height: 30),
                          Divider(
                              thickness: 2, height: 0, color: lightGrayColor),
                          _buildListRadioPayment(state.menuOrder.total),
                          Divider(
                              thickness: 2, height: 0, color: lightGrayColor),
                          _buildFieldPayAndChange(state.menuOrder.total),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buttonPay(),
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
