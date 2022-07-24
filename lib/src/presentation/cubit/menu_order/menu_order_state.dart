part of 'menu_order_cubit.dart';

abstract class MenuOrderState extends Equatable {
  const MenuOrderState();

  @override
  List<Object> get props => [];
}

class MenuOrderInitial extends MenuOrderState {}

class MenuOrderSuccess extends MenuOrderState {
  const MenuOrderSuccess(this.menuOrder);

  final MenuOrderModel menuOrder;

  @override
  List<Object> get props => [menuOrder];
}
