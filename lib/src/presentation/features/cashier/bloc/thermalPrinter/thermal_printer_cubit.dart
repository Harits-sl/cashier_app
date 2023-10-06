import 'package:bloc/bloc.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';

// part 'thermal_printer_state.dart';

class ThermalPrinterCubit extends Cubit<dynamic> {
  ThermalPrinterCubit() : super(null);

  bool isConnected = false;
  BlueThermalPrinter? printer;
}
