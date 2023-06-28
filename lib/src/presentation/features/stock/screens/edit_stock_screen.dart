import 'package:cashier_app/src/config/route/go.dart';
import 'package:cashier_app/src/config/route/routes.dart';
import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/presentation/features/stock/index.dart';
import 'package:cashier_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:cashier_app/src/presentation/widgets/custom_button.dart';
import 'package:cashier_app/src/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditStockScreen extends StatefulWidget {
  const EditStockScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<EditStockScreen> createState() => _EditStockScreenState();
}

class _EditStockScreenState extends State<EditStockScreen> {
  String initialName = '';
  String initialQuantity = '';
  String initialMinimumQuantity = '';
  String valueUnit = '';
  late EditStockBloc editStockBloc;

  @override
  void initState() {
    super.initState();

    editStockBloc = context.read<EditStockBloc>();
    editStockBloc.add(FetchStockById(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final EditStockBloc editStockBloc = context.read<EditStockBloc>();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final List<String> listUnits = ['g', 'pcs'];

    Widget nameInput() {
      return CustomTextFormField(
        title: 'Stock Name',
        hintText: 'susu',
        textValidator: 'Please enter stock name',
        initialValue: initialName,
        onChanged: (value) {
          editStockBloc.add(EditStockName(stockName: value));
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
        initialValue: initialQuantity,
        onChanged: (value) {
          int? quantity = int.tryParse(value);
          // jika quantity bisa diparse
          // atau diubah menjadi angka
          // masukan data ke state
          if (quantity != null) {
            editStockBloc.add(EditQuantity(quantity: quantity));
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
        initialValue: initialMinimumQuantity,
        onChanged: (value) {
          int? minimumQuantity = int.tryParse(value);
          // jika minimumQuantity bisa diparse
          // atau diubah menjadi angka
          // masukan data ke state
          if (minimumQuantity != null) {
            editStockBloc.add(
              EditMinimumQuantity(minimumQuantity: minimumQuantity),
            );
          }
        },
      );
    }

    Widget selectUnits(String value) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Units',
              style: primaryTextStyle,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField(
              dropdownColor: lightGray2Color,
              borderRadius: BorderRadius.circular(16),
              iconEnabledColor: primaryColor,
              value: value,
              items: listUnits.map((unit) {
                return DropdownMenuItem(
                  child: Text(
                    unit,
                    style: primaryTextStyle,
                  ),
                  value: unit,
                );
              }).toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select unit for quantity';
                }
                return null;
              },
              onChanged: (value) {
                if (value != null) {
                  editStockBloc.add(EditUnit(unit: value));
                }
              },
            ),
          ],
        ),
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

            editStockBloc.add(SubmitEditStock());
          }
        },
        text: 'Submit',
      );
    }

    return SafeArea(
      child: BlocConsumer<EditStockBloc, EditStockState>(
        listener: (context, state) {
          // jika data berhasil ditambahkan
          if (state.isError != null && !state.isError!) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            editStockBloc.add(InitialEditStock());
            // balik ke halaman stock
            // lalu redirect ke halaman stock agar seperti setstate
            Go.back(context);
            Go.routeWithPathAndRemove(context: context, path: Routes.stock);

            // jika data gagal ditambahkan
          } else if (state.isError != null && state.isError!) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state.isSuccessFetchData) {
            initialName = state.stockName;
            initialQuantity = state.quantity.toString();
            initialMinimumQuantity = state.minimumQuantity.toString();
            valueUnit = state.unit;
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!state.isLoading && state.isSuccessFetchData) {
            return WillPopScope(
              onWillPop: () async {
                editStockBloc.add(InitialEditStock());
                return true;
              },
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    CustomAppBar(
                      title: 'Edit Stock',
                      onTap: () {
                        editStockBloc.add(InitialEditStock());
                        Go.back(context);
                      },
                    ),
                    nameInput(),
                    const SizedBox(height: 16),
                    quantityInput(),
                    const SizedBox(height: 16),
                    minimumQuantity(),
                    const SizedBox(height: 16),
                    selectUnits(valueUnit),
                    buttonSubmit(),
                  ],
                ),
              ),
            );
          } else if (state.isError != null && state.isError!) {
            return Text(state.message);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
