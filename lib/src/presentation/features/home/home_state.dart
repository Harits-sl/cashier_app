import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  // final List<HomeModel> home;

  // const HomeSuccess(this.home);

  // @override
  // List<Object> get props => [home];
}

class HomeFailed extends HomeState {
  final String error;

  const HomeFailed(this.error);

  @override
  List<Object> get props => [error];
}
