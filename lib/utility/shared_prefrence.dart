import 'dart:convert';

import 'package:park_spot/main.dart';
import 'package:park_spot/model/user.dart';
import 'package:park_spot/provider/AuthProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefrences {
  Future<void> saveUser(User user) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', user.id!);
    await prefs.setString('name', user.name!);
    await prefs.setString('phone', user.phone!);
    await prefs.setString('token', user.token!);
  }

  Future<User> getUser() async {
    prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? name = prefs.getString('name');
    String? phone = prefs.getString('phone');
    String? password = prefs.getString('password');

    return User(
      id: id,
      name: name,
      phone: phone,
    );
  }

  void removeUser() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove('name');
    prefs.remove('phone');
    prefs.remove('password');
  }
}
