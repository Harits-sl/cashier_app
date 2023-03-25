import 'package:equatable/equatable.dart';

enum Status {
  initial,
  success,
  failed,
}

class AddMenuState extends Equatable {
  const AddMenuState({
    this.name = '',
    this.typeMenu = '',
    this.price = 0,
    this.status = Status.initial,
    this.message = '',
    this.hpp = 0,
  });

  final String name;
  final String typeMenu;
  final int price;
  final Status status;
  final String message;
  final int hpp;

  AddMenuState copyWith({
    String? name,
    String? typeMenu,
    int? price,
    Status? status,
    String? message,
    int? hpp,
  }) {
    return AddMenuState(
      name: name ?? this.name,
      typeMenu: typeMenu ?? this.typeMenu,
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
      typeMenu,
      price,
      status,
      message,
      hpp,
    ];
  }
}

// class AddMenuInitial extends AddMenuState {}

// class AddMenuLoading extends AddMenuState {}

// class AddMenuSuccess extends AddMenuState {
//   final MenuModel menus;

//   const AddMenuSuccess(this.menus);

//   @override
//   List<Object> get props => [menus];
// }

// class AddMenuFailed extends AddMenuState {
//   final String error;

//   const AddMenuFailed(this.error);

//   @override
//   List<Object> get props => [error];
// }
