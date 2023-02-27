import 'dart:async';
import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:park_spot/model/car.dart';
import 'package:park_spot/model/user.dart';
import 'package:park_spot/provider/UserProvider.dart';
import 'package:park_spot/utility/shared_prefrence.dart';
import 'package:park_spot/view/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final UserPrefrences userPrefrences;

class AuthProvider extends ChangeNotifier {
  String? _phone;
  User? user;
  bool _isLoading = false;
  List<Car> CarList = [];
  Car? car;

  setphone(String phone) {
    _phone = phone;
    notifyListeners();
  }

  get phonenumber {
    return _phone;
  }

  Future<void> register(String name, String phone, String password) async {
    _isLoading = true;
    // await Future.delayed(Duration(seconds: 10));
    http.Response response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/addusers'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: await jsonEncode(
          <String, String>{'name': name, 'phone': phone, 'password': password}),
    );
    dynamic data = jsonDecode(response.body);
    int id = data['user-id'];
    print(id);
    _isLoading = false;
    user = User(
      id: id,
      name: name,
      password: password,
      phone: phone,
    );
    await userProvider!.saveUser(user!);

    userProvider!.setUser(user!);
    notifyListeners();
  }

  get isLoading {
    return _isLoading;
  }

  Future<String> login(String? phone, String? password) async {
    _isLoading = true;
    int i;

    http.Response response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/Login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: await jsonEncode(
          <String, String>{'phone': phone!, 'password': password!}),
    );
    if (response.body == "The number is not registered") {
      _isLoading = false;

      return "The number is not registered";
    } else if (response.body == "The number or password is incorrect") {
      _isLoading = false;

      return "The number or password is incorrect";
    } else {
      var data = await json.decode(response.body);

      await saveUser(User.fromJson(data[0]));
      _isLoading = false;
      notifyListeners();
      return "";
    }
  }

  Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', user.id!);
    prefs.setString('name', user.name!);
    prefs.setString('phone', user.phone!);
    prefs.setString('password', user.password!);
    notifyListeners();
  }

  get username {
    return user!.name.toString();
  }

  Future<void> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? name = prefs.getString('name');
    String? phone = prefs.getString('phone');
    String? password = prefs.getString('password');

    user = User(
      id: id,
      name: name,
      password: password,
      phone: phone,
    );
    notifyListeners();
  }
}
