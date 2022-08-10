import 'package:bloc/bloc.dart';

import 'package:cashier_app/src/presentation/features/add_menu/index.dart';

class AddMenuCubit extends Cubit<AddMenuState> {
  AddMenuCubit() : super(AddMenuInitial());

  void addMenu() {}
}
