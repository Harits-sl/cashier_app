import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'thermal_printer_state.dart';

class ThermalPrinterCubit extends Cubit<ThermalPrinterState> {
  ThermalPrinterCubit() : super(ThermalPrinterInitial());
}
