import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  int? id;
  String? name;
  String? phone;
  String? password;
  User({this.id, this.name, this.password, this.phone});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        id: responseData['id'],
        name: responseData['name'],
        phone: responseData['phone'],
        password: responseData['password']);
  }
}
