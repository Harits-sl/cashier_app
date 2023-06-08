import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/core/utils/date.dart';
import 'package:cashier_app/src/data/dataSources/remote/order_service.dart';
import 'package:cashier_app/src/data/models/menu_order_model.dart';
import 'package:cashier_app/src/presentation/features/report/report_order.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());

  // void fetchReportDateOrder(Timestamp firstDate, Timestamp secondDate) async {
  //   emit(ReportLoading());
  //   try {
  //     List<MenuOrderModel> orders =
  //         await OrderService().getFilterOrder(firstDate, secondDate);

  //     emit(ReportSuccess(orders));
  //   } catch (e) {
  //     emit(ReportFailed(e.toString()));
  //   }
  // }
  int _seluruhTotalMinuman = 0;
  int _seluruhTotalMakanan = 0;
  int _seluruhJumlahMinumanTerjual = 0;
  int _seluruhJumlahMakananTerjual = 0;
  int _seluruhLabaMinuman = 0;
  int _seluruhLabaMakanan = 0;
  int _seluruhLabaBersihMinuman = 0;
  int _seluruhLabaBersihMakanan = 0;
  int _totalseluruhLabaBersih = 0;

  int get seluruhTotalMinuman => _seluruhTotalMinuman;
  int get seluruhTotalMakanan => _seluruhTotalMakanan;
  int get seluruhJumlahMinumanTerjual => _seluruhJumlahMinumanTerjual;
  int get seluruhJumlahMakananTerjual => _seluruhJumlahMakananTerjual;
  int get seluruhLabaMinuman => _seluruhLabaMinuman;
  int get seluruhLabaMakanan => _seluruhLabaMakanan;
  int get seluruhLabaBersihMinuman => _seluruhLabaBersihMinuman;
  int get seluruhLabaBersihMakanan => _seluruhLabaBersihMakanan;
  int get totalseluruhLabaBersih => _totalseluruhLabaBersih;

  void fetchReportOrderToday() async {
    emit(ReportLoading());
    try {
      List<MenuOrderModel> orders = await OrderService().getTodayOrder();
      List<ReportOrder> reportOrders = orders.map(
        (order) {
          int totalMinuman = 0;
          int totalMakanan = 0;
          int jumlahMinumanTerjual = 0;
          int jumlahMakananTerjual = 0;
          int labaMinuman = 0;
          int labaMakanan = 0;

          addToDrink(menu) {
            totalMinuman += menu['totalBuy'] as int;
            jumlahMinumanTerjual +=
                ((menu['price'] as int) * (menu['totalBuy'] as int));
            labaMinuman += ((menu['hpp'] as int) * (menu['totalBuy'] as int));
          }

          addToFood(menu) {
            totalMakanan += menu['totalBuy'] as int;
            jumlahMakananTerjual +=
                ((menu['price'] as int) * (menu['totalBuy'] as int));
            labaMakanan += ((menu['hpp'] as int) * (menu['totalBuy'] as int));
          }

          for (var menu in order.listMenus!) {
            if (menu['typeMenu'] == 'coffee' ||
                menu['typeMenu'] == 'non-coffee') {
              addToDrink(menu);
            } else if (menu['typeMenu'] == 'food') {
              addToFood(menu);
            }
          }

          int labaBersihMinuman = jumlahMinumanTerjual - labaMinuman;
          int labaBersihMakanan = jumlahMakananTerjual - labaMakanan;
          int labaBersihSeluruh = labaBersihMinuman + labaBersihMakanan;

          _seluruhTotalMinuman += totalMinuman;
          _seluruhTotalMakanan += totalMakanan;
          _seluruhJumlahMinumanTerjual += jumlahMinumanTerjual;
          _seluruhJumlahMakananTerjual += jumlahMakananTerjual;
          _seluruhLabaMinuman += labaMinuman;
          _seluruhLabaMakanan += labaMakanan;
          _seluruhLabaBersihMinuman += labaBersihMinuman;
          _seluruhLabaBersihMakanan += labaBersihMakanan;
          _totalseluruhLabaBersih += labaBersihSeluruh;

          return ReportOrder(
            id: order.id!,
            tanggal: Date.format(order.dateTimeOrder!),
            totalMinuman: totalMinuman,
            totalMakanan: totalMakanan,
            jumlahMinumanTerjual: jumlahMinumanTerjual,
            jumlahMakananTerjual: jumlahMakananTerjual,
            labaMinuman: labaMinuman,
            labaMakanan: labaMakanan,
            labaBersihMinuman: labaBersihMinuman,
            labaBersihMakanan: labaBersihMakanan,
            labaBersihSeluruh: labaBersihSeluruh,
          );
        },
      ).toList();

      emit(ReportSuccess(reportOrders));
    } catch (e) {
      emit(ReportFailed(e.toString()));
    }
  }
}
