part of 'stock_bloc.dart';

abstract class StockEvent extends Equatable {
  const StockEvent();

  @override
  List<Object> get props => [];
}

class FetchStock extends StockEvent {}

class DeleteStock extends StockEvent {
  final String id;

  const DeleteStock(this.id);

  @override
  List<Object> get props => [id];
}
