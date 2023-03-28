part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final List<CartModel> carts;

  const CartSuccess(this.carts);

  @override
  List<Object> get props => [carts];
}

class CartFailed extends CartState {
  final String error;

  const CartFailed(this.error);

  @override
  List<Object> get props => [error];
}
