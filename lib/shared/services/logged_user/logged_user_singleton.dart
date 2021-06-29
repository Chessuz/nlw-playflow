import 'package:payflow/models/user_model.dart';

class LoggedUserSingleton {
  String? id;
  static LoggedUserSingleton? _instance;
  factory LoggedUserSingleton({String? id}) {
    _instance ??= LoggedUserSingleton._internalConstructor(id!);
    return _instance!;
  }
  LoggedUserSingleton._internalConstructor(this.id);
}
