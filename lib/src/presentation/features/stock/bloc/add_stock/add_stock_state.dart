part of 'add_stock_bloc.dart';

class AddStockState extends Equatable {
  final String stockName;
  final int quantity;
  final int minimumQuantity;
  final String unit;
  final bool? isError;
  final String message;

  const AddStockState({
    this.stockName = '',
    this.quantity = 0,
    this.minimumQuantity = 0,
    this.unit = '',
    this.isError,
    this.message = '',
  });

  AddStockState toInitialState() {
    return const AddStockState(
      stockName: '',
      quantity: 0,
      minimumQuantity: 0,
      unit: '',
      isError: null,
      message: '',
    );
  }

  AddStockState copyWith({
    String? stockName,
    int? quantity,
    int? minimumQuantity,
    String? unit,
    bool? isError,
    String? message,
  }) {
    return AddStockState(
      stockName: stockName ?? this.stockName,
      quantity: quantity ?? this.quantity,
      minimumQuantity: minimumQuantity ?? this.minimumQuantity,
      unit: unit ?? this.unit,
      isError: isError ?? this.isError,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        stockName,
        quantity,
        minimumQuantity,
        unit,
        isError,
        message,
      ];
}
