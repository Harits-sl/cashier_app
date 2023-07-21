import 'package:cashier_app/src/core/utils/field_helper.dart';
import 'package:cashier_app/src/presentation/features/product/index.dart';
import 'package:cashier_app/src/presentation/widgets/custom_dropdown_form_field.dart';
import 'package:cashier_app/src/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFormProductScreen extends StatelessWidget {
  const AddFormProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _priceController = TextEditingController(text: '');
    var _hppController = TextEditingController(text: '');
    List<String> listTypeProducts = ['Coffee', 'Non-Coffee', 'Food'];

    Widget formProductName() {
      return CustomTextFormField(
        title: 'Product Name',
        keyboardType: TextInputType.text,
        hintText: 'Americano',
        textValidator: 'Please enter product name',
        onChanged: (value) =>
            context.read<AddProductBloc>().add(NameChanged(name: value)),
      );
    }

    Widget formPrice() {
      return StatefulBuilder(
        builder: (context, setState) {
          return CustomTextFormField(
            title: 'Price',
            controller: _priceController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            hintText: '0',
            textValidator: 'Please enter price',
            onChanged: (value) {
              int? price = int.tryParse(value);
              FieldHelper.number(
                controller: _priceController,
                value: value,
                setState: (controller) {
                  setState(() {
                    _priceController = controller;
                  });
                },
              );

              if (price != null) {
                context.read<AddProductBloc>().add(PriceChanged(price: price));
              }
            },
          );
        },
      );
    }

    Widget formHpp() {
      return StatefulBuilder(
        builder: (context, setState) {
          return CustomTextFormField(
            title: 'Hpp',
            controller: _hppController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            hintText: '0',
            textValidator: 'Please enter price',
            onChanged: (value) {
              int? hpp = int.tryParse(value);

              FieldHelper.number(
                controller: _hppController,
                value: value,
                setState: (controller) {
                  setState(() {
                    _hppController = controller;
                  });
                },
              );

              if (hpp != null) {
                context.read<AddProductBloc>().add(HppChanged(hpp: hpp));
              }
            },
          );
        },
      );
    }

    Widget selectProductType() {
      return CustomDropdownFormField(
        title: 'Product Type',
        listDropdown: listTypeProducts,
        textValidator: 'Please select Product type',
        onChanged: (value) {
          context
              .read<AddProductBloc>()
              .add(TypeProductChanged(typeProduct: value.toString()));
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        formProductName(),
        const SizedBox(height: 16),
        formPrice(),
        const SizedBox(height: 16),
        formHpp(),
        const SizedBox(height: 16),
        selectProductType(),
      ],
    );
  }
}
