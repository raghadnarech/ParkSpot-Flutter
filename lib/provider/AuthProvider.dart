import 'dart:async';
import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:park_spot/const/api_url.dart';
import 'package:park_spot/model/car.dart';
import 'package:park_spot/model/user.dart';
import 'package:park_spot/provider/CarProvider.dart';
import 'package:park_spot/utility/shared_prefrence.dart';
import 'package:park_spot/view/Splash/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final UserPrefrences userPrefrences;

class AuthProvider extends ChangeNotifier {
  User user = User();
  bool isLoadinglogin = false;
  bool isLoadingsignup = false;

  Future<bool> register(String name, String phone, String password) async {
    isLoadingsignup = true;
    notifyListeners();
    try {
      http.Response response = await http.post(
        Uri.parse('$local/$userRegister'),
        headers: {
          'Accept': 'application/json',
          'api_key': apiKey,
        },
        body: {'name': name, 'phone': phone, 'password': password},
      );
      print(response.body);

      if (response.statusCode == 201) {
        print(response.body);
        dynamic data = jsonDecode(response.body);
        await login(phone, password);
        isLoadingsignup = false;
        notifyListeners();
        return true;
      } else {
        isLoadingsignup = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isLoadingsignup = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> login(String? phone, String? password) async {
    isLoadinglogin = true;
    notifyListeners();
    try {
      http.Response response = await http.post(
        Uri.parse('$local/$userLogin'),
        headers: {
          'Accept': 'application/json',
          'api_key': apiKey,
        },
        body: {'phone': phone!, 'password': password!},
      );
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        await saveUser(User.fromJson(data['data']));
        isLoadinglogin = false;
        notifyListeners();
        return true;
      }
      isLoadinglogin = false;
      notifyListeners();
      return false;
    } catch (e) {
      isLoadinglogin = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', user.id!);
    prefs.setString('name', user.name!);
    prefs.setString('phone', user.phone!);
    prefs.setString('token', user.token!);
    prefs.setBool('isLogged', true);
    notifyListeners();
  }

  Future<void> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? name = prefs.getString('name');
    String? phone = prefs.getString('phone');
    String? token = prefs.getString('token');
    user = User(id: id, name: name, phone: phone, token: token);
    notifyListeners();
  }

  Future<void> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogged', false);
    prefs.remove('id');
    prefs.remove('name');
    prefs.remove('phone');
    prefs.setBool('isLogged', false);
  }
}
