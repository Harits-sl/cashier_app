import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/data/dataSources/remote/order_service.dart';
import 'package:cashier_app/src/data/models/menu_order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());

  void fetchReportDateOrder(Timestamp firstDate, Timestamp secondDate) async {
    emit(ReportLoading());
    try {
      List<MenuOrderModel> orders =
          await OrderService().getFilterOrder(firstDate, secondDate);

      emit(ReportSuccess(orders));
    } catch (e) {
      emit(ReportFailed(e.toString()));
    }
  }
}
