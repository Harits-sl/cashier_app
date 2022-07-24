import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/shared/theme.dart';
import '../../core/utils/string_helper.dart';
import '../../data/models/menu_model.dart';
import '../cubit/menu_order/menu_order_cubit.dart';
import 'button_circle.dart';

class MenuItem extends StatefulWidget {
  final MenuModel menu;

  const MenuItem({
    required this.menu,
    Key? key,
  }) : super(key: key);

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  int _totalBuy = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.menu.name,
                style: blackTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Rp. ${StringHelper.addComma(widget.menu.price)}',
                style: blackTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Row(
            children: [
              ButtonCircle(
                title: '-',
                color: redColor,
                textStyle: darkRedTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 14,
                ),
                onTap: () {
                  if (_totalBuy > 0) {
                    setState(() {
                      _totalBuy--;
                    });
                    context.read<MenuOrderCubit>().orderMenu(
                          id: widget.menu.id,
                          menuName: widget.menu.name,
                          price: widget.menu.price,
                          totalBuy: _totalBuy,
                        );
                  }
                },
              ),
              SizedBox(
                width: 25,
                child: Text(
                  _totalBuy.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
              ButtonCircle(
                title: '+',
                color: blueColor,
                textStyle: darkBlueTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 14,
                ),
                onTap: () {
                  setState(() {
                    _totalBuy++;
                  });
                  context.read<MenuOrderCubit>().orderMenu(
                        id: widget.menu.id,
                        menuName: widget.menu.name,
                        price: widget.menu.price,
                        totalBuy: _totalBuy,
                      );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
