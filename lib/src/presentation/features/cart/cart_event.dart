part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class FetchCart extends CartEvent {}

class ButtonCheckoutPressed extends CartEvent {}
