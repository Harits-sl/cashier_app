import 'package:cashier_app/src/presentation/features/admin_menu_edit/admin_menu_edit_state.dart';
import 'package:equatable/equatable.dart';

abstract class AdminMenuEditEvent extends Equatable {
  const AdminMenuEditEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends AdminMenuEditEvent {
  const NameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class TypeMenuChanged extends AdminMenuEditEvent {
  const TypeMenuChanged({required this.typeMenu});

  final String typeMenu;

  @override
  List<Object> get props => [typeMenu];
}

class PriceChanged extends AdminMenuEditEvent {
  const PriceChanged({required this.price});

  final int price;

  @override
  List<Object> get props => [price];
}

class HppChanged extends AdminMenuEditEvent {
  const HppChanged({required this.hpp});

  final int hpp;

  @override
  List<Object> get props => [hpp];
}

class FetchMenuById extends AdminMenuEditEvent {}

class ClearState extends AdminMenuEditEvent {}

class ButtonEditMenuPressed extends AdminMenuEditEvent {}
