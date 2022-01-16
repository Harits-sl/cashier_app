import 'src/config/theme/app_theme.dart';
import 'src/core/shared/theme.dart';

import 'src/presentation/cubit/homeCubit/home_cubit.dart';
import 'src/presentation/pages/home_page.dart';
import 'src/presentation/pages/select_printer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit(),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.light,
        home: const HomePage(),
      ),
    );
  }
}
