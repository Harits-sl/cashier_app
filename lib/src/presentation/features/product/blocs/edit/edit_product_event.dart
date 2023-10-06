part of 'edit_product_bloc.dart';

abstract class EditProductEvent extends Equatable {
  const EditProductEvent();

  @override
  List<Object> get props => [];
}

class EditNameChanged extends EditProductEvent {
  const EditNameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class EditTypeProductChanged extends EditProductEvent {
  const EditTypeProductChanged({required this.typeProduct});

  final String typeProduct;

  @override
  List<Object> get props => [typeProduct];
}

class EditPriceChanged extends EditProductEvent {
  const EditPriceChanged({required this.price});

  final int price;

  @override
  List<Object> get props => [price];
}

class EditHppChanged extends EditProductEvent {
  const EditHppChanged({required this.hpp});

  final int hpp;

  @override
  List<Object> get props => [hpp];
}

class FetchProductById extends EditProductEvent {
  const FetchProductById({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}

class EditClearState extends EditProductEvent {}

class ButtonEditProductPressed extends EditProductEvent {}
