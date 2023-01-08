import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/data/dataSources/remote/menu_service.dart';

import 'package:cashier_app/src/presentation/features/admin/index.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/models/menu_model.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());

  void getAllMenu() async {
    try {
      emit(AdminLoading());

      List<MenuModel> menus = await MenuService().fetchMenu();

      emit(AdminSuccess(menus));
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      print(stackTrace);
      emit(AdminFailed('$e, \n$stackTrace'));
    }
  }
}
