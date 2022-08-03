import 'package:bloc/bloc.dart';

import 'index.dart';

import '../../../core/utils/date.dart';
import '../../../data/dataSources/remote/order_service.dart';
import '../../../data/models/menu_order_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void getAllOrder() async {
    try {
      emit(HomeLoading());

      List<MenuOrderModel> listMenuOrder = await OrderService().getAllOrder();

      DateTime today = DateTime.now();

      int totalIncomeToday = 0;
      int totalIncomeYesterday = 0;

      for (MenuOrderModel order in listMenuOrder) {
        switch (Date.filter(
            subtractDay: 1, date: order.dateTimeOrder!, today: today)) {
          case 0:
            totalIncomeYesterday += order.total;
            break;
          case 1:
            totalIncomeToday += order.total;
            break;
        }
      }

      List<int> incomeList = [totalIncomeToday, totalIncomeYesterday];

      emit(HomeSuccess(incomeList));
    } catch (e) {
      emit(HomeFailed(e.toString()));
    }
  }
}
