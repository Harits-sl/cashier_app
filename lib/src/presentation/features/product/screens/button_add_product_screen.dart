import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/presentation/features/product/index.dart';
import 'package:cashier_app/src/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonAddProductScreen extends StatelessWidget {
  const ButtonAddProductScreen({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    void _onPressed() {
      // Validate returns true if the form is valid, or false otherwise.
      if (formKey.currentState!.validate()) {
        // If the form is valid, display a snackbar. In the real world,
        // you'd often call a server or save the information in a database.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Processing Data')),
        );

        context.read<AddProductBloc>().add(ButtonAddProductPressed());
      }
    }

    return CustomButton(
      color: primaryColor,
      onPressed: _onPressed,
      text: 'Add Product',
    );
  }
}
