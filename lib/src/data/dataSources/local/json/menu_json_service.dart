import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../models/menu_model.dart';

class MenuJsonService {
  static Future<dynamic> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/menus.json');
    final data = await json.decode(response);

    List<MenuModel> listMenu = data['menus']
        .map<MenuModel>((item) => MenuModel.fromJSon(item))
        .toList();
    return listMenu;
  }
}
