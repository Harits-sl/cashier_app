import 'dart:async';

import 'package:cashier_app/src/config/route/go.dart';
import 'package:cashier_app/src/config/route/routes.dart';
import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/presentation/features/stock/index.dart';
import 'package:cashier_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:cashier_app/src/presentation/widgets/custom_button.dart';
import 'package:cashier_app/src/presentation/widgets/custom_dropdown_form_field.dart';
import 'package:cashier_app/src/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddStockScreen extends StatelessWidget {
  const AddStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddStockBloc addStockBloc = context.read<AddStockBloc>();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final List<String> listUnits = ['g', 'pcs'];

    Widget nameInput() {
      return CustomTextFormField(
        title: 'Stock Name',
        hintText: 'susu',
        textValidator: 'Please enter stock name',
        onChanged: (value) {
          addStockBloc.add(InputStockName(stockName: value));
        },
      );
    }

    Widget quantityInput() {
      return CustomTextFormField(
        title: 'Quantity',
        hintText: '100',
        textValidator: 'Please enter quantity',
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          int? quantity = int.tryParse(value);
          // jika quantity bisa diparse
          // atau diubah menjadi angka
          // masukan data ke state
          if (quantity != null) {
            addStockBloc.add(InputQuantity(quantity: quantity));
          }
        },
      );
    }

    Widget minimumQuantity() {
      return CustomTextFormField(
        title: 'Minimum Quantity',
        hintText: '50',
        textValidator: 'Please enter minimum quantity',
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          int? minimumQuantity = int.tryParse(value);
          // jika minimumQuantity bisa diparse
          // atau diubah menjadi angka
          // masukan data ke state
          if (minimumQuantity != null) {
            context
                .read<AddStockBloc>()
                .add(InputMinimumQuantity(minimumQuantity: minimumQuantity));
          }
        },
      );
    }

    Widget selectUnits() {
      return CustomDropdownFormField(
        title: 'Units',
        listDropdown: listUnits,
        textValidator: 'Please select unit for quantity',
        onChanged: (value) {
          if (value != null) {
            addStockBloc.add(InputUnit(unit: value.toString()));
          }
        },
      );
    }

    Widget buttonSubmit() {
      return CustomButton(
        color: primaryColor,
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server or save the information in a database.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );

            addStockBloc.add(SubmitAddNewStock());
          }
        },
        text: 'Submit',
      );
    }

    return SafeArea(
      child: BlocListener<AddStockBloc, AddStockState>(
        listener: (context, state) {
          // jika data berhasil ditambahkan
          if (state.isError != null && !state.isError!) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            addStockBloc.add(InitialStock());
            Timer(const Duration(seconds: 3), () {
              // balik ke halaman stock
              // lalu redirect ke halaman stock agar seperti setstate
              Go.back(context);
              Go.routeWithPathAndRemove(context: context, path: Routes.stock);
            });
            // jika data gagal ditambahkan
          } else if (state.isError != null && state.isError!) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: WillPopScope(
          onWillPop: () async {
            addStockBloc.add(InitialStock());
            return true;
          },
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                CustomAppBar(
                  title: 'Add New Stock',
                  onTap: () {
                    addStockBloc.add(InitialStock());
                    Go.back(context);
                  },
                ),
                nameInput(),
                const SizedBox(height: 16),
                quantityInput(),
                const SizedBox(height: 16),
                minimumQuantity(),
                const SizedBox(height: 16),
                selectUnits(),
                buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
