part of 'filter_cubit.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

class FilterInitial extends FilterState {}

class FilterLoading extends FilterState {}

class FilterSuccess extends FilterState {
  const FilterSuccess(this.orders);

  final List<MenuOrderModel> orders;

  @override
  List<Object> get props => [orders];
}

class FilterFailed extends FilterState {
  const FilterFailed(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
