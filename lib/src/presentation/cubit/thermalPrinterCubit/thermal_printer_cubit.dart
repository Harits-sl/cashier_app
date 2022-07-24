import 'package:bloc/bloc.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:meta/meta.dart';

part 'thermal_printer_state.dart';

class ThermalPrinterCubit extends Cubit<ThermalPrinterState> {
  ThermalPrinterCubit() : super(ThermalPrinterInitial());

  bool isConnected = false;
  BlueThermalPrinter? printer;
}
