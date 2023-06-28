part of 'add_stock_bloc.dart';

abstract class AddStockEvent extends Equatable {
  const AddStockEvent();

  @override
  List<Object> get props => [];
}

class InputStockName extends AddStockEvent {
  final String stockName;

  const InputStockName({
    required this.stockName,
  });

  @override
  List<Object> get props => [stockName];
}

class InputQuantity extends AddStockEvent {
  final int quantity;

  const InputQuantity({
    required this.quantity,
  });

  @override
  List<Object> get props => [quantity];
}

class InputMinimumQuantity extends AddStockEvent {
  final int minimumQuantity;

  const InputMinimumQuantity({
    required this.minimumQuantity,
  });

  @override
  List<Object> get props => [minimumQuantity];
}

class InputUnit extends AddStockEvent {
  final String unit;

  const InputUnit({
    required this.unit,
  });

  @override
  List<Object> get props => [unit];
}

class SubmitAddNewStock extends AddStockEvent {}

class SuccessAddNewStock extends AddStockEvent {}

class InitialStock extends AddStockEvent {}
