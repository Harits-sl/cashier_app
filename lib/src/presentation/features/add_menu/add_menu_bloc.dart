import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/data/dataSources/remote/menu_service.dart';
import 'package:cashier_app/src/data/models/menu_model.dart';
import 'package:flutter/material.dart';
import 'index.dart';

class AddMenuBloc extends Bloc<AddMenuEvent, AddMenuState> {
  AddMenuBloc() : super(const AddMenuState()) {
    on<NameChanged>(_onNameChanged);
    on<PriceChanged>(_onPriceChanged);
    on<TypeMenuChanged>(_onTypeMenuChanged);
    on<ButtonAddMenuPressed>(_onButtonMenuPressed);
  }

  void _onNameChanged(NameChanged event, Emitter<AddMenuState> emit) {
    emit(
      state.copyWith(
        name: event.name,
      ),
    );
    debugPrint('name: ${state.name}');
  }

  void _onPriceChanged(PriceChanged event, Emitter<AddMenuState> emit) {
    emit(
      state.copyWith(
        price: event.price,
      ),
    );
  }

  void _onTypeMenuChanged(TypeMenuChanged event, Emitter<AddMenuState> emit) {
    emit(
      state.copyWith(
        typeMenu: event.typeMenu,
      ),
    );
    debugPrint('type: ${state.typeMenu}');
  }

  void _onButtonMenuPressed(
      ButtonAddMenuPressed event, Emitter<AddMenuState> emit) async {
    try {
      // emit(AddMenuLoading());

      String id = 'menu-${Random().nextInt(255)}';
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
