import 'package:cashier_app/src/data/models/menu_model.dart';
import 'package:equatable/equatable.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminSuccess extends AdminState {
  final List<MenuModel> menus;

  const AdminSuccess(this.menus);

  @override
  List<Object> get props => [menus];
}

class AdminDeleteSuccess extends AdminState {
  const AdminDeleteSuccess(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class AdminFailed extends AdminState {
  final String error;

  const AdminFailed(this.error);

  @override
  List<Object> get props => [error];
}
