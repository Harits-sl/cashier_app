import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/core/utils/status_inventory.dart';
import 'package:cashier_app/src/data/dataSources/remote/stock_service.dart';
import 'package:cashier_app/src/data/models/stock_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'add_stock_event.dart';
part 'add_stock_state.dart';

class AddStockBloc extends Bloc<AddStockEvent, AddStockState> {
  AddStockBloc() : super(const AddStockState()) {
    on<InputStockName>(_inputStockName);
    on<InputQuantity>(_inputQuantity);
    on<InputMinimumQuantity>(_inputMinimumQuantity);
    on<InputUnit>(_inputUnit);
    on<SubmitAddNewStock>(_submitAddNewStock);
    on<SuccessAddNewStock>(_successAddNewStock);
    on<InitialStock>(_initialStock);
  }

  void _inputStockName(InputStockName event, Emitter<AddStockState> emit) {
    emit(state.copyWith(stockName: event.stockName));
  }

  void _inputQuantity(InputQuantity event, Emitter<AddStockState> emit) {
    emit(state.copyWith(quantity: event.quantity));
  }

  void _inputMinimumQuantity(
    InputMinimumQuantity event,
    Emitter<AddStockState> emit,
  ) {
    emit(
      state.copyWith(minimumQuantity: event.minimumQuantity),
    );
  }

  void _inputUnit(InputUnit event, Emitter<AddStockState> emit) {
    emit(state.copyWith(unit: event.unit));
  }

  void _submitAddNewStock(
    SubmitAddNewStock event,
    Emitter<AddStockState> emit,
  ) async {
    try {
      final String id = 'stock-${Random().nextInt(255)}';
      final String name = state.stockName;
      final int quantity = state.quantity;
      final int minimumQuantity = state.minimumQuantity;
      final String unit = state.unit;
      StatusInventory status;
      final DateTime createdAt = DateTime.now();
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

      await StockService().addStock(stockModel);
      emit(state.copyWith(
        isError: false,
        message: 'Success add data',
      ));
    } catch (e) {
      debugPrint('error when add data stock: $e');
      emit(state.copyWith(
        isError: true,
        message: 'Error, Please try again',
      ));
    }
  }

  void _successAddNewStock(
      SuccessAddNewStock event, Emitter<AddStockState> emit) {}
  void _initialStock(InitialStock event, Emitter<AddStockState> emit) {
    emit(state.toInitialState());
  }
}
