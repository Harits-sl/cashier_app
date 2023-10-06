import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/core/utils/status_inventory.dart';
import 'package:cashier_app/src/data/dataSources/remote/stock_service.dart';
import 'package:cashier_app/src/data/models/stock_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'edit_stock_event.dart';
part 'edit_stock_state.dart';

class EditStockBloc extends Bloc<EditStockEvent, EditStockState> {
  EditStockBloc() : super(const EditStockState()) {
    on<FetchStockById>(_fetchStockById);
    on<EditStockName>(_editStockName);
    on<EditQuantity>(_editQuantity);
    on<EditMinimumQuantity>(_editMinimumQuantity);
    on<EditUnit>(_editUnit);
    on<SubmitEditStock>(_submitEditStock);
    on<SuccessEditStock>(_successEditStock);
    on<InitialEditStock>(_initialStock);
  }

  void _fetchStockById(
      FetchStockById event, Emitter<EditStockState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final StockModel stock = await StockService().fetchStockById(event.id);
      emit(state.copyWith(
        id: stock.id,
        stockName: stock.name,
        quantity: stock.quantity,
        minimumQuantity: stock.minimumQuantity,
        unit: stock.unit,
        createdAt: stock.createdAt,
        isLoading: false,
        isSuccessFetchData: true,
      ));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(
        isError: true,
        isLoading: false,
        message: 'please try again $e',
      ));
    }
  }

  void _editStockName(EditStockName event, Emitter<EditStockState> emit) {
    emit(state.copyWith(stockName: event.stockName));
  }

  void _editQuantity(EditQuantity event, Emitter<EditStockState> emit) {
    emit(state.copyWith(quantity: event.quantity));
  }

  void _editMinimumQuantity(
    EditMinimumQuantity event,
    Emitter<EditStockState> emit,
  ) {
    emit(
      state.copyWith(minimumQuantity: event.minimumQuantity),
    );
  }

  void _editUnit(EditUnit event, Emitter<EditStockState> emit) {
    emit(state.copyWith(unit: event.unit));
  }

  void _submitEditStock(
    SubmitEditStock event,
    Emitter<EditStockState> emit,
  ) async {
    try {
      final String id = state.id;
      final String name = state.stockName;
      final int quantity = state.quantity;
      final int minimumQuantity = state.minimumQuantity;
      final String unit = state.unit;
      StatusInventory status;
      final DateTime createdAt = state.createdAt!;
      final DateTime updatedAt = DateTime.now();

      if (quantity <= 0) {
        status = StatusInventory.outOfStock;
      } else if (quantity > minimumQuantity) {
        status = StatusInventory.inStock;
      } else {
        status = StatusInventory.lowStock;
      }

      StockModel stockModel = StockModel(
        id: id,
        name: name,
        quantity: quantity,
        minimumQuantity: minimumQuantity,
        unit: unit,
        status: status,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      await StockService().editStock(stockModel);
      emit(state.copyWith(
        isError: false,
        message: 'Success edit data',
      ));
    } catch (e) {
      debugPrint('error when edit data stock: $e');
      emit(state.copyWith(
        isError: true,
        message: 'Error, Please try again',
      ));
    }
  }

  void _successEditStock(
      SuccessEditStock event, Emitter<EditStockState> emit) {}
  void _initialStock(InitialEditStock event, Emitter<EditStockState> emit) {
    emit(state.toInitialState());
  }
}
