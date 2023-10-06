part of 'edit_order_from_cart_bloc.dart';

abstract class EditOrderFromCartEvent extends Equatable {
  const EditOrderFromCartEvent();

  @override
  List<Object?> get props => [];
}

class GetDataCart extends EditOrderFromCartEvent {
  final String id;

  const GetDataCart({required this.id});

  @override
  List<Object> get props => [id];
}

class AddMenusCart extends EditOrderFromCartEvent {
  final String id;
  final int price;
  final String menuName;
  final int totalBuy;
  final int hpp;
  final String typeMenu;

  const AddMenusCart({
    required this.id,
    required this.price,
    required this.menuName,
    required this.totalBuy,
    required this.hpp,
    required this.typeMenu,
  });

  @override
  List<Object?> get props => [id, price, menuName, totalBuy, hpp, typeMenu];
}

class EditOrderIncrementPressed extends EditOrderFromCartEvent {
  final String id;

  const EditOrderIncrementPressed({required this.id});

  @override
  List<Object> get props => [id];
}

class EditSearchMenu extends EditOrderFromCartEvent {
  final String query;

  const EditSearchMenu({required this.query});

  @override
  List<Object> get props => [query];
}

class EditOrderDecrementPressed extends EditOrderFromCartEvent {
  final String id;

  const EditOrderDecrementPressed({required this.id});

  @override
  List<Object> get props => [id];
}

class EditOrderCheckoutPressed extends EditOrderFromCartEvent {}

class EditResetState extends EditOrderFromCartEvent {}
