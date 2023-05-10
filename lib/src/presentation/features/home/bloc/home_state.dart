part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  /// [totalIncomeToday, totalIncomeYesterday]
  final Map<DateStatus, int> totalList;

  const HomeSuccess(this.totalList);

  @override
  List<Object> get props => [totalList];
}

class HomeFailed extends HomeState {
  final String error;

  const HomeFailed(this.error);

  @override
  List<Object> get props => [error];
}
