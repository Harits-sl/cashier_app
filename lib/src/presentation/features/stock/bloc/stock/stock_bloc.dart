import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/data/dataSources/remote/menu_service.dart';
// import 'package:cashier_app/src/data/dataSources/remote/stock_service.dart';
import 'package:cashier_app/src/data/models/menu_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  StockBloc() : super(StockInitial()) {
    on<FetchStock>(_fetchStock);
    on<DeleteStock>(_deleteStock);
  }

  _fetchStock(FetchStock event, Emitter<StockState> emit) async {
    try {
      emit(StockLoading());

      final List<MenuModel> menus = await MenuService().fetchMenu();
      emit(StockSuccess(menus));
    } catch (e) {
      debugPrint('error in fetch menus $e');
      emit(StockFailed(e.toString()));
    }
  }

  _deleteStock(DeleteStock event, Emitter<StockState> emit) async {
    try {
      emit(StockDeleteLoading());
      MenuService().deleteMenu(event.id);
      emit(const StockDeleteSuccess('Success Delete'));
    } catch (e) {
      debugPrint('error in delete stock $e');
      emit(StockFailed(e.toString()));
    }
  }
}
