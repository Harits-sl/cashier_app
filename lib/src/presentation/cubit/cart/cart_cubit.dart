import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/data/dataSources/remote/cart_service.dart';
import 'package:cashier_app/src/data/models/cart_model.dart';
import 'package:equatable/equatable.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  void addToCart(CartModel cart) {
    try {
      emit(CartLoading());

      CartService().insertCart(cart);
      emit(const CartSuccess([]));
    } catch (e) {
      emit(CartFailed(e.toString()));
    }
  }
}
