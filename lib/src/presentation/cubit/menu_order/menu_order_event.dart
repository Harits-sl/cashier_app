part of 'menu_order_bloc.dart';

abstract class MenuOrderEvent extends Equatable {
  const MenuOrderEvent();

  @override
  List<Object?> get props => [];
}

class AddMenus extends MenuOrderEvent {
  final String id;
  final int price;
  final String menuName;
  final int totalBuy;
  final int hpp;
  final String typeMenu;

  const AddMenus({
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

class OrderIncrementPressed extends MenuOrderEvent {
  final String id;

  const OrderIncrementPressed({required this.id});

  @override
  List<Object> get props => [id];
}

class SearchMenu extends MenuOrderEvent {
  final String query;

  const SearchMenu({required this.query});

  @override
  List<Object> get props => [query];
}

class OrderDecrementPressed extends MenuOrderEvent {
  final String id;

  const OrderDecrementPressed({required this.id});

  @override
  List<Object> get props => [id];
}

class OrderCheckoutPressed extends MenuOrderEvent {}

class OrderTypePaymentPressed extends MenuOrderEvent {
  final String typePayment;

  const OrderTypePaymentPressed({
    required this.typePayment,
  });
  @override
  List<Object> get props => [typePayment];
}

class AddCashAndChangePayment extends MenuOrderEvent {
  final int cash;
  final int change;
  const AddCashAndChangePayment({
    required this.cash,
    required this.change,
  });

  @override
  List<Object> get props => [cash, change];
}

class AddBuyerName extends MenuOrderEvent {
  final String? buyer;
  const AddBuyerName({
    this.buyer,
  });

  @override
  List<Object?> get props => [buyer];
}

class AddOrderToFirestore extends MenuOrderEvent {}

class ResetState extends MenuOrderEvent {}
