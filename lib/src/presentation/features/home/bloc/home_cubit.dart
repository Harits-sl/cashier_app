import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/data/dataSources/remote/order_service.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

enum DateStatus { today, yesterday, oneWeek, oneMonth }

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void fetchOrder() async {
    try {
      emit(HomeLoading());

      int incomeToday = await OrderService().getTodayOrder();
      int incomeYesterday = await OrderService().getYesterdayOrder();
      int incomeOneWeek = await OrderService().getOneWeekOrder();
      int incomeOneMonth = await OrderService().getOneMonthOrder();

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
}
