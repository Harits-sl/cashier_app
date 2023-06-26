import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/data/dataSources/remote/stock_service.dart';
import 'package:cashier_app/src/data/models/stock_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  StockBloc() : super(StockInitial()) {
    on<FetchStock>(_fetchStock);
  }

  _fetchStock(FetchStock event, Emitter<StockState> emit) async {
    try {
      emit(StockLoading());

      final List<StockModel> stocks = await StockService().fetchStocks();
      debugPrint('stocks: ${stocks}');
      emit(StockSuccess(stocks));
    } catch (e) {
      debugPrint('error in fetch stock $e');
      emit(StockFailed(e.toString()));
    }
  }
}
