import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/shared/theme.dart';
import '../../core/utils/string_helper.dart';
import '../cubit/menu_order/menu_order_cubit.dart';

class ItemMenu extends StatefulWidget {
  // final MenuModel menu;
  final String id;
  final String name;
  final int price;
  final int hpp;
  final int totalOrder;

  const ItemMenu({
    // required this.menu,
    Key? key,
    required this.id,
    required this.name,
    required this.price,
    required this.hpp,
    required this.totalOrder,
  }) : super(key: key);

  @override
  State<ItemMenu> createState() => _ItemMenuState();
}

class _ItemMenuState extends State<ItemMenu> {
  late int _totalBuy;

  @override
  void initState() {
    super.initState();

    _totalBuy = widget.totalOrder;

    /// jika [_totalBuy] lebih dari 0 masukan data ke orderMenu
    if (_totalBuy > 0) {
      context.read<MenuOrderCubit>().orderMenu(
            id: widget.id,
            menuName: widget.name,
            price: widget.price,
            hpp: widget.hpp,
            totalBuy: _totalBuy,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
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
                    if (_totalBuy > 0) {
                      setState(() {
                        _totalBuy--;
                      });
                      context.read<MenuOrderCubit>().orderMenu(
                            id: widget.id,
                            menuName: widget.name,
                            price: widget.price,
                            hpp: widget.hpp,
                            totalBuy: _totalBuy,
                          );
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
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _totalBuy++;
                    });
                    context.read<MenuOrderCubit>().orderMenu(
                          id: widget.id,
                          menuName: widget.name,
                          price: widget.price,
                          hpp: widget.hpp,
                          totalBuy: _totalBuy,
                        );
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
