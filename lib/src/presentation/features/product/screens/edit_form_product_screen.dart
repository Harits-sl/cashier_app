import 'package:cashier_app/src/core/utils/field_helper.dart';
import 'package:cashier_app/src/core/utils/string_helper.dart';
import 'package:cashier_app/src/presentation/features/product/index.dart';
import 'package:cashier_app/src/presentation/widgets/custom_dropdown_form_field.dart';
import 'package:cashier_app/src/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditFormProductScreen extends StatelessWidget {
  const EditFormProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _nameController = TextEditingController(text: '');
    var _priceController = TextEditingController(text: '');
    var _hppController = TextEditingController(text: '');
    String? valueProductType;
    List<String> listTypeProducts = ['Coffee', 'Non-Coffee', 'Food'];

    Widget formProductName() {
      return CustomTextFormField(
        title: 'Product Name',
        controller: _nameController,
        keyboardType: TextInputType.text,
        hintText: 'Americano',
        textValidator: 'Please enter product name',
        onChanged: (value) {
          context.read<EditProductBloc>().add(EditNameChanged(name: value));
        },
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
                context
                    .read<EditProductBloc>()
                    .add(EditPriceChanged(price: price));
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
                context.read<EditProductBloc>().add(EditHppChanged(hpp: hpp));
              }
            },
          );
        },
      );
    }

    Widget selectProductType() {
      return CustomDropdownFormField(
        title: 'Product Type',
        value: valueProductType,
        listDropdown: listTypeProducts,
        textValidator: 'Please select Product type',
        onChanged: (value) {
          context
              .read<EditProductBloc>()
              .add(EditTypeProductChanged(typeProduct: value.toString()));
        },
      );
    }

    return BlocConsumer<EditProductBloc, EditProductState>(
      listener: (context, state) {
        if (state.status == EditStatus.successFetch) {
          _nameController = TextEditingController(text: state.name);
          _priceController =
              TextEditingController(text: StringHelper.addComma(state.price!));
          _hppController =
              TextEditingController(text: StringHelper.addComma(state.hpp!));
          valueProductType = state.typeMenu!;
        }
      },
      builder: (context, state) {
        if (state.status == EditStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
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
      },
    );
  }
}
