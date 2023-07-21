part of 'add_product_bloc.dart';

enum Status {
  initial,
  success,
  failed,
}

class AddProductState extends Equatable {
  const AddProductState({
    this.name = '',
    this.typeProduct = '',
    this.price = 0,
    this.status = Status.initial,
    this.message = '',
    this.hpp = 0,
  });

  final String name;
  final String typeProduct;
  final int price;
  final Status status;
  final String message;
  final int hpp;

  AddProductState copyWith({
    String? name,
    String? typeProduct,
    int? price,
    Status? status,
    String? message,
    int? hpp,
  }) {
    return AddProductState(
      name: name ?? this.name,
      typeProduct: typeProduct ?? this.typeProduct,
      price: price ?? this.price,
      status: status ?? this.status,
      message: message ?? this.message,
      hpp: hpp ?? this.hpp,
    );
  }

  @override
  List<Object> get props {
    return [
      name,
      typeProduct,
      price,
      status,
      message,
      hpp,
    ];
  }
}

// class AddProductInitial extends AddProductState {}

// class AddProductLoading extends AddProductState {}

// class AddProductSuccess extends AddProductState {
//   final MenuModel menus;

//   const AddProductSuccess(this.menus);

//   @override
//   List<Object> get props => [menus];
// }

// class AddProductFailed extends AddProductState {
//   final String error;

//   const AddProductFailed(this.error);

//   @override
//   List<Object> get props => [error];
// }
