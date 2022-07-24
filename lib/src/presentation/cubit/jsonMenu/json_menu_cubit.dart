import 'package:bloc/bloc.dart';
import '../../../data/dataSources/local/json/menu_json_service.dart';
import '../../../data/models/menu_model.dart';
import 'package:equatable/equatable.dart';

part 'json_menu_state.dart';

class JsonMenuCubit extends Cubit<JsonMenuState> {
  JsonMenuCubit() : super(JsonMenuInitial());

  void getAllMenu() async {
    try {
      emit(JsonMenuLoading());

      List<MenuModel> menu = await MenuJsonService.readJson();

      emit(JsonMenuSuccess(menu));
    } catch (e) {
      emit(JsonMenuFailed(e.toString()));
    }
  }
}
