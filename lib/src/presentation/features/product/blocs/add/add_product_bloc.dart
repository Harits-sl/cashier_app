import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cashier_app/src/data/dataSources/remote/menu_service.dart';
import 'package:cashier_app/src/data/models/menu_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc() : super(const AddProductState()) {
    on<NameChanged>(_onNameChanged);
    on<PriceChanged>(_onPriceChanged);
    on<HppChanged>(_onHppChanged);
    on<TypeProductChanged>(_onTypeProductChanged);
    on<ButtonAddProductPressed>(_onButtonProductPressed);
    on<ClearState>(_onClearState);
  }

  void _onNameChanged(NameChanged event, Emitter<AddProductState> emit) {
    emit(
      state.copyWith(
        name: event.name,
      ),
    );
  }

  void _onPriceChanged(PriceChanged event, Emitter<AddProductState> emit) {
    emit(
      state.copyWith(
        price: event.price,
      ),
    );
  }

  void _onHppChanged(HppChanged event, Emitter<AddProductState> emit) {
    emit(
      state.copyWith(
        hpp: event.hpp,
      ),
    );
  }

  void _onTypeProductChanged(
      TypeProductChanged event, Emitter<AddProductState> emit) {
    emit(
      state.copyWith(
        typeProduct: event.typeProduct,
      ),
    );
  }

  void _onButtonProductPressed(
      ButtonAddProductPressed event, Emitter<AddProductState> emit) async {
    try {
      // emit(AddProductLoading());

      String id = 'menu-${Random().nextInt(255)}';
      String name = state.name;
      int price = state.price;
      String typeProduct = state.typeProduct;
      final DateTime createdAt = DateTime.now();
      final DateTime updatedAt = DateTime.now();
      int hpp = state.hpp;

      MenuModel menuModel = MenuModel(
        id: id,
        name: name,
        typeMenu: typeProduct.toLowerCase(),
        price: price,
        createdAt: createdAt,
        updatedAt: updatedAt,
        hpp: hpp,
      );

      if (name == '') {
        emit(
          state.copyWith(
            status: Status.failed,
            message: 'Nama Produk Kosong',
          ),
        );
        throw Exception(state.message);
      }

      if (price == 0) {
        emit(
          state.copyWith(
            status: Status.failed,
            message: 'Harga Produk Kosong',
          ),
        );
        throw Exception(state.message);
      }

      if (hpp == 0) {
        emit(
          state.copyWith(
            status: Status.failed,
            message: 'hpp Produk Kosong',
          ),
        );
        throw Exception(state.message);
      }

      MenuService().addMenu(menuModel);
      emit(
        state.copyWith(
          status: Status.success,
          message: 'Success Add Product',
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

  void _onClearState(ClearState event, Emitter<AddProductState> emit) {
    emit(
      state.copyWith(
        name: '',
        typeProduct: '',
        price: 0,
        hpp: 0,
        status: Status.initial,
        message: '',
      ),
    );
  }
}
