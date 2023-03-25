import 'package:equatable/equatable.dart';

enum Status {
  initial,
  success,
  failed,
  loading,
  edit,
}

class AdminMenuEditState extends Equatable {
  const AdminMenuEditState({
    this.id,
    this.name,
    this.typeMenu,
    this.price,
    this.status,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.hpp,
  });

  final String? id;
  final String? name;
  final String? typeMenu;
  final int? price;
  final Status? status;
  final String? message;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? hpp;

  AdminMenuEditState copyWith({
    String? id,
    String? name,
    String? typeMenu,
    int? price,
    Status? status,
    String? message,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? hpp,
  }) {
    return AdminMenuEditState(
      id: id ?? this.id,
      name: name ?? this.name,
      typeMenu: typeMenu ?? this.typeMenu,
      price: price ?? this.price,
      status: status ?? this.status,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      hpp: hpp ?? this.hpp,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      typeMenu,
      price,
      status,
      message,
      createdAt,
      updatedAt,
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
