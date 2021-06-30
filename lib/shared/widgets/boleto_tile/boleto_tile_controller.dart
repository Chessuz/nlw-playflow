import 'dart:convert';

import 'package:payflow/models/boleto_model.dart';
import 'package:payflow/shared/services/logged_user/logged_user_singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoletoTileController {
  Future<void> deleteBoleto(BoletoModel boleto) async {
    final loggedUser = LoggedUserSingleton();
    final keyBoletos = "boletos_${loggedUser.id}";
    final instance = await SharedPreferences.getInstance();
    final boletos = instance.getStringList(keyBoletos) ?? <String>[];
    boletos.removeWhere((e) {
      final obj = jsonDecode(e);
      return obj['hash'] == boleto.hashCode;
    });
    await instance.setStringList(keyBoletos, boletos);
    return;
  }
}
