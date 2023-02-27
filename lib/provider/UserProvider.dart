import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:park_spot/model/car.dart';
import 'package:park_spot/model/user.dart';
import 'package:park_spot/model/wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  bool _isLoading = false;
  List<Car> CarList = [];
  Car? car;
  User _user = User();
  int _defaultcar = 0;
  Wallet? wallet;

  int get defaultcar => _defaultcar;

  void setdefaultcar(int? defaultcar) {
    _defaultcar = defaultcar!;
    notifyListeners();
  }

  User get user => _user;
  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', user.id!);
    prefs.setString('name', user.name!);
    prefs.setString('phone', user.phone!);
    prefs.setString('password', user.password!);
    notifyListeners();
  }

  Future<void> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    String? name = prefs.getString('name');
    String? phone = prefs.getString('phone');
    String? password = prefs.getString('password');

    _user = User(
      id: id,
      name: name,
      password: password,
      phone: phone,
    );
    notifyListeners();
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogged', false);
    prefs.remove('id');
    prefs.remove('name');
    prefs.remove('phone');
    prefs.remove('password');
  }

  Future<String> getphone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phone = prefs.getString('phone');
    return phone!;
  }

  Future<void> getamount() async {
    _isLoading = true;

    http.Response response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/getamount/${_user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    dynamic data = await json.decode(response.body);

    print(data);
    wallet = Wallet(amount: data);

    _isLoading = false;
    print(wallet!.amount);
    notifyListeners();
  }

  Future<void> getallCar_user() async {
    _isLoading = true;
    int i;

    http.Response response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/allcars_user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: await jsonEncode(<String, String>{'user_id': user.id.toString()}),
    );
    dynamic data = await json.decode(response.body);
    CarList = [];

    for (i = 0; i < data.length; i++) {
      car = Car(
        id: data[i]['id'],
        Color: data[i]['Color'],
        Country: data[i]['Country'],
        NumCar: data[i]['NumCar'],
        Type: data[i]['Type'],
      );

      CarList.add(car!);
      print(CarList);
    }

    _isLoading = false;

    notifyListeners();
  }

  Future<void> register_car(
      String country, String numCar, String type, String color) async {
    _isLoading = true;
    // await Future.delayed(Duration(seconds: 10));
    http.Response response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/addcars'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: await jsonEncode(<String, String>{
        'Country': country,
        'NumCar': numCar,
        'Type': type,
        'Color': color,
        'user_id': user.id.toString()
      }),
    );
    print(color);
    print(numCar);
    print(type);
    print(country);
    // dynamic data = await jsonDecode(response.body);

    _isLoading = false;

    notifyListeners();
  }

  Future<void> delete_car(int index) async {
    _isLoading = true;

    http.Response response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/deletecar/${CarList[index].id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    _isLoading = false;

    notifyListeners();
  }

  get isLoading {
    return _isLoading;
  }
}
