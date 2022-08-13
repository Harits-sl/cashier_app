import 'package:cashier_app/src/core/shared/theme.dart';
import 'package:cashier_app/src/presentation/features/add_menu/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonAddMenu extends StatelessWidget {
  const ButtonAddMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onPressed() {
      context.read<AddMenuBloc>().add(ButtonAddMenuPressed());
    }

    return Container(
      margin: const EdgeInsets.only(top: 14),
      child: TextButton(
        onPressed: _onPressed,
        style: TextButton.styleFrom(
          backgroundColor: blueColor,
          minimumSize: const Size(double.infinity, 0),
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
        ),
        child: Text(
          'Add Menu',
          style: whiteTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
