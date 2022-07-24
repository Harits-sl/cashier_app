part of 'json_menu_cubit.dart';

abstract class JsonMenuState extends Equatable {
  const JsonMenuState();

  @override
  List<Object> get props => [];
}

class JsonMenuInitial extends JsonMenuState {}

class JsonMenuLoading extends JsonMenuState {}

class JsonMenuSuccess extends JsonMenuState {
  final List<MenuModel> menu;

  const JsonMenuSuccess(this.menu);

  @override
  List<Object> get props => [menu];
}

class JsonMenuFailed extends JsonMenuState {
  final String error;

  const JsonMenuFailed(this.error);

  @override
  List<Object> get props => [error];
}
