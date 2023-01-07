import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/core/utils/field_helper.dart';
import 'package:cashier_app/src/presentation/features/admin_menu_edit/index.dart';
import 'package:cashier_app/src/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FieldEditMenu extends StatefulWidget {
  const FieldEditMenu({Key? key}) : super(key: key);

  @override
  State<FieldEditMenu> createState() => _FieldEditMenuState();
}

class _FieldEditMenuState extends State<FieldEditMenu> {
  var _nameController = TextEditingController(text: '');
  var _priceController = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'Coffee';
    List<String> listTypesMenu = ['Coffee', 'Non-Coffee', 'Food'];
    context.read<AdminMenuEditBloc>().add(FetchMenuById());

    Widget typeMenu() {
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
                    // context
                    //     .read<AddMenuBloc>()
                    //     .add(TypeMenuChanged(typeMenu: dropdownValue));
                  });
                },
                items:
                    listTypesMenu.map<DropdownMenuItem<String>>((String value) {
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

    return BlocConsumer<AdminMenuEditBloc, AdminMenuEditState>(
      listener: (context, state) {
        // if (state.status == Status.success) {
        //   setState(() {
        //     _nameController = TextEditingController(text: '');
        //     _priceController = TextEditingController(text: '0');
        //   });
        // }
      },
      builder: (context, state) {
        if (state.status == Status.success) {
          _nameController = TextEditingController(text: state.name);
          _priceController =
              TextEditingController(text: state.price.toString());
          dropdownValue = state.typeMenu;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                  title: 'Nama Menu',
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {}
                  // context.read<AddMenuBloc>().add(NameChanged(name: value)),
                  ),
              // sizedBox1(),
              CustomTextField(
                title: 'Harga',
                controller: _priceController,
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  FieldHelper.number(
                    controller: _priceController,
                    value: value,
                    setState: (controller) {
                      setState(() {
                        _priceController = controller;
                      });
                    },
                  );

                  if (value != '') {
                    // context
                    //     .read<AddMenuBloc>()
                    //     .add(PriceChanged(price: int.parse(value)));
                  }
                },
              ),
              // sizedBox1(),
              typeMenu(),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
