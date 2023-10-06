part of 'menu_cubit.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuSuccess extends MenuState {
  final List<MenuModel> menu;

  const MenuSuccess(this.menu);

  @override
  List<Object> get props => [menu];
}

class MenuFailed extends MenuState {
  final String error;

  const MenuFailed(this.error);

  @override
  List<Object> get props => [error];
}
