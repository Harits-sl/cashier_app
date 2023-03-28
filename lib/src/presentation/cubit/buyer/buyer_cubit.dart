import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/data/dataSources/remote/Cart_service.dart';
import 'package:cashier_app/src/data/models/cart_model.dart';
import 'package:equatable/equatable.dart';

part 'buyer_state.dart';

class BuyerCubit extends Cubit<BuyerState> {
  BuyerCubit() : super(BuyerInitial());

  void addToCart(CartModel cart) {
    try {
      emit(BuyerLoading());

      CartService().insertCart(cart);
      emit(const BuyerSuccess([]));
    } catch (e) {
      emit(BuyerFailed(e.toString()));
    }
  }
}
