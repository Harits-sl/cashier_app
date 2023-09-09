import 'package:cashier_app/src/core/utils/field_helper.dart';
import 'package:cashier_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:cashier_app/src/presentation/widgets/custom_button.dart';
import 'package:cashier_app/src/presentation/widgets/custom_divider.dart';

import '../../config/route/routes.dart';

import '../../config/route/go.dart';
import '../../core/utils/string_helper.dart';
import '../cubit/menu_order/menu_order_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/shared/theme.dart';
import '../widgets/custom_radio_payment_amount.dart';
import 'package:flutter/material.dart';

import '../widgets/order_information.dart';

class PaymentAmountPage extends StatefulWidget {
  static const String routeName = '/payment-amount';

  const PaymentAmountPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentAmountPage> createState() => _PaymentAmountPageState();
}

class _PaymentAmountPageState extends State<PaymentAmountPage> {
  /// controller text field
  TextEditingController _payAmountController = TextEditingController(text: '0');

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
    context.read<MenuOrderBloc>().add(AddCashAndChangePayment(
          cash: int.parse(StringHelper.removeComma(_payAmountController.text)),
          change: _change,
        ));
    Go.routeWithPath(context: context, path: Routes.receipt);
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildListRadioPayment(int totalPayment) {
      /// variabel berisi list banyaknya jumlah yang akan diberikan pelanggan
      final List<int> _mostListPaymentAmount = [
        totalPayment,
        20000,
        50000,
        100000,
      ];

      return Padding(
        padding: const EdgeInsets.all(defaultMargin),
        child: GridView.count(
          // menentukan child aspect ratio lihat dari sini
          // https://calculateaspectratio.com/
          childAspectRatio: 16 / 7,
          crossAxisCount: 2,
          crossAxisSpacing: 24,
          mainAxisSpacing: 16,
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
                  _payAmountController = TextEditingController(
                      text: StringHelper.addComma(_groupvalue));
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
            style: gray2TextStyle.copyWith(
              fontWeight: light,
              fontSize: 11,
            ),
          );

      Widget textField() => TextField(
            controller: _payAmountController,
            keyboardType: TextInputType.number,
            style: primaryTextStyle.copyWith(fontSize: 14),
            onChanged: (valueOnChanged) {
              String value = StringHelper.removeComma(valueOnChanged);
              FieldHelper.number(
                controller: _payAmountController,
                value: value,
                setState: (controller) {
                  setState(() {
                    _payAmountController = controller;
                  });
                },
              );

              if (value == '') {
                setState(() {
                  _change = int.parse(_payAmountController.text) - totalPrice;
                });
              } else {
                setState(() {
                  _groupvalue = int.parse(value);
                  _change = int.parse(value) - totalPrice;
                });
              }
            },
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
                child: Text(
                  'Rp.',
                  style: primaryTextStyle,
                ),
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
            ),
          );

      Widget changes() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Change',
                style: gray2TextStyle.copyWith(
                  fontWeight: light,
                  fontSize: 12,
                ),
              ),
              Text(
                StringHelper.addComma(_change),
                style: primaryTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
            ],
          );

      return Padding(
        padding: const EdgeInsets.all(defaultMargin),
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
      return CustomButton(
        color: primaryColor,
        borderRadius: BorderRadius.circular(28),
        onPressed: onTapPay,
        text: 'Pay Now',
      );
    }

    Widget _buildBody() {
      return SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: BlocBuilder<MenuOrderBloc, MenuOrderState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      const CustomAppBar(title: 'Payment Amount'),
                      OrderInformation(
                        orderId: state.id!,
                        total: state.total!,
                        paymentMethod: state.typePayment,
                      ),
                      const SizedBox(height: 12),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultMargin),
                        child: CustomDivider(),
                      ),
                      _buildListRadioPayment(state.total!),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultMargin),
                        child: CustomDivider(),
                      ),
                      _buildFieldPayAndChange(state.total!),
                    ],
                  );
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
