part of 'edit_stock_bloc.dart';

class EditStockState extends Equatable {
  final String id;
  final String stockName;
  final String? typeMenu;
  final int? price;
  final int? hpp;
  final int quantity;
  final int minimumQuantity;
  final String unit;
  final DateTime? createdAt;
  final bool? isError;
  final String message;
  final bool isLoading;
  final bool isSuccessFetchData;

  const EditStockState({
    this.id = '',
    this.stockName = '',
    this.typeMenu,
    this.price,
    this.hpp,
    this.quantity = 0,
    this.minimumQuantity = 0,
    this.unit = '',
    this.createdAt,
    this.isError,
    this.message = '',
    this.isLoading = false,
    this.isSuccessFetchData = false,
  });

  EditStockState toInitialState() {
    return const EditStockState(
      id: '',
      stockName: '',
      quantity: 0,
      minimumQuantity: 0,
      unit: '',
      createdAt: null,
      isError: null,
      message: '',
      isLoading: false,
      isSuccessFetchData: false,
    );
  }

  EditStockState copyWith({
    String? id,
    String? stockName,
    String? typeMenu,
    int? price,
    int? hpp,
    int? quantity,
    int? minimumQuantity,
    String? unit,
    DateTime? createdAt,
    bool? isError,
    String? message,
    bool? isLoading,
    bool? isSuccessFetchData,
  }) {
    return EditStockState(
      id: id ?? this.id,
      stockName: stockName ?? this.stockName,
      typeMenu: typeMenu ?? this.typeMenu,
      price: price ?? this.price,
      hpp: hpp ?? this.hpp,
      quantity: quantity ?? this.quantity,
      minimumQuantity: minimumQuantity ?? this.minimumQuantity,
      unit: unit ?? this.unit,
      createdAt: createdAt ?? this.createdAt,
      isError: isError ?? this.isError,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      isSuccessFetchData: isSuccessFetchData ?? this.isSuccessFetchData,
    );
  }

  @override
  List<Object?> get props => [
        id,
        stockName,
        quantity,
        minimumQuantity,
        unit,
        createdAt,
        isError,
        message,
        isLoading,
        isSuccessFetchData,
      ];
}
