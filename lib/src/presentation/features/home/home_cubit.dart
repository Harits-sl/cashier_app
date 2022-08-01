import 'package:bloc/bloc.dart';

import 'package:cashier_app/src/presentation/features/home/index.dart';
import 'package:flutter/material.dart';

import '../../../data/dataSources/remote/order_service.dart';
import '../../../data/models/menu_order_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void getAllOrder() async {
    try {
      emit(HomeLoading());

      List<MenuOrderModel> listMenuOrder = await OrderService().getAllOrder();
      debugPrint('listMenuOrder: $listMenuOrder');
    } catch (e) {
      emit(HomeFailed(e.toString()));
    }
  }
}
