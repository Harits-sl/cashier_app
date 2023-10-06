import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/data/dataSources/remote/menu_service.dart';
import 'package:cashier_app/src/data/models/menu_model.dart';
import 'package:equatable/equatable.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  void getAllMenu() async {
    try {
      emit(ProductLoading());

      List<MenuModel> menus = await MenuService().fetchMenu();

      emit(ProductSuccess(menus));
    } catch (e, stackTrace) {
      emit(ProductFailed('$e, \n$stackTrace'));
    }
  }

  void deleteMenu(id) async {
    try {
      emit(ProductLoading());

      MenuService().deleteMenu(id);

      emit(const ProductDeleteSuccess('Success Deleted'));
    } catch (e) {
      emit(ProductFailed('$e'));
    }
  }
}
