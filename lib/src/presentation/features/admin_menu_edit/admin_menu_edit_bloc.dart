import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/core/utils/string_helper.dart';
import 'package:cashier_app/src/data/dataSources/remote/menu_service.dart';
import 'package:cashier_app/src/data/models/menu_model.dart';
import 'package:cashier_app/src/presentation/features/admin_menu_edit/index.dart';

class AdminMenuEditBloc extends Bloc<AdminMenuEditEvent, AdminMenuEditState> {
  String _id = '';

  set setId(String newValue) {
    _id = newValue;
  }

  AdminMenuEditBloc() : super(const AdminMenuEditState()) {
    on<FetchMenuById>(_fetchMenuById);
    on<ClearState>(_onClearState);
  }

  _fetchMenuById(event, Emitter<AdminMenuEditState> emit) async {
    try {
      MenuModel menu = await MenuService().fetchMenuById(_id);
      emit(
        state.copyWith(
          name: menu.name,
          price: menu.price,
          status: Status.success,
          typeMenu: StringHelper.capitalize(menu.typeMenu),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: Status.failed,
        ),
      );
    }
  }

  void _onClearState(ClearState event, Emitter<AdminMenuEditState> emit) {
    emit(
      state.copyWith(
        id: '',
        name: '',
        typeMenu: '',
        price: 0,
        status: Status.initial,
        message: '',
      ),
    );
  }
}
