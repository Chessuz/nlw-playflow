import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:payflow/models/boleto_model.dart';
import 'package:payflow/shared/services/logged_user/logged_user_singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoletoListController {
  // final List<String> items;
  final boletosNotifier = ValueNotifier<List<BoletoModel>>(<BoletoModel>[]);
  List<BoletoModel> get boletos => boletosNotifier.value;
  set boletos(List<BoletoModel> value) => boletosNotifier.value = value;

  BoletoListController() {
    getBoletos();
  }

  Future<void> getBoletos() async {
    try {
      final loggedUser = LoggedUserSingleton();
      final keyBoletos = "boletos_${loggedUser.id}";
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList(keyBoletos) ?? <String>[];
      boletos = response.map((e) => BoletoModel.fromJson(e)).toList();
    } catch (e) {
      boletos = <BoletoModel>[];
    }
  }
}
