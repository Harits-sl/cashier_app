import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/data/dataSources/remote/order_service.dart';
import 'package:cashier_app/src/data/models/menu_order_model.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

enum DateStatus { today, yesterday, oneWeek, oneMonth }

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void fetchOrder() async {
    try {
      emit(HomeLoading());

      int incomeToday = totalOrder(await OrderService().getTodayOrder());
      int incomeYesterday =
          totalOrder(await OrderService().getYesterdayOrder());
      int incomeOneWeek = totalOrder(await OrderService().getThisWeekOrder());
      int incomeOneMonth = totalOrder(await OrderService().getThisMonthOrder());

      Map<DateStatus, int> incomeList = {
        DateStatus.today: incomeToday,
        DateStatus.yesterday: incomeYesterday,
        DateStatus.oneWeek: incomeOneWeek,
        DateStatus.oneMonth: incomeOneMonth
      };

      emit(HomeSuccess(incomeList));
    } catch (e) {
      emit(HomeFailed(e.toString()));
    }
  }

  int totalOrder(List<MenuOrderModel> orders) {
    int total = 0;

    for (var order in orders) {
      total += order.total;
    }
    return total;
  }
}
