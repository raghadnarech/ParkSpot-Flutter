import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:park_spot/model/book.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookProvider with ChangeNotifier {
  Book? book;
  int? calculatedTime;
  bool? isLoadingparking = false;
  bool? _isLoadingextendparking = false;
  bool? _isLoadingendparking = false;

  Future<String> createBook(
      int hours, String? country, int? num_car, int? zone_id) async {
    isLoadingparking = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    http.Response response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/user/create_book_user_previous'),
        headers: {
          'Accept': 'application/json',
          'api_key': '123456789',
          'token': token!
        },
        body: {
          "hours": hours.toString(),
          "country": country,
          "num_car": num_car.toString(),
          "zone_id": zone_id.toString(),
        });
    dynamic data = jsonDecode(response.body);

    print(response.body);

    if (response.statusCode == 201) {
      notifyListeners();
      await prefs.setString("countrycarparking", country.toString());
      await prefs.setString("numcarparking", num_car.toString());
      await prefs.setString("idparking", data['data']['id'].toString());

      await getbook();
      isLoadingparking = false;
      notifyListeners();

      return '';
    }
    isLoadingparking = false;
    notifyListeners();
    return data['msg'];
  }

  Future<bool> getbook() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? country = prefs.getString('countrycarparking');
    String? numCar = prefs.getString('numcarparking');

    http.Response response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/user/Get_Book'),
      headers: {
        'Accept': 'application/json',
        'api_key': '123456789',
        'token': token!
      },
      body: {'num_car': numCar, 'country': country},
    );
    print(response.body);
    dynamic data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      dynamic bookfromdata = data['data'];
      book = await Book.fromJson(bookfromdata);
      notifyListeners();
      return true;
    } else {
      book = Book.empty();
      notifyListeners();
      return false;
    }
  }

  Future<String> extendParkingTime(int hours) async {
    _isLoadingextendparking = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    http.Response response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/user/Extend_ParkingTime'),
      headers: {
        'Accept': 'application/json',
        'api_key': '123456789',
        'token': token!
      },
      body: {
        "hours": hours.toString(),
        "book_id": book!.id.toString(),
      },
    );
    dynamic data = jsonDecode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      await getbook();
      _isLoadingextendparking = false;
      notifyListeners();
      return '';
    } else {
      _isLoadingextendparking = false;
      notifyListeners();
      return data['msg'];
    }
  }

  Future<dynamic> endPark() async {
    _isLoadingendparking = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("countrycarparking", '');
    await prefs.setString("numcarparking", '');
    String? id = prefs.getString('idparking');

    String? token = prefs.getString('token');
    http.Response response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/user/End_Booking'),
      headers: {
        'Accept': 'application/json',
        'api_key': '123456789',
        'token': token!
      },
      body: {
        "book_id": id,
      },
    );
    dynamic data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      notifyListeners();
      _isLoadingendparking = false;
      notifyListeners();
      return '';
    } else {
      _isLoadingendparking = false;
      notifyListeners();
      return data['msg'];
    }
  }

  get isLoadingextendparking => _isLoadingextendparking;
  get isLoadingendparking => _isLoadingendparking;
}
