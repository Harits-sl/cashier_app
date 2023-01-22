import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/shared/theme.dart';
import '../../core/utils/string_helper.dart';
import '../../data/models/menu_model.dart';
import '../cubit/menu_order/menu_order_cubit.dart';
import 'button_circle.dart';

class Menu extends StatefulWidget {
  final MenuModel menu;
  final int totalOrder;

  const Menu({
    required this.menu,
    required this.totalOrder,
    Key? key,
  }) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late int _totalBuy;

  @override
  void initState() {
    super.initState();

    _totalBuy = widget.totalOrder;
  }

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
                          hpp: widget.menu.hpp,
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
                        hpp: widget.menu.hpp,
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
