import 'dart:async';
import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:park_spot/const/api_url.dart';
import 'package:park_spot/model/car.dart';
import 'package:park_spot/model/user.dart';
import 'package:park_spot/provider/UserProvider.dart';
import 'package:park_spot/utility/shared_prefrence.dart';
import 'package:park_spot/view/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final UserPrefrences userPrefrences;

class AuthProvider extends ChangeNotifier {
  User? user;
  bool _isLoadinglogin = false;
  bool _isLoadingsignup = false;

  Future<String> register(String name, String phone, String password) async {
    _isLoadingsignup = true;
    notifyListeners();
    http.Response response = await http.post(
      Uri.parse('$local$userRegister'),
      headers: {
        'Accept': 'application/json',
        'api_key': apiKey,
      },
      body: {'name': name, 'phone': phone, 'password': password},
    );
    dynamic data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      _isLoadinglogin = false;
      notifyListeners();
      login(phone, password);
      return '';
    }
    _isLoadinglogin = false;
    notifyListeners();
    return data['msg'];
  }

  Future<String> login(String? phone, String? password) async {
    _isLoadinglogin = true;
    http.Response response = await http.post(
      Uri.parse('$local$userLogin'),
      headers: <String, String>{
        'Accept': 'application/json',
        'api_key': apiKey,
      },
      body: {'phone': phone!, 'password': password!},
    );
    dynamic data = json.decode(response.body);
    _isLoadinglogin = false;
    notifyListeners();

    if (response.statusCode == 200) {
      await saveUser(User.fromJson(data['data']));
      _isLoadinglogin = false;
      notifyListeners();
      return '';
    }
    _isLoadinglogin = false;
    notifyListeners();
    return data['msg'];
  }

  get isLoadingLogin {
    return _isLoadinglogin;
  }

  get isLoadingSignup {
    return _isLoadingsignup;
  }

  Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', user.id!);
    prefs.setString('name', user.name!);
    prefs.setString('phone', user.phone!);
    prefs.setString('token', user.token!);
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
}
