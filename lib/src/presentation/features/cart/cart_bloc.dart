import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/data/dataSources/remote/cart_service.dart';
import 'package:cashier_app/src/data/models/cart_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<FetchCart>(_fetchCart);
    on<ButtonCheckoutPressed>(_buttonCheckoutPressed);
  }

  void _fetchCart(FetchCart event, Emitter<CartState> emit) async {
    try {
      emit(CartLoading());

      final cart = await CartService().getAllCarts();
      emit(CartSuccess(cart));
    } catch (e) {
      debugPrint(e.toString());
      emit(CartFailed(e.toString()));
    }
  }

  void _buttonCheckoutPressed(
      ButtonCheckoutPressed event, Emitter<CartState> emit) {}
}
