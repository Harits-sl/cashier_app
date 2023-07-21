part of 'edit_product_bloc.dart';

enum EditStatus {
  initial,
  successFetch,
  successEdit,
  failed,
  loading,
  edit,
}

class EditProductState extends Equatable {
  const EditProductState({
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
  final EditStatus? status;
  final String? message;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? hpp;

  EditProductState copyWith({
    String? id,
    String? name,
    String? typeMenu,
    int? price,
    EditStatus? status,
    String? message,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? hpp,
  }) {
    return EditProductState(
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
