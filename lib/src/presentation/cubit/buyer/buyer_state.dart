part of 'buyer_cubit.dart';

abstract class BuyerState extends Equatable {
  const BuyerState();

  @override
  List<Object> get props => [];
}

class BuyerInitial extends BuyerState {}

class BuyerLoading extends BuyerState {}

class BuyerSuccess extends BuyerState {
  final List<Map<String, dynamic>> buyer;

  const BuyerSuccess(this.buyer);

  @override
  List<Object> get props => [buyer];
}

class BuyerFailed extends BuyerState {
  final String error;

  const BuyerFailed(this.error);

  @override
  List<Object> get props => [error];
}
