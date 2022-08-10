import 'package:equatable/equatable.dart';

abstract class AddMenuState extends Equatable {
  const AddMenuState();

  @override
  List<Object> get props => [];
}

class AddMenuInitial extends AddMenuState {}

class AddMenuLoading extends AddMenuState {}

class AddMenuSuccess extends AddMenuState {
  final List<String> addMenu;

  const AddMenuSuccess(this.addMenu);

  @override
  List<Object> get props => [addMenu];
}

class AddMenuFailed extends AddMenuState {
  final String error;

  const AddMenuFailed(this.error);

  @override
  List<Object> get props => [error];
}
