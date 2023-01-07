import 'package:equatable/equatable.dart';

enum Status {
  initial,
  success,
  failed,
}

class AdminMenuEditState extends Equatable {
  const AdminMenuEditState({
    this.id = '',
    this.name = '',
    this.typeMenu = '',
    this.price = 0,
    this.status = Status.initial,
    this.message = '',
  });

  final String id;
  final String name;
  final String typeMenu;
  final int price;
  final Status status;
  final String message;

  AdminMenuEditState copyWith({
    String? id,
    String? name,
    String? typeMenu,
    int? price,
    Status? status,
    String? message,
  }) {
    return AdminMenuEditState(
      id: id ?? this.id,
      name: name ?? this.name,
      typeMenu: typeMenu ?? this.typeMenu,
      price: price ?? this.price,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      typeMenu,
      price,
      status,
      message,
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
