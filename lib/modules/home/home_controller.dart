import 'package:flutter/material.dart';

class HomeController {
  var currentPage = 0;

  void setPage(int index) {
    currentPage = index;
  }

  void logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/login");
  }
}
