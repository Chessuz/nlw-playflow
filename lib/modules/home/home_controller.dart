import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeController {
  var currentPage = 0;

  void setPage(int index) {
    currentPage = index;
  }

  Future<void> logout(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    try {
      final response = await _googleSignIn.signOut();
      Navigator.pushReplacementNamed(context, "/login");
    } catch (error) {
      print("GoogleSignOut Erro $error");
    }
  }
}
