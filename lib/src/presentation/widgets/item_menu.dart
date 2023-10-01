import 'package:cashier_app/src/presentation/features/cashier/bloc/menuOrder/menu_order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/shared/theme.dart';
import '../../core/utils/string_helper.dart';

class ItemMenu extends StatefulWidget {
  final String id;
  final String name;
  final int price;
  final int hpp;
  final int totalOrder;
  final String typeMenu;
  final bool isDisabled;

  const ItemMenu({
    Key? key,
    required this.id,
    required this.name,
    required this.price,
    required this.hpp,
    required this.totalOrder,
    required this.typeMenu,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  State<ItemMenu> createState() => _ItemMenuState();
}

class _ItemMenuState extends State<ItemMenu> {
  late int _totalBuy;
  late String codeName;

  @override
  void initState() {
    super.initState();

    _totalBuy = widget.totalOrder;

    // jika nama menu lebih dari satu kata
    // maka lakukan split nama menu
    if (widget.name.split(' ').length > 1) {
      final split = widget.name.split(' ');
      codeName = split.map((str) => str[0]).join();
    } else {
      codeName = widget.name[0];
    }

    /// jika [_totalBuy] lebih dari 0 masukan data ke orderMenu
    // if (_totalBuy > 0) {
    //   context.read<MenuOrderBloc>().add(
    //         AddOrder(
    //           menu: Menu(
    //             id: widget.id,
    //             price: widget.price,
    //             menuName: widget.name,
    //             totalBuy: _totalBuy,
    //             hpp: widget.hpp,
    //             typeMenu: widget.typeMenu,
    //           ),
    //         ),
    //       );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: lightGray2Color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    codeName.toUpperCase(),
                    style: blackTextStyle.copyWith(fontWeight: semiBold),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp. ${StringHelper.addComma(widget.price)}',
                    style: secondaryTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: lightGray2Color,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (!widget.isDisabled) {
                      if (_totalBuy > 0) {
                        setState(() {
                          _totalBuy--;
                        });
                        context
                            .read<MenuOrderBloc>()
                            .add(OrderDecrementPressed(id: widget.id));
                      }
                    }
                  },
                  child: Image.asset(
                    'assets/images/ic_minus.png',
                    width: 22,
                  ),
                ),
                SizedBox(
                  width: 24,
                  child: Text(
                    _totalBuy.toString(),
                    style: widget.isDisabled
                        ? gray2TextStyle.copyWith(
                            fontWeight: medium,
                            fontSize: 12,
                          )
                        : primaryTextStyle.copyWith(
                            fontWeight: medium,
                            fontSize: 12,
                          ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (!widget.isDisabled) {
                      setState(() {
                        _totalBuy++;
                      });
                      context
                          .read<MenuOrderBloc>()
                          .add(OrderIncrementPressed(id: widget.id));
                    }
                  },
                  child: Image.asset(
                    'assets/images/ic_plus.png',
                    width: 22,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
