part of 'stock_bloc.dart';

abstract class StockState extends Equatable {
  const StockState();

  @override
  List<Object> get props => [];
}

class StockInitial extends StockState {}

class StockLoading extends StockState {}

class StockSuccess extends StockState {
  final List<StockModel> stocks;

  const StockSuccess(this.stocks);

  @override
  List<Object> get props => [stocks];
}

class StockFailed extends StockState {
  final String error;

  const StockFailed(this.error);

  @override
  List<Object> get props => [error];
}
