import '../../core/shared/theme.dart';
import 'button_circle.dart';
import 'package:flutter/services.dart';

import '../../presentation/cubit/homeCubit/home_cubit.dart';
import '../../core/utils/string_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Menu extends StatefulWidget {
  final int id;
  final int price;
  final String title;

  const Menu({
    required this.id,
    required this.title,
    required this.price,
    Key? key,
  }) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  // late bool isChecked;

  late List<int> price;
  late TextEditingController valueController;

  @override
  void initState() {
    // isChecked = false;
    price = [];
    // setState(() {
    // valueController = TextEditingController(text: '0');

    // });
    valueController = TextEditingController(text: '0');

    super.initState();
  }

  @override
  void dispose() {
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: blackTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Rp. ${StringHelper.addComma(widget.price)}',
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
              ),
              SizedBox(
                width: 25,
                child: TextField(
                  controller: valueController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: blackTextStyle.copyWith(
                    fontWeight: regular,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: blueColor),
                    ),
                  ),
                  onChanged: (_) {
                    // setState(() {
                    // isChecked = value!;
                    // price.add(widget.price);
                    // });
                    context.read<HomeCubit>().price(
                          id: widget.id,
                          menuName: widget.title,
                          price: widget.price,
                          qty: int.parse(valueController.text),
                        );
                  },
                ),
              ),
              ButtonCircle(
                title: '+',
                color: blueColor,
                textStyle: darkBlueTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          // Checkbox(
          //   checkColor: Colors.white,
          //   fillColor: MaterialStateProperty.resolveWith(getColor),
          //   value: isChecked,
          //   onChanged: (bool? value) {
          //     setState(() {
          //       isChecked = value!;
          //       // price.add(widget.price);
          //     });
          //     context.read<HomeCubit>().price(
          //         id: widget.id,
          //         namaMenu: widget.title,
          //         price: widget.price,
          //         isAdd: isChecked);
          //   },
          // ),
          // title: Text(widget.title),
          // subtitle: Text('Rp. ${StringHelper.addComma(widget.price)}'),
          // dense: true,
          // contentPadding: const EdgeInsets.all(0),
          // minVerticalPadding: 0,
          // minLeadingWidth: 0,
          // trailing: GestureDetector(
          //   onTap: () {
          //     if (!data!['isSelected']) {
          //       setState(() {
          //         selected = true;
          //       });
          //     } else {
          //       setState(() {
          //         selected = false;
          //       });
          //     }
          //     context.read<HomeCubit>().select(widget.id, selected);
          //   },
          //   child: Container(
          //     width: 38,
          //     height: 38,
          //     color: const Color(0xffC4C4C4),
          //     child: data!['isSelected'] && data['id'] == widget.id
          //         ? const Icon(Icons.check_outlined)
          //         : Container(),
          //   ),
          // ),
          // trailing: Checkbox(
          //   checkColor: Colors.white,
          //   fillColor: MaterialStateProperty.resolveWith(getColor),
          //   value: isChecked,
          //   onChanged: (bool? value) {
          //     setState(() {
          //       isChecked = value!;
          //       // price.add(widget.price);
          //     });
          //     context.read<HomeCubit>().price(
          //         id: widget.id,
          //         namaMenu: widget.title,
          //         price: widget.price,
          //         isAdd: isChecked);
          //   },
          // ),
        ],
      ),
    );
  }
}
