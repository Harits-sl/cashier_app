import 'dart:async';

import 'package:cashier_app/src/config/route/go.dart';
import 'package:cashier_app/src/config/route/routes.dart';
import 'package:cashier_app/src/presentation/features/product/index.dart';
import 'package:cashier_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductPage extends StatelessWidget {
  static const String routeName = '/product/add-product';

  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: BlocListener<AddProductBloc, AddProductState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            final snackBar = SnackBar(content: Text(state.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            context.read<AddProductBloc>().add(ClearState());

            Timer(const Duration(seconds: 3), () {
              // balik ke halaman product
              // lalu redirect ke halaman product agar seperti setstate
              Go.back(context);
              Go.routeWithPathAndRemove(context: context, path: Routes.product);
            });
          }
        },
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const CustomAppBar(title: 'Add New Product'),
              const AddFormProductScreen(),
              ButtonAddProductScreen(
                formKey: _formKey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
