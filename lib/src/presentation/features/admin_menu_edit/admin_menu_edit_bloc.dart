import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/core/utils/string_helper.dart';
import 'package:cashier_app/src/data/dataSources/remote/menu_service.dart';
import 'package:cashier_app/src/data/models/menu_model.dart';
import 'package:cashier_app/src/presentation/features/admin_menu_edit/index.dart';
import 'package:flutter/foundation.dart';

class AdminMenuEditBloc extends Bloc<AdminMenuEditEvent, AdminMenuEditState> {
  String _id = '';
  String _name = '';

  set setId(String newValue) {
    _id = newValue;
  }

  AdminMenuEditBloc() : super(const AdminMenuEditState()) {
    on<NameChanged>(_onNameChanged);
    on<PriceChanged>(_onPriceChanged);
    on<HppChanged>(_onHppChanged);
    on<TypeMenuChanged>(_onTypeMenuChanged);
    on<FetchMenuById>(_fetchMenuById);
    on<ClearState>(_onClearState);
    on<ButtonEditMenuPressed>(_buttonEditMenuPressed);
  }

  void _onNameChanged(NameChanged event, Emitter<AdminMenuEditState> emit) {
    emit(
      state.copyWith(
        status: Status.edit,
        name: event.name,
      ),
    );
  }

  void _onPriceChanged(PriceChanged event, Emitter<AdminMenuEditState> emit) {
    emit(
      state.copyWith(
        status: Status.edit,
        price: event.price,
      ),
    );
  }

  void _onHppChanged(HppChanged event, Emitter<AdminMenuEditState> emit) {
    emit(
      state.copyWith(
        status: Status.edit,
        hpp: event.hpp,
      ),
    );
  }

  void _onTypeMenuChanged(
      TypeMenuChanged event, Emitter<AdminMenuEditState> emit) {
    emit(
      state.copyWith(
        status: Status.edit,
        typeMenu: event.typeMenu,
      ),
    );
  }

  _fetchMenuById(event, Emitter<AdminMenuEditState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));

      MenuModel menu = await MenuService().fetchMenuById(_id);
      _name = menu.name;

      emit(
        state.copyWith(
          id: menu.id,
          name: menu.name,
          price: menu.price,
          hpp: menu.hpp,
          status: Status.success,
          typeMenu: StringHelper.capitalize(menu.typeMenu),
          createdAt: menu.createdAt,
          updatedAt: menu.updatedAt,
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
        hpp: 0,
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
      String id = state.id!;
      String name = state.name!;
      int price = state.price!;
      String typeMenu = state.typeMenu!;
      final DateTime createdAt = state.createdAt!;
      final DateTime updatedAt = DateTime.now();
      int hpp = state.hpp!;

      MenuModel menuModel = MenuModel(
        id: id,
        name: name,
        typeMenu: typeMenu.toLowerCase(),
        price: price,
        createdAt: createdAt,
        updatedAt: updatedAt,
        hpp: hpp,
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

      MenuService().editMenu(menuModel);
      emit(
        state.copyWith(
          status: Status.success,
          message: 'Success Edit Menu',
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
