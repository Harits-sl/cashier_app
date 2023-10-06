import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/core/utils/string_helper.dart';
import 'package:cashier_app/src/data/dataSources/remote/menu_service.dart';
import 'package:cashier_app/src/data/models/menu_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'edit_product_event.dart';
part 'edit_product_state.dart';

class EditProductBloc extends Bloc<EditProductEvent, EditProductState> {
  // String _id = '';
  // String _name = '';

  // set setId(String newValue) {
  //   _id = newValue;
  // }

  EditProductBloc() : super(const EditProductState()) {
    on<EditNameChanged>(_onNameChanged);
    on<EditPriceChanged>(_onPriceChanged);
    on<EditHppChanged>(_onHppChanged);
    on<EditTypeProductChanged>(_onTypeProductChanged);
    on<FetchProductById>(_fetchProductById);
    on<EditClearState>(_onClearState);
    on<ButtonEditProductPressed>(_buttonEditProductPressed);
  }

  void _onNameChanged(EditNameChanged event, Emitter<EditProductState> emit) {
    emit(
      state.copyWith(
        status: EditStatus.edit,
        name: event.name,
      ),
    );
  }

  void _onPriceChanged(EditPriceChanged event, Emitter<EditProductState> emit) {
    emit(
      state.copyWith(
        status: EditStatus.edit,
        price: event.price,
      ),
    );
  }

  void _onHppChanged(EditHppChanged event, Emitter<EditProductState> emit) {
    emit(
      state.copyWith(
        status: EditStatus.edit,
        hpp: event.hpp,
      ),
    );
  }

  void _onTypeProductChanged(
      EditTypeProductChanged event, Emitter<EditProductState> emit) {
    emit(
      state.copyWith(
        status: EditStatus.edit,
        typeMenu: event.typeProduct,
      ),
    );
  }

  _fetchProductById(event, Emitter<EditProductState> emit) async {
    try {
      emit(state.copyWith(status: EditStatus.loading));

      MenuModel menu = await MenuService().fetchMenuById(event.id);
      // _name = menu.name;

      emit(
        state.copyWith(
          id: menu.id,
          name: menu.name,
          price: menu.price,
          hpp: menu.hpp,
          status: EditStatus.successFetch,
          typeMenu: StringHelper.titleCase(menu.typeMenu),
          createdAt: menu.createdAt,
          updatedAt: menu.updatedAt,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: EditStatus.failed,
        ),
      );
    }
  }

  void _onClearState(EditClearState event, Emitter<EditProductState> emit) {
    emit(
      state.copyWith(
        id: '',
        name: '',
        typeMenu: '',
        price: 0,
        hpp: 0,
        status: EditStatus.initial,
        message: '',
      ),
    );
  }

  void _buttonEditProductPressed(
      ButtonEditProductPressed event, Emitter<EditProductState> emit) async {
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

      print('pencet edit');

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
            status: EditStatus.failed,
            message: 'Nama Menu Kosong',
          ),
        );
        throw Exception(state.message);
      }

      if (price == 0) {
        emit(
          state.copyWith(
            status: EditStatus.failed,
            message: 'Harga Menu Kosong',
          ),
        );
        throw Exception(state.message);
      }

      MenuService().editMenu(menuModel);
      emit(
        state.copyWith(
          status: EditStatus.successEdit,
          message: 'Success Edit Menu',
        ),
      );
    } catch (error) {
      debugPrint('error: $error');
      emit(
        state.copyWith(
          status: EditStatus.failed,
          message: error.toString(),
        ),
      );
    }
  }
}
