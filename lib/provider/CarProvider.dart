import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:park_spot/const/api_url.dart';
import 'package:park_spot/model/car.dart';
import 'package:park_spot/model/user.dart';
import 'package:park_spot/model/wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CarProvider with ChangeNotifier {
  bool isLoadinggetallcar = false;
  bool isLoadingregistercar = false;
  bool isLoadingdeletecar = false;
  List<Car> CarList = [];
  Car? car;
  int _defaultcar = 0;

  int get defaultcar => _defaultcar;

  void setdefaultcar(int? defaultcar) {
    _defaultcar = defaultcar!;
    notifyListeners();
  }

  Future<bool> getallCar_user() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    isLoadinggetallcar = true;
    notifyListeners();
    int i;
    try {
      http.Response response = await http.get(
        Uri.parse('$local/user/Get_Cars_User'),
        headers: {
          'Accept': 'application/json',
          'api_key': '123456789',
          'token': token!
        },
      );
      if (response.statusCode == 200) {
        CarList = [];
        dynamic data = await json.decode(response.body);
        dynamic cars = data['data'];
        for (var i in cars) {
          car = Car.fromJson(i);
          CarList.add(car!);
        }
        isLoadinggetallcar = false;
        notifyListeners();
        return true;
      } else {
        isLoadinggetallcar = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isLoadinggetallcar = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register_car(
      String country, String numCar, String type, String color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(token);
    isLoadingregistercar = true;
    notifyListeners();

    try {
      http.Response response = await http.post(
        Uri.parse('$local/user/Create_Car'),
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
      if (response.statusCode == 201) {
        dynamic data = jsonDecode(response.body);
        isLoadingregistercar = false;
        notifyListeners();
        return true;
      } else {
        isLoadingregistercar = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e.toString());
      isLoadingregistercar = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> delete_car(String? country, String? num_car) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    isLoadingdeletecar = true;

    try {
      http.Response response = await http
          .post(Uri.parse('$local/user/Delete_Car'), headers: {
        'Accept': 'application/json',
        'api_key': '123456789',
        'token': token!
      }, body: {
        'country': country,
        'num_car': num_car
      });
      if (response.statusCode == 200) {
        isLoadingdeletecar = false;
        notifyListeners();
        return true;
      } else {
        isLoadingdeletecar = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isLoadingdeletecar = false;
      notifyListeners();
      return false;
    }
  }
}
