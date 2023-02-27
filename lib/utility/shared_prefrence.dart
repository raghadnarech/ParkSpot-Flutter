import 'dart:convert';

import 'package:park_spot/model/user.dart';
import 'package:park_spot/provider/AuthProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefrences {
  Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', user.id!);
    prefs.setString('name', user.name!);
    prefs.setString('phone', user.phone!);
    prefs.setString('password', user.password!);
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? name = prefs.getString('name');
    String? phone = prefs.getString('phone');
    String? password = prefs.getString('password');

    return User(
      id: id,
      name: name,
      password: password,
      phone: phone,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('name');
    prefs.remove('phone');
    prefs.remove('password');
  }

  Future<String> getphone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phone = prefs.getString('phone');
    return phone!;
  }
}
