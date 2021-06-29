import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payflow/models/user_model.dart';
import 'package:payflow/shared/services/logged_user/logged_user_singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  UserModel? _user;

  UserModel get use => _user!;

  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      _user = user;
      saveUser(user);

      final loggedUser = LoggedUserSingleton(id: user.id);
      loggedUser.id = user.id;

      Navigator.pushReplacementNamed(context, "/home", arguments: user);
    } else {
      saveUser(UserModel(name: "", id: "", photoURL: ""));
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();

    if (user.id.isEmpty) {
      instance.remove("user");
    } else {
      await instance.setString("user", user.toJson());
    }
    return;
  }

  Future<void> currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));
    if (instance.containsKey("user")) {
      final response = instance.get("user") as String;
      setUser(context, UserModel.fromJson(response));
    } else {
      setUser(context, null);
    }
    return;
  }
}
