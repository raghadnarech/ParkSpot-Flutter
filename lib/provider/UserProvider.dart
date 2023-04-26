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
  User user = User();
  int _defaultcar = 0;
  Wallet? wallet;

  int get defaultcar => _defaultcar;

  void setdefaultcar(int? defaultcar) {
    _defaultcar = defaultcar!;
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
    prefs.remove('password');
  }

  Future<void> getamount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    http.Response response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/user/Get_Amount'),
      headers: {
        'Accept': 'application/json',
        'api_key': '123456789',
        'token': token!
      },
    );
    dynamic data = await json.decode(response.body);

    // print(data);
    wallet = Wallet(amount: data['data']);

    _isLoading = false;
    // print(wallet!.amount);
    notifyListeners();
  }

  Future<void> getallCar_user() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    _isLoading = true;
    int i;

    http.Response response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/user/Get_Cars_User'),
      headers: {
        'Accept': 'application/json',
        'api_key': '123456789',
        'token': token!
      },
    );
    dynamic data = await json.decode(response.body);
    dynamic cars = data['data'];
    // print(cars);
    CarList = [];

    for (i = 0; i < cars.length; i++) {
      car = Car(
        Color: cars[i]['color'],
        Country: cars[i]['country'],
        NumCar: cars[i]['num_car'],
        Type: cars[i]['type'],
      );

      CarList.add(car!);
      // print(CarList);
    }

    _isLoading = false;

    notifyListeners();
  }

  Future<String> register_car(
      String country, String numCar, String type, String color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    http.Response response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/user/Create_Car'),
      headers: {
        'Accept': 'application/json',
        'api_key': '123456789',
        'token': token!
      },
      body: {
        'country': country,
        'num_car': numCar.toString(),
        'type': type,
        'color': color,
      },
    );
    print(response.body);
    dynamic data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 201) {
      return '';
    } else {
      return data['msg'];
    }
  }

  Future<void> delete_car(String? country, String? num_car) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    _isLoading = true;

    http.Response response = await http
        .post(Uri.parse('http://10.0.2.2:8000/api/user/Delete_Car'), headers: {
      'Accept': 'application/json',
      'api_key': '123456789',
      'token': token!
    }, body: {
      'country': country,
      'num_car': num_car
    });
    _isLoading = false;

    notifyListeners();
  }

  get isLoading {
    return _isLoading;
  }
}
