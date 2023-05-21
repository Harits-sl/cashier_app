import 'package:cashier_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cashier_app/src/presentation/features/cart/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);
  static const String routeName = '/cart';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();

    context.read<CartBloc>().add(FetchCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is CartSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CustomAppBar(title: 'Cart'),
                  MenuOrder(),
                ],
              );
            } else if (state is CartFailed) {
              return Text(state.error);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
