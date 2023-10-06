part of 'edit_stock_bloc.dart';

abstract class EditStockEvent extends Equatable {
  const EditStockEvent();

  @override
  List<Object> get props => [];
}

class FetchStockById extends EditStockEvent {
  final String id;

  const FetchStockById(this.id);

  @override
  List<Object> get props => [id];
}

class EditStockName extends EditStockEvent {
  final String stockName;

  const EditStockName({
    required this.stockName,
  });

  @override
  List<Object> get props => [stockName];
}

class EditQuantity extends EditStockEvent {
  final int quantity;

  const EditQuantity({
    required this.quantity,
  });

  @override
  List<Object> get props => [quantity];
}

class EditMinimumQuantity extends EditStockEvent {
  final int minimumQuantity;

  const EditMinimumQuantity({
    required this.minimumQuantity,
  });

  @override
  List<Object> get props => [minimumQuantity];
}

class EditUnit extends EditStockEvent {
  final String unit;

  const EditUnit({
    required this.unit,
  });

  @override
  List<Object> get props => [unit];
}

class SubmitEditStock extends EditStockEvent {}

class SuccessEditStock extends EditStockEvent {}

class InitialEditStock extends EditStockEvent {}
