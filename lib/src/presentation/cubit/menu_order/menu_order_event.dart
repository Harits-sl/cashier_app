part of 'menu_order_cubit.dart';

abstract class MenuOrderEvent extends Equatable {
  const MenuOrderEvent();

  @override
  List<Object> get props => [];
}

class OrderIncrementPressed extends MenuOrderEvent {}

class OrderDecrementPressed extends MenuOrderEvent {}
