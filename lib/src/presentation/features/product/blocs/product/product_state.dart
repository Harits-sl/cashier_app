part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<MenuModel> menus;

  const ProductSuccess(this.menus);

  @override
  List<Object> get props => [menus];
}

class ProductDeleteSuccess extends ProductState {
  const ProductDeleteSuccess(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class ProductFailed extends ProductState {
  final String error;

  const ProductFailed(this.error);

  @override
  List<Object> get props => [error];
}
