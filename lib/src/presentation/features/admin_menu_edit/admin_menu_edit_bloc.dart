import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/core/utils/string_helper.dart';
import 'package:cashier_app/src/data/dataSources/remote/menu_service.dart';
import 'package:cashier_app/src/data/models/menu_model.dart';
import 'package:cashier_app/src/presentation/features/admin_menu_edit/index.dart';
import 'package:flutter/foundation.dart';

class AdminMenuEditBloc extends Bloc<AdminMenuEditEvent, AdminMenuEditState> {
  String _id = '';

  set setId(String newValue) {
    _id = newValue;
  }

  AdminMenuEditBloc() : super(const AdminMenuEditState()) {
    on<FetchMenuById>(_fetchMenuById);
    on<ClearState>(_onClearState);
    on<ButtonEditMenuPressed>(_buttonEditMenuPressed);
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

  void _buttonEditMenuPressed(
      ButtonEditMenuPressed event, Emitter<AdminMenuEditState> emit) async {
    try {
      // emit(AddMenuLoading());

      // String id = 'menu-${Random().nextInt(255)}';
      String id = '';
      String name = state.name;
      int price = state.price;
      String typeMenu = state.typeMenu;
      final DateTime createdAt = DateTime.now();
      final DateTime updatedAt = DateTime.now();

      MenuModel menuModel = MenuModel(
        id: id,
        name: name,
        typeMenu: typeMenu.toLowerCase(),
        price: price,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      if (name == '') {
        emit(
          state.copyWith(
            status: Status.failed,
            message: 'Nama Menu Kosong',
          ),
        );
        throw Exception(state.message);
      }

      if (price == 0) {
        emit(
          state.copyWith(
            status: Status.failed,
            message: 'Harga Menu Kosong',
          ),
        );
        throw Exception(state.message);
      }

      MenuService().addMenu(menuModel);
      emit(
        state.copyWith(
          status: Status.success,
          message: 'Success Add Menu',
        ),
      );
    } catch (error) {
      debugPrint('error: $error');
      emit(
        state.copyWith(
          status: Status.failed,
          message: error.toString(),
        ),
      );
    }
  }
}
