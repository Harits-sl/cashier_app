import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:cashier_app/src/presentation/cubit/thermalPrinterCubit/thermal_printer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/pages/home_page.dart';

class SelectPrinterPage extends StatefulWidget {
  const SelectPrinterPage({Key? key}) : super(key: key);

  @override
  State<SelectPrinterPage> createState() => _SelectPrinterPageState();
}

class _SelectPrinterPageState extends State<SelectPrinterPage> {
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;
  // bool _connected = false;
  // bool _pressed = false;

  @override
  void initState() {
    super.initState();
    getDevices();
  }

  void getDevices() async {
    devices = await printer.getBondedDevices();
    setState(() {});
    print('ini deives $devices');
  }

  @override
  Widget build(BuildContext context) {
    Widget logo() {
      return Container(
        margin: const EdgeInsets.only(top: 35),
        width: 120,
        height: 120,
        color: const Color(0xffC4C4C4),
        child: const Center(
          child: Text('Logo'),
        ),
      );
    }

    Widget dropdown() {
      List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
        // if (devices.isEmpty) {
        //   items.add(const DropdownMenuItem(
        //     child: Text('Tidak ada yang dipilih'),
        //   ));
        // } else {
        //   devices.map((device) {
        //     items.add(DropdownMenuItem(
        //       child: Text(device.name!),
        //       value: device,
        //     ));
        //   });
        // }
        return devices.map((device) {
          return DropdownMenuItem(
            child: Text(device.name!),
            value: device,
          );
        }).toList();
      }

      return DropdownButton<BluetoothDevice>(
        hint: const Text('Select Thermal Printer'),
        items: _getDeviceItems(),
        onChanged: (device) {
          setState(() => selectedDevice = device);
          context.read<ThermalPrinterCubit>().isConnected = true;
        },
        value: selectedDevice,
      );
    }

    //   Future show(
    //     String message, {
    //      Duration duration= const Duration(seconds: 3),
    //     }) async {
    //   await Future.delayed(const Duration(milliseconds: 100));
    //  Scaffold.of(context).showSnackBar(
    //     SnackBar(
    //       content:Text(
    //         message,
    //        style:const TextStyle(
    //           color: Colors.white,
    //         ),
    //      ),
    //       duration: duration,
    //     ),
    //   );

    Widget buttonChoosePrinter() {
      void _connect() {
        print('ini deives $devices');

        printer.connect(selectedDevice!);
      }

      return ElevatedButton(
        onPressed: () {
          print('ini deives $devices');

          _connect();

          context.read<ThermalPrinterCubit>().printer = printer;
          Navigator.pop(context);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (BuildContext context) => HomePage(
          //           // printer: printer
          //           )),
          // );
        },
        child: const Text('Pilih Printer'),
      );
    }

    Widget body() {
      return SafeArea(
        child: Center(
          child: Column(
            children: [
              logo(),
              const SizedBox(height: 100),
              Column(
                children: [
                  dropdown(),
                  buttonChoosePrinter(),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: body(),
    );
  }
}
