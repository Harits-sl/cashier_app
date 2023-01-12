import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/data/dataSources/remote/menu_service.dart';
import 'package:cashier_app/src/data/dataSources/remote/order_service.dart';
import 'package:cashier_app/src/data/models/menu_order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterInitial());

  void fetchFilterDateOrder(Timestamp firstDate, Timestamp secondDate) async {
    emit(FilterLoading());
    try {
      List<MenuOrderModel> orders =
          await OrderService().getFilterOrder(firstDate, secondDate);

      emit(FilterSuccess(orders));
    } catch (e) {
      emit(FilterFailed(e.toString()));
    }
  }
}
