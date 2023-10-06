import 'dart:async';

import 'package:cashier_app/src/config/route/go.dart';
import 'package:cashier_app/src/config/route/routes.dart';
import 'package:cashier_app/src/presentation/features/product/index.dart';
import 'package:cashier_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProductPage extends StatefulWidget {
  static const String routeName = '/product/edit-product';

  final String id;

  const EditProductPage({Key? key, required this.id}) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    context.read<EditProductBloc>().add(FetchProductById(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProductBloc, EditProductState>(
      listener: (context, state) {
        if (state.status == EditStatus.successEdit) {
          final snackBar = SnackBar(content: Text(state.message!));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          context.read<EditProductBloc>().add(EditClearState());

          Timer(const Duration(seconds: 3), () {
            // balik ke halaman product
            // lalu redirect ke halaman product agar seperti setstate
            Go.back(context);
            Go.routeWithPathAndRemove(context: context, path: Routes.product);
          });
        }
      },
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            context.read<EditProductBloc>().add(EditClearState());
            return true;
          },
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const CustomAppBar(title: 'Edit Product'),
                const EditFormProductScreen(),
                ButtonEditProductScreen(formKey: formKey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
