import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/foundation.dart';

class UserModel {
  final String id;
  final String name;
  final String? photoURL;

  UserModel({required this.id, required this.name, this.photoURL});

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "photoURL": photoURL,
      };

  String toJson() => jsonEncode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'], name: map['name'], photoURL: map['photoURL']);
  }

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));
}
