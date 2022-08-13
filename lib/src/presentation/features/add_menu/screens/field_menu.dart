import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../index.dart';

class FieldMenu extends StatelessWidget {
  const FieldMenu({Key? key}) : super(key: key);

  // final _nameController = TextEditingController();
  // final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'Coffee';
    context.read<AddMenuBloc>().add(TypeMenuChanged(typeMenu: dropdownValue));

    Widget sizedBox1() {
      return const SizedBox(
        height: 12,
      );
    }

    Widget dropdown() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tipe Menu',
            style: blackTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 6),
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                defaultBorderRadius,
              ),
              border: Border.all(
                color: grayColor,
              ),
            ),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return DropdownButton<String>(
                value: dropdownValue,
                isDense: true,
                elevation: 8,
                iconSize: 0,
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                ),
                underline: Container(
                  height: 0,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    context
                        .read<AddMenuBloc>()
                        .add(TypeMenuChanged(typeMenu: dropdownValue));
                  });
                },
                items: <String>['Coffee', 'Non-Coffee', 'Food']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              );
            }),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          title: 'Nama Menu',
          // controller: _nameController,
          keyboardType: TextInputType.text,
          onChanged: (value) =>
              context.read<AddMenuBloc>().add(NameChanged(name: value)),
        ),
        sizedBox1(),
        CustomTextField(
          title: 'Harga',
          // controller: _priceController,
          keyboardType: TextInputType.phone,
          onChanged: (value) => context
              .read<AddMenuBloc>()
              .add(PriceChanged(price: int.parse(value))),
        ),
        sizedBox1(),
        dropdown(),
      ],
    );
  }
}
