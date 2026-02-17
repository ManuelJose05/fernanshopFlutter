import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/users_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersProvider with ChangeNotifier {
  Users? userLogued = null;
  bool loginFailed = false;
  bool isLoading = false;
  bool parametrosSinIntroducir = true;

  UsersProvider() {
    _comprobarUserLogueado();
  }

  void confirmarLogueoInvalido(){
    loginFailed = true;
    isLoading = false;
    notifyListeners();
  }

  void logoutAndRemove()async{
    isLoading = false;
    loginFailed = false;
    userLogued = null;
    final preferences = await SharedPreferences.getInstance();
    preferences.remove('userLogueado');
    notifyListeners();
  }

  void confirmarLogueo(Users? userFromRequest) async {
    isLoading = true;
    userLogued = userFromRequest;
    final preferences = await SharedPreferences.getInstance();
    String jsonUser = jsonEncode(userFromRequest!.toJson());
    await preferences.setString('userLogueado', jsonUser);
    notifyListeners();
  }

  void _comprobarUserLogueado() async {
    final preferences = await SharedPreferences.getInstance();
    String? jsonUser = preferences.getString('userLogueado');
    if (jsonUser != null) {
      userLogued = userFromJson(jsonUser);
    }
    notifyListeners();
  }
}
