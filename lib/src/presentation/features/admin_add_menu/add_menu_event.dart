import 'package:equatable/equatable.dart';

abstract class AddMenuEvent extends Equatable {
  const AddMenuEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends AddMenuEvent {
  const NameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class TypeMenuChanged extends AddMenuEvent {
  const TypeMenuChanged({required this.typeMenu});

  final String typeMenu;

  @override
  List<Object> get props => [typeMenu];
}

class PriceChanged extends AddMenuEvent {
  const PriceChanged({required this.price});

  final int price;

  @override
  List<Object> get props => [price];
}

class HppChanged extends AddMenuEvent {
  const HppChanged({required this.hpp});

  final int hpp;

  @override
  List<Object> get props => [hpp];
}

class ButtonAddMenuPressed extends AddMenuEvent {}

class ClearState extends AddMenuEvent {}
